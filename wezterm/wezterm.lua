local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Plugins
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

-- ─── Font ─────────────────────────────────────────────────────────────────────
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17.0
config.line_height = 1.15

-- ─── Colors ───────────────────────────────────────────────────────────────────
config.color_scheme = "Catppuccin Mocha"

-- ─── Tab bar ──────────────────────────────────────────────────────────────────
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Show workspace name in the tab bar status
wezterm.on("update-right-status", function(window, _pane)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = "  " .. window:active_workspace() .. "  " },
	}))
end)

-- ─── macOS ────────────────────────────────────────────────────────────────────
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- ─── Window ───────────────────────────────────────────────────────────────────
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- ─── Workspace auto-save ──────────────────────────────────────────────────────

-- Periodic auto-save every 5 minutes
resurrect.state_manager.periodic_save({ interval_seconds = 300, save_workspaces = true, save_windows = true })

-- Save state when a workspace is switched to or newly created
wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, _pane, workspace)
	resurrect.workspace_state.restore_workspace(
		resurrect.state_manager.load_state(workspace, "workspace"),
		{ window = window:mux_window(), relative = true, restore_text = true }
	)
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, _pane, workspace)
	local state = resurrect.workspace_state.get_workspace_state()
	resurrect.state_manager.save_state(state)
end)

-- Save state when a window is closed
wezterm.on("window-close-proposed", function(window, _pane)
	resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
	return false
end)

-- ─── Leader key ───────────────────────────────────────────────────────────────
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1500 }

-- ─── Key bindings ─────────────────────────────────────────────────────────────
config.keys = {
	-- Existing: scroll
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByLine(-1) },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByLine(1) },
	-- Existing: ctrl+tab escape sequence
	{ key = "Tab", mods = "CTRL", action = wezterm.action.SendString("\x1b[9;5u") },

	-- ── Workspace ──────────────────────────────────────────────────────────────
	-- LEADER + s  →  fuzzy-switch workspace (uses zoxide if available)
	{
		key = "s",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	-- LEADER + n  →  prompt for a new named workspace
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "New workspace name:",
			action = wezterm.action_callback(function(window, _pane, name)
				if name and #name > 0 then
					window:perform_action(wezterm.action.SwitchToWorkspace({ name = name }), _pane)
				end
			end),
		}),
	},
	-- LEADER + S  →  manually save current workspace state
	{
		key = "S",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, _pane)
			local state = resurrect.workspace_state.get_workspace_state()
			resurrect.state_manager.save_state(state)
			wezterm.toast_notification("WezTerm", "Workspace state saved!", nil, 2000)
		end),
	},
	-- LEADER + r  →  fuzzy-pick a saved workspace state and restore it
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, _pane)
			resurrect.fuzzy_loader.fuzzy_load(window, _pane, function(id, label)
				local type = string.match(id, "^([^/]+)")
				id = string.match(id, "([^/]+)$")
				id = string.match(id, "(.+)%..+$")
				local state = resurrect.state_manager.load_state(id, type)
				if type == "workspace" then
					resurrect.workspace_state.restore_workspace(state, {
						window = window:mux_window(),
						relative = true,
						restore_text = true,
					})
				elseif type == "window" then
					resurrect.window_state.restore_window(state, {
						window = window:mux_window(),
						relative = true,
					})
				elseif type == "tab" then
					resurrect.tab_state.restore_tab(state, window:active_tab())
				end
			end)
		end),
	},
	-- LEADER + p  →  switch to previous workspace
	{
		key = "p",
		mods = "LEADER",
		action = workspace_switcher.switch_to_prev_workspace(),
	},
}

-- ─── Mouse bindings ───────────────────────────────────────────────────────────
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

return config
