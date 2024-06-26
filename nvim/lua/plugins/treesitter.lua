return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "HiPhish/rainbow-delimiters.nvim",
            "danymat/neogen",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                ensure_installed = {
                    -- programming language
                    "c",
                    "cpp",
                    "rust",
                    "python",
                    "comment",
                    -- markup lang
                    "dot",
                    "rst",
                    "typst",
                    "markdown",
                    "markdown_inline",
                    -- make
                    "bash",
                    "gn",
                    "just",
                    "make",
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
    {
        "HiPhish/rainbow-delimiters.nvim",
        setup = function()
            require("rainbow-delimiters.setup").setup({})
        end,
    },
    {
        "danymat/neogen",
        opts = { snippet_engine = "luasnip" },
        keys = {
            { "<leader>ccg", "<cmd>Neogen<cr>", desc = "Code Comment Generation" },
        },
    },
}
