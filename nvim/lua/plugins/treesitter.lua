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
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "mrjones2014/nvim-ts-rainbow",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                rainbow = { enable = true },
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
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = false,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                        },
                    },
                },
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
