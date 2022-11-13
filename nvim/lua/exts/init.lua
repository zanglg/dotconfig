local M = {}

M.setup = function()
    local fn = vim.fn
    local bootstrap = false
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        bootstrap = fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
    end

    local packages = function(use)
        -- package manager itself
        use("wbthomason/packer.nvim")
        use({
            "lewis6991/impatient.nvim",
            config = function()
                require("impatient").enable_profile()
            end,
        })

        -- Appearence
        use({
            "zanglg/nova.nvim",
            config = function()
                vim.o.background = "light"
                require("nova").setup()

                -- load colorscheme
                require("nova").load()
            end,
        })
        use({
            "nvim-lualine/lualine.nvim",
            config = require("exts.lualine"),
            requires = {
                { "kyazdani42/nvim-web-devicons" },
            },
        })

        -- UI enhanced
        use({
            "stevearc/dressing.nvim",
            config = require("exts.dressing"),
        })
        use({
            "folke/todo-comments.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
            },
            config = function()
                require("todo-comments").setup()
            end,
        })

        -- Navigation
        use({
            "simrat39/symbols-outline.nvim",
            config = function()
                require("symbols-outline").setup()
            end,
            cmd = "SymbolsOutline",
        })
        use({
            "kyazdani42/nvim-tree.lua",
            requires = {
                { "kyazdani42/nvim-web-devicons" },
            },
            config = function()
                require("nvim-tree").setup({})
            end,
            cmd = "NvimTreeToggle",
        })
        use({
            "nvim-telescope/telescope.nvim",
            config = require("exts.telescope"),
            requires = {
                { "nvim-lua/plenary.nvim" },
            },
        })
        use({
            "phaazon/hop.nvim",
            branch = "v2",
            config = function()
                require("hop").setup()
            end,
        })
        use({
            "karb94/neoscroll.nvim",
            config = function()
                require("neoscroll").setup()
            end,
        })
        use({
            "gen740/SmoothCursor.nvim",
            config = function()
                require("smoothcursor").setup({
                    fancy = { enable = true },
                })
            end,
        })

        -- Enhanced text edit
        use({
            "editorconfig/editorconfig-vim",
            event = "BufRead",
        })
        use({
            "fidian/hexmode",
            ft = { "bin", "img" },
        })
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        })
        use({
            "nvim-treesitter/nvim-treesitter",
            requires = {
                "andymass/vim-matchup",
                "p00f/nvim-ts-rainbow",
                "nvim-treesitter/nvim-treesitter-textobjects",
                {
                    "nvim-treesitter/playground",
                    cmd = "TSHighlightCapturesUnderCursor",
                },
            },
            run = function()
                require("nvim-treesitter.install").update({ with_sync = true })
            end,
            config = require("exts.treesitter"),
        })
        use({
            "keaising/im-select.nvim",
            config = function()
                require("im_select").setup({})
            end,
        })

        -- key mapping
        use({
            "folke/which-key.nvim",
            config = require("exts.which-key").setup,
        })

        -- utils
        use({
            "narutoxy/silicon.lua",
            requires = {
                { "nvim-lua/plenary.nvim" },
            },
            config = function()
                require("silicon").setup({})
            end,
        })

        -- window manager
        use({ "mrjones2014/smart-splits.nvim" })

        -- Language Server Protocol
        use({
            "neovim/nvim-lspconfig",
            config = require("exts.lsp").lsp,
        })
        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = require("exts.lsp").nulllsp,
        })

        -- auto completion
        use({ "L3MON4D3/LuaSnip" })
        use({ "saadparwaiz1/cmp_luasnip" })
        use({ "rafamadriz/friendly-snippets" })
        use({ "hrsh7th/cmp-path" })
        use({ "hrsh7th/cmp-buffer" })
        use({ "hrsh7th/cmp-nvim-lsp" })
        use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
        use({
            "uga-rosa/cmp-dictionary",
            config = function()
                require("cmp_dictionary").setup({
                    dic = {
                        ["*"] = { "/usr/share/dict/words" },
                    },
                })
            end,
        })
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end,
        })
        use({
            "hrsh7th/nvim-cmp",
            config = require("exts.nvim-cmp"),
        })

        -- git operations
        use({
            "sindrets/diffview.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
            },
            cmd = "DiffviewOpen",
        })
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup({
                    current_line_blame = true,
                    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>, <abbrev_sha> - <summary>",
                })
            end,
        })
    end

    require("packer").startup({
        packages,
        config = {
            display = {
                open_fn = function()
                    return require("packer.util").float({ border = "single" })
                end,
            },
        },
    })

    if bootstrap then
        require("packer").sync()
    end
end

return M
