local M = {
    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-navic").setup({
                lsp = {
                    auto_attach = true,
                    highlight = true,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    globalstatus = true,
                },
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                        },
                        {
                            "navic",
                        },
                    },
                },
                extensions = { "quickfix", "nvim-tree", "symbols-outline" },
            })
        end,
    },
}

return M
