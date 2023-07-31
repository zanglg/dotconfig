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
                border = "rounded",
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
        "smoka7/multicursors.nvim",
        opts = {},
        keys = {
            { "<Leader>ms", "<cmd>MCstart<cr>", desc = "Select Cursor Word" },
            { "<Leader>mp", "<cmd>MCpattern<cr>", desc = "Select Patterns" },
            { "<Leader>mv", "<cmd>MCvisualPattern<cr>", desc = "Select Visual Patterns" },
            { "<Leader>mu", "<cmd>MCunderCursor<cr>", desc = "Select Cursor Char" },
            { "<Leader>mc", "<cmd>MCclear<cr>", desc = "Select Clear" },
        },
    },
}
