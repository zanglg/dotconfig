local wezterm = require("wezterm")
local M = {}

-- Match the Nova status bars in Neovim and tmux without changing terminal colors.
local colors = {
    bg = "#2d354e",
    fg = "#b6bac9",
    muted = "#6c7693",
}

local function tab_title(tab)
    if tab.tab_title and tab.tab_title ~= "" then
        return tab.tab_title
    end

    local pane = tab.active_pane
    local cwd = pane.current_working_dir
    if cwd and cwd.file_path then
        local path = cwd.file_path:gsub("\\", "/"):gsub("/+$", "")
        return path:match("([^/]+)$") or "/"
    end

    return pane.title ~= "" and pane.title or "shell"
end

local function format_tab(tab, tabs, _, _, hover, max_width)
    local prefix = " " .. (tab.tab_index + 1) .. " "
    local suffix = tab.tab_index < #tabs - 1 and " •" or " "
    local available = max_width - wezterm.column_width(prefix .. suffix)
    local title = tab_title(tab):gsub("%c", " ")

    -- Reserve space for the index and separator, including in narrow windows.
    if available < 1 then
        prefix = wezterm.truncate_right(tostring(tab.tab_index + 1), math.max(0, max_width))
        title, suffix = "", ""
    elseif wezterm.column_width(title) > available then
        title = wezterm.truncate_right(title, available - 1) .. "…"
    end

    return {
        { Background = { Color = colors.bg } },
        { Foreground = { Color = (tab.is_active or hover) and colors.fg or colors.muted } },
        { Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
        { Text = prefix .. title },
        { Foreground = { Color = colors.muted } },
        { Attribute = { Intensity = "Normal" } },
        { Text = suffix },
    }
end

function M.apply_to_config(config)
    config.enable_tab_bar = true
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = false
    config.show_new_tab_button_in_tab_bar = true
    config.show_tab_index_in_tab_bar = false
    config.tab_max_width = 28
    config.colors = config.colors or {}
    config.colors.tab_bar = {
        background = colors.bg,
        inactive_tab_edge = colors.bg,
        active_tab = { bg_color = colors.bg, fg_color = colors.fg, intensity = "Bold" },
        inactive_tab = { bg_color = colors.bg, fg_color = colors.muted },
        inactive_tab_hover = { bg_color = colors.bg, fg_color = colors.fg },
        new_tab = { bg_color = colors.bg, fg_color = colors.muted },
        new_tab_hover = { bg_color = colors.bg, fg_color = colors.fg, intensity = "Bold" },
    }

    wezterm.on("format-tab-title", format_tab)
    wezterm.on("update-right-status", function(window)
        -- The tab bar already identifies WezTerm; avoid a redundant app label.
        window:set_left_status("")

        local workspace = window:active_workspace():gsub("%c", " ")
        if workspace == "default" then
            window:set_right_status("")
            return
        end
        if wezterm.column_width(workspace) > 24 then
            workspace = wezterm.truncate_right(workspace, 23) .. "…"
        end
        window:set_right_status(wezterm.format({
            { Background = { Color = colors.bg } },
            { Foreground = { Color = colors.muted } },
            { Attribute = { Intensity = "Normal" } },
            { Text = " • [" },
            { Foreground = { Color = colors.fg } },
            { Attribute = { Intensity = "Bold" } },
            { Text = workspace },
            { Foreground = { Color = colors.muted } },
            { Attribute = { Intensity = "Normal" } },
            { Text = "]  " },
        }))
    end)
end

return M
