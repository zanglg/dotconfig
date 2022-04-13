return function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "rust", "c", "cpp", "python", "lua", "markdown" },
		rainbow = { enable = true },
		matchup = { enable = true },
		highlight = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "gi",
				node_decremental = "gd",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["ic"] = "@conditional.inner",
					["ac"] = "@conditional.outer",
					["if"] = "@function.inner",
					["af"] = "@function.outer",
					["il"] = "@loop.inner",
					["al"] = "@loop.outer",
					["ip"] = "@parameter.inner",
					["ap"] = "@parameter.outer",
					["as"] = "@statement.outer",
				},
			},
		},
	})
end
