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
}
