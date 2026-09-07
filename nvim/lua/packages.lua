if not vim.pack then
    error("This config uses Neovim's native package manager (vim.pack). Please use a recent Neovim build that provides vim.pack.")
end

-- Add shared dependencies first so dependent plugins can resolve their Lua modules
-- reliably during startup.
vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.pack.add({
    { src = "https://github.com/zanglg/nova.nvim", version = "dev" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/noice.nvim" },

    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/hedyhli/outline.nvim" },

    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
    { src = "https://github.com/jvgrootveld/telescope-zoxide" },
})
