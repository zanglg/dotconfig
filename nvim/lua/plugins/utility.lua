return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        cmd = "BqfToggle",
        config = function()
            require("bqf").setup({
                auto_enable = false,
            })
        end,
    },
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
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
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { mode = "quickfix" },
    },
}
