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
        "brenton-leighton/multiple-cursors.nvim",
        opts = {},
        keys = {
            { "<c-s-j>", "<Cmd>MultipleCursorsAddDown<CR>", desc = "MultipCursor Add Down" },
            { "<c-s-k>", "<Cmd>MultipleCursorsAddUp<CR>", desc = "MultipCursor Add Up" },
            { "<c-s-n>", "<Cmd>MultipleCursorsAddBySearch<CR>", desc = "MultipCursor Add Curr" },
            { "<c-s-m>", "<Cmd>MultipleCursorsAddBySearchV<CR>", desc = "MultipCursor Add Curr in Visual" },
        },
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require("bqf").setup({
                preview = { winblend = 0 },
            })
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {
            render = "first_column",
        },
        keys = {
            { "<leader>tc", "<Cmd>HighlightColorsToggle<CR>", desc = "Toggle HighlightColors" },
        },
    },
    {
        "famiu/bufdelete.nvim",
        event = "BufAdd",
        keys = {
            { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Buffer Delete" },
            { "<leader>bn", "<cmd>bnext<cr>", desc = "Buffer Next" },
            { "<leader>bp", "<cmd>bprevious<cr>", desc = "Buffer Previous" },
        },
    },
    {
        "axkirillov/hbac.nvim",
        event = "BufAdd",
        opts = { threshold = 10 },
    },
}
