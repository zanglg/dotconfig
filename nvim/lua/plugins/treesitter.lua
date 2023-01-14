return {
    { "mfussenegger/nvim-treehopper" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "rust", "python", "lua", "vim", "help" },
                highlight = { enable = true },
            })
        end,
    },
}
