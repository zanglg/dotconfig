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
}
