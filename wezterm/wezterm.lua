local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold" })
config.font_size = 17.0

config.enable_tab_bar = false
config.freetype_render_target = "HorizontalLcd"
-- config.window_padding = {
-- 	left = "0",
-- 	right = "0",
-- 	top = "0",
-- 	bottom = "0",
-- }
config.freetype_load_target = "Normal"
return config
