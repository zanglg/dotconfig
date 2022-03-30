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

	-- Navigation
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
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- File type specificed
	use({ "rust-lang/rust.vim", ft = { "rust" } })

	-- Enhanced text edit
	use({ "editorconfig/editorconfig-vim", event = "BufRead" })
	use({ "fidian/hexmode", ft = { "bin", "img" } })
	use({ "nathom/filetype.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "rust" },
			})
		end,
	})

	-- window manager
	use({ "mrjones2014/smart-splits.nvim" })

	-- lsp and completion
	use({ "neovim/nvim-lspconfig" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({
		"hrsh7th/nvim-cmp",
		config = require("completion"),
	})

	-- dependencies
	use({ "nvim-lua/plenary.nvim", opt = true })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true })
	use({ "kyazdani42/nvim-web-devicons", opt = true })
end)
