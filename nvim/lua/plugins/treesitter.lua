return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "HiPhish/nvim-ts-rainbow2",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                rainbow = { enable = true },
                highlight = { enable = true },
                ensure_installed = {
                    -- programming language
                    "c",
                    "cpp",
                    "rust",
                    "python",
                    "comment",
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
                    "vimdoc",
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
