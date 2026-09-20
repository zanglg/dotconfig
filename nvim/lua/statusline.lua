-- Use one quiet surface for the whole statusline. Color is reserved for
-- semantic information such as diagnostics and Git changes.
local nova_config = require("nova.config")
local colors = require("nova.colors").setup(nova_config.options, nova_config.resolve_theme())
-- Nova uses `selection` as the shared flat status/tab-bar surface. It matches
-- the tmux and WezTerm bars, and the original lualine `c` section.
local surface = colors.selection

local function flat_sections(foreground)
    return {
        a = { fg = foreground, bg = surface },
        b = { fg = foreground, bg = surface },
        c = { fg = foreground, bg = surface },
    }
end

local flat_theme = {
    normal = flat_sections(colors.comment),
    insert = flat_sections(colors.comment),
    visual = flat_sections(colors.comment),
    replace = flat_sections(colors.comment),
    command = flat_sections(colors.comment),
    terminal = flat_sections(colors.comment),
    inactive = flat_sections(colors.inconspicuous),
}

-- Keep the bar flat; only the mode label changes foreground color.
local mode_colors = {
    n = colors.blue,
    i = colors.green,
    v = colors.yellow,
    V = colors.yellow,
    ["\22"] = colors.yellow,
    s = colors.yellow,
    S = colors.yellow,
    ["\19"] = colors.yellow,
    R = colors.red,
    c = colors.purple,
    t = colors.violet,
}

local function mode_color()
    local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
    return { fg = mode_colors[mode] or colors.foreground, bg = surface, gui = "bold" }
end

require("lualine").setup({
    options = {
        theme = flat_theme,
        icons_enabled = false,
        -- Match the U+2022 bullet used by the tmux and WezTerm bars.
        component_separators = "•",
        section_separators = "",
        globalstatus = true,
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            { "mode", color = mode_color },
            "branch",
            "diff",
            {
                "diagnostics",
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            },
            { "filename", color = { fg = colors.foreground, bg = surface } },
        },
        lualine_x = {
            {
                "encoding",
                fmt = string.upper,
                cond = function()
                    local encoding = vim.bo.fileencoding
                    return encoding ~= "" and encoding:lower() ~= "utf-8"
                end,
            },
            {
                "fileformat",
                fmt = function(format)
                    return ({ unix = "LF", dos = "CRLF", mac = "CR" })[format] or format
                end,
                cond = function()
                    return vim.bo.fileformat ~= "unix"
                end,
            },
            "filetype",
            "progress",
            "location",
        },
        lualine_y = {},
        lualine_z = {},
    },
})
