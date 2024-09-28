local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- color scheme
config.color_scheme = "nova"

-- font
config.font_size = 18.0
config.font = wezterm.font_with_fallback({
    { family = "Monaspace Argon" },
    { family = "LXGW WenKai" },
})
config.harfbuzz_features = {
    "calt=0",
    "liga=1",
    "ss01=1",
    "ss02=1",
    "ss03=1",
    "ss04=1",
    "ss05=1",
    "ss06=1",
    "ss07=1",
    "ss08=1",
    "ss09=1",
}

-- tabbar
config.use_fancy_tab_bar = false
wezterm.on("update-right-status", function(window, pane)
    window:set_left_status(wezterm.format({
        { Text = wezterm.pad_right("  ", 4) },
    }))

    -- figure out a way to center it
    window:set_right_status(wezterm.format({
        { Text = " " .. pane:get_title() .. " " },
    }))
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _)
    return {
        { Text = " " .. tab.tab_index + 1 .. " " },
    }
end)

-- windows appearance
config.initial_rows = 36
config.initial_cols = 120
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- key bindings
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = act({ PasteFrom = "Clipboard" }),
    },
}

-- windows override
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- font
    config.font_size = 12.0
    config.font = wezterm.font_with_fallback({
        { family = "Monaspace Argon", weight = "Medium" },
        { family = "LXGW WenKai Screen" },
    })

    -- windows appearance
    config.window_background_opacity = 1.0
    config.window_decorations = "RESIZE"

    -- terminal
    config.default_prog = { "powershell" }
end

return config
