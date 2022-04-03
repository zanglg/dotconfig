return function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained",
        rainbow = { enable = true },
        matchup = { enable = true },
    })
end
