local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17.0
config.line_height = 1.15

-- Color scheme: Catppuccin Mocha
config.color_scheme = "Catppuccin Mocha"

-- Tab bar configuration
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Tab bar styling
config.colors = {
	tab_bar = {
		background = "#11111B",
		active_tab = {
			bg_color = "#CBA6F7",
			fg_color = "#11111B",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#181825",
			fg_color = "#CDD6F4",
		},
		inactive_tab_hover = {
			bg_color = "#313244",
			fg_color = "#CDD6F4",
		},
		new_tab = {
			bg_color = "#181825",
			fg_color = "#CDD6F4",
		},
		new_tab_hover = {
			bg_color = "#313244",
			fg_color = "#CDD6F4",
		},
	},
}

-- macOS specific settings
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Window settings
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- Tab title format (similar to kitty's template)
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	-- Extract last part of path similar to kitty's template
	local tab_title = title:match("([^/]+)$") or title
	return string.format(" %d: %s ", tab.tab_index + 1, tab_title)
end)

-- Key bindings
config.keys = {
	-- Scroll up (kitty: kitty_mod+k)
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ScrollByLine(-1),
	},
	-- Scroll down (kitty: kitty_mod+j)
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ScrollByLine(1),
	},
	-- Ctrl+Tab sends escape sequence (matching kitty's ctrl+tab mapping)
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[9;5u"),
	},
}

-- Mouse bindings
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

return config
