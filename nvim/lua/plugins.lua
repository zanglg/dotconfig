local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	require("packer").sync()
end

return require("packer").startup(function(use)
	-- package manager itself
	use("wbthomason/packer.nvim")

	-- Appearence
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").load()
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		setup = function()
			vim.cmd([[packadd nvim-web-devicons]])
		end,
		config = function()
			require("lualine").setup()
		end,
	})

	-- UI enhanced
	use({ "yamatsum/nvim-cursorline" })
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({})
		end,
	})

	-- Navigation
	use({ "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" })
	use({
		"kyazdani42/nvim-tree.lua",
		setup = function()
			vim.cmd([[packadd nvim-web-devicons]])
		end,
		config = function()
			require("nvim-tree").setup({})
		end,
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
	use({ "rust-lang/rust.vim", ft = { "rust" } })

	-- Enhanced text edit
	use({ "editorconfig/editorconfig-vim", event = "BufRead" })
	use({ "fidian/hexmode", ft = { "bin", "img" } })
	use({ "nathom/filetype.nvim" })
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
		config = require("configs.treesitter"),
	})

	-- key mapping
	use({
		"folke/which-key.nvim",
		config = require("mappings"),
	})

	-- window manager
	use({ "mrjones2014/smart-splits.nvim" })

	-- lsp and completion
	use({ "neovim/nvim-lspconfig" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		config = require("configs.completion"),
	})

	-- dependencies
	use({ "nvim-lua/plenary.nvim", opt = true })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true })
	use({ "kyazdani42/nvim-web-devicons", opt = true })
end)
