local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "nova"
config.font = wezterm.font("MonaspiceAr Nerd Font")
config.font_size = 14.0
config.use_fancy_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

return config
