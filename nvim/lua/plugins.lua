local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup({
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
    function(use)
        -- package manager itself
        use("wbthomason/packer.nvim")
        use("lewis6991/impatient.nvim")

        -- Appearence
        use({
            "zanglg/nova.nvim",
            config = function()
                require("nova").setup({
                    background = "light",
                })

                -- load colorscheme
                vim.cmd([[colorscheme nova]])
            end,
        })
        use({
            "nvim-lualine/lualine.nvim",
            setup = function()
                vim.cmd([[packadd nvim-web-devicons]])
            end,
            config = function()
                require("lualine").setup({
                    options = { globalstatus = true },
                })
            end,
        })

        -- UI enhanced
        use({
            "stevearc/dressing.nvim",
            config = function()
                require("dressing").setup({})
            end,
        })

        -- Navigation
        use({
            "simrat39/symbols-outline.nvim",
            cmd = "SymbolsOutline",
        })
        use({
            "kyazdani42/nvim-tree.lua",
            setup = function()
                vim.cmd([[packadd nvim-web-devicons]])
            end,
            config = function()
                require("nvim-tree").setup({})
            end,
            cmd = "NvimTreeToggle",
        })
        use({
            "nvim-telescope/telescope.nvim",
            setup = function()
                vim.cmd([[packadd plenary.nvim]])
            end,
            config = function()
                require("telescope").setup({})
            end,
        })
        use({
            "phaazon/hop.nvim",
            branch = "v1",
            config = function()
                require("hop").setup()
            end,
        })

        -- File type specificed
        use({
            "rust-lang/rust.vim",
            ft = { "rust" },
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
            },
            run = ":TSUpdate",
            config = require("configs.treesitter"),
        })
        use({ "Vonr/align.nvim" })
        use({
            "keaising/im-select.nvim",
            config = function()
                require("im_select").setup({})
            end,
        })

        -- key mapping
        use({
            "folke/which-key.nvim",
            config = require("mappings"),
        })

        -- window manager
        use({ "mrjones2014/smart-splits.nvim" })

        -- Language Server Protocol
        use({
            "neovim/nvim-lspconfig",
            config = require("configs.lsp").lsp,
        })
        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = require("configs.lsp").nulllsp,
        })

        -- auto completion
        use({ "L3MON4D3/LuaSnip" })
        use({ "saadparwaiz1/cmp_luasnip" })
        use({ "rafamadriz/friendly-snippets" })
        use({ "hrsh7th/cmp-path" })
        use({ "hrsh7th/cmp-buffer" })
        use({ "hrsh7th/cmp-nvim-lsp" })
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end,
        })
        use({
            "hrsh7th/nvim-cmp",
            config = require("configs.nvim-cmp"),
        })

        -- git operations
        use({
            "sindrets/diffview.nvim",
            setup = function()
                vim.cmd([[packadd plenary.nvim]])
            end,
            cmd = "DiffviewOpen",
        })

        -- terminal manager
        use({
            "akinsho/toggleterm.nvim",
            config = function()
                require("toggleterm").setup({})
            end,
            cmd = "ToggleTerm",
        })

        -- dependencies
        use({
            "nvim-lua/plenary.nvim",
            opt = true,
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            opt = true,
        })
        use({
            "kyazdani42/nvim-web-devicons",
            opt = true,
        })

        if packer_bootstrap then
            require("packer").sync()
        end
    end,
})
