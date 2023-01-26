return {
    { "mfussenegger/nvim-treehopper" },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "rust", "python", "lua", "vim", "help" },
                highlight = { enable = true },
            })
        end,
    },
}
