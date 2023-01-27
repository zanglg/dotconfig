return {
    {
        "mfussenegger/nvim-treehopper",
        keys = { { "m", mode = { "o", "x" } } },
        config = function()
            vim.cmd([[
                omap     <silent> m :<C-U>lua require('tsht').nodes()<cr>
                xnoremap <silent> m :lua require('tsht').nodes()<cr>
            ]])
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    -- programming language
                    "c",
                    "rust",
                    "python",
                    -- markup lang
                    "rst",
                    "markdown",
                    "markdown_inline",
                    "dot",
                    -- make
                    "make",
                    "bash",
                    "ninja",
                    -- config file
                    "toml",
                    "json",
                    "yaml",
                    -- neovim
                    "lua",
                    "vim",
                    "help",
                },
                highlight = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-m>",
                        node_incremental = "<c-m>",
                        scope_incremental = "<nop>",
                        node_decremental = "<c-n>",
                    },
                },
            })
        end,
    },
}
