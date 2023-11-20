local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Apperence
config.color_scheme = "One Dark (Gogh)"
config.font = wezterm.font("Monaspace Neon")

local function is_found(str, pattern)
    return string.find(str, pattern) ~= nil
end

local function platform()
    return {
        is_win = is_found(wezterm.target_triple, "windows"),
        is_linux = is_found(wezterm.target_triple, "linux"),
        is_mac = is_found(wezterm.target_triple, "apple"),
    }
end
config.font_size = platform().is_mac and 22 or 16

return config
