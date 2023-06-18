return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        ft = { "md", "markdown" },
        keys = {
            { "<leader>tk", "<cmd>Glow<cr>", desc = "Toggle Markdown Preview" },
        },
        config = function()
            require("glow").setup({
                border = "single",
            })
        end,
    },
    {
        "lewis6991/spaceless.nvim",
        event = "InsertEnter",
        config = function()
            require("spaceless").setup()
        end,
    },
    {
        "abecodes/tabout.nvim",
        event = "InsertEnter",
        config = function()
            require("tabout").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { mode = "quickfix" },
        keys = {
            { "q", "<cmd>TroubleToggle<cr>", desc = "Quickfix Toggle" },
        },
    },
    {
        "folke/todo-comments.nvim",
        cmd = "TodoTrouble",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            search = {
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--follow",
                },
            },
        },
        keys = {
            { "<leader>fT", "<cmd>TodoTrouble<cr>", desc = "Find Todos" },
        },
    },
}
