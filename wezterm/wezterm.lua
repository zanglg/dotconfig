local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "nova"
config.font = wezterm.font("Monaspace Neon")
config.use_fancy_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

local osconfig = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    osconfig = require("windows")
elseif wezterm.target_triple == "x86_64-apple-darwin" then
    osconfig = require("macos")
end
for k, v in pairs(osconfig) do
    config[k] = v
end

return config
