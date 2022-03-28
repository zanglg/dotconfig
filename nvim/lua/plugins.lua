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
	-- Appearence
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").load()
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup()
		end,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Navigation
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
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

	-- Advanced
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "rust" },
			})
		end,
	})
	use("editorconfig/editorconfig-vim")
end)
