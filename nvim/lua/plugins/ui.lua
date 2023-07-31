local M = {
    {
        "zanglg/nova.nvim",
        opts = {
            theme = "dark",
        },
    },
    {
        "stevearc/dressing.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
        config = function()
            require("dressing").setup({
                input = {
                    border = "rounded",
                    win_options = { winblend = 0 },
                },
                select = {
                    backend = { "builtin" },
                    builtin = {
                        border = "rounded",
                        win_options = { winblend = 0 },
                    },
                },
            })
        end,
    },
    {
        "levouh/tint.nvim",
        event = "WinNew",
        config = function()
            require("tint").setup({
                highlight_ignore_patterns = { "WinSeparator" },
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = { view = "cmdline" },
            presets = { lsp_doc_border = true },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
}

return M
