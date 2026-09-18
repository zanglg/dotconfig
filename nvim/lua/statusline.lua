-- Load after the Nova colorscheme has been configured.
local nova_config = require("nova.config")
local status_colors = require("nova.colors").setup(nova_config.options, nova_config.resolve_theme())
local mode_colors = {
    n = status_colors.blue,
    i = status_colors.green,
    v = status_colors.violet,
    V = status_colors.violet,
    ["\22"] = status_colors.violet,
    s = status_colors.violet,
    S = status_colors.violet,
    ["\19"] = status_colors.violet,
    R = status_colors.red,
    c = status_colors.yellow,
    t = status_colors.teal,
}

require("lualine").setup({
    options = {
        theme = "nova",
        globalstatus = true,
        component_separators = { left = "•", right = "•" },
        section_separators = "",
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            -- Left: application, mode, file and branch.
            {
                function()
                    return " NVIM"
                end,
                color = { fg = status_colors.background, bg = status_colors.blue, gui = "bold" },
                separator = { right = "" },
                padding = 1,
            },
            {
                "mode",
                color = function()
                    local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                    return { fg = mode_colors[mode] or status_colors.blue, gui = "bold" }
                end,
            },
            {
                "filename",
                file_status = true,
                path = 0,
                separator = "",
                color = function()
                    return { fg = vim.bo.modified and status_colors.yellow or status_colors.foreground }
                end,
            },
            {
                "branch",
                -- Keep the leading dot with the branch so both hide outside Git.
                icon = "• ",
                color = { fg = status_colors.violet },
                separator = "",
                padding = { left = 0, right = 1 },
            },
            {
                -- A second alignment point gives dynamic content its own middle area.
                function()
                    return "%="
                end,
                separator = "",
                padding = 0,
            },
            -- Middle: transient activity, changes, diagnostics and LSP status.
            {
                function()
                    local register = vim.fn.reg_recording()
                    return register ~= "" and ("REC @" .. register) or ""
                end,
                icon = "",
                color = { fg = status_colors.red, gui = "bold" },
            },
            {
                "searchcount",
                icon = "",
                maxcount = 9999,
                timeout = 20,
                color = { fg = status_colors.match },
            },
            {
                "diff",
                -- Reuse gitsigns' live buffer counts without running Git on redraw.
                source = function()
                    local status = vim.b.gitsigns_status_dict
                    if status then
                        return {
                            added = status.added,
                            modified = status.changed,
                            removed = status.removed,
                        }
                    end
                end,
                symbols = { added = " ", modified = " ", removed = " " },
                diff_color = {
                    added = { fg = status_colors.green },
                    modified = { fg = status_colors.yellow },
                    removed = { fg = status_colors.red },
                },
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = { error = " ", warn = " " },
                diagnostics_color = {
                    error = { fg = status_colors.red },
                    warn = { fg = status_colors.yellow },
                },
            },
            {
                "lsp_status",
                icon = "",
                -- Show a spinner only while the server reports work; no idle checkmark.
                symbols = { done = "" },
                color = { fg = status_colors.teal },
                cond = function()
                    return vim.o.columns >= 100
                end,
            },
        },
        -- Right: exceptional file formats, filetype and cursor position.
        lualine_x = {
            {
                "encoding",
                cond = function()
                    local encoding = vim.bo.fileencoding
                    return encoding ~= "" and encoding ~= "utf-8"
                end,
                color = { fg = status_colors.yellow },
            },
            {
                "fileformat",
                icons_enabled = false,
                fmt = function(format)
                    return ({ unix = "LF", dos = "CRLF", mac = "CR" })[format] or format
                end,
                cond = function()
                    return vim.bo.fileformat ~= "unix"
                end,
                color = { fg = status_colors.yellow },
            },
            {
                "filetype",
                icons_enabled = true,
                colored = true,
                color = { fg = status_colors.foreground },
            },
            {
                "location",
                icon = "",
                color = { fg = status_colors.foreground },
                separator = "",
                padding = { left = 1, right = 2 },
            },
        },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "quickfix", "nvim-tree" },
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    group = vim.api.nvim_create_augroup("config-statusline", { clear = true }),
    callback = function()
        -- RecordingLeave fires before reg_recording() is cleared.
        vim.schedule(function()
            require("lualine").refresh({ place = { "statusline" } })
        end)
    end,
})
