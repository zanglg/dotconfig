return function()
	-- Remap "," as map leader
	vim.g.mapleader = ","
	vim.g.maplocalleader = ","

	require("which-key").register({
		---------- Shift Based Mapping keys ----------
		["<S-l>"] = { "<cmd>bnext<cr>", "next buffer" },
		["<S-h>"] = { "<cmd>bprevious<cr>", "prev buffer" },

		---------- Ctrl Based Mapping keys ----------
		["<C-h>"] = { "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", "window left" },
		["<C-j>"] = { "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", "window down" },
		["<C-k>"] = { "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", "window up" },
		["<C-l>"] = { "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", "window right" },

		---------- Leader key Mapping keys ----------
		["<leader>N"] = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
		["<leader>S"] = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" },
	})
end
