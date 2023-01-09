local M = {
    "zanglg/nova.nvim",
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
                    border = "single",
                    win_options = { winblend = 0 },
                },
                select = {
                    backend = { "builtin" },
                    builtin = {
                        border = "single",
                        win_options = { winblend = 0 },
                    },
                },
            })
        end,
    },
}

return M