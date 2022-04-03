return function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained",
        matchup = { enable = true },
    })
end
