local M = {}

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
            require("nova").setup({
                theme = "nova",
                background = "dark",
            })

            -- load colorscheme
            require("nova").load()
        end,
    })
    use({
        "nvim-lualine/lualine.nvim",
        config = require("plugins.lualine"),
        requires = {
            { "kyazdani42/nvim-web-devicons" },
        },
    })

    -- UI enhanced
    use({
        "stevearc/dressing.nvim",
        config = require("plugins.dressing"),
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
        config = require("plugins.telescope"),
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })
    use({
        "phaazon/hop.nvim",
        branch = "v1",
        config = function()
            require("hop").setup()
        end,
    })
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                performance_mode = true,
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
        run = ":TSUpdate",
        config = require("plugins.treesitter"),
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
        config = require("plugins.which-key").setup,
    })

    -- window manager
    use({ "mrjones2014/smart-splits.nvim" })

    -- Language Server Protocol
    use({
        "neovim/nvim-lspconfig",
        config = require("plugins.lsp").lsp,
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = require("plugins.lsp").nulllsp,
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
        config = require("plugins.nvim-cmp"),
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

local config = {
    display = { open_fn = require("packer.util").float },
}

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

    require("packer").startup(packages, config)

    if bootstrap then
        require("packer").sync()
    end
end

return M
