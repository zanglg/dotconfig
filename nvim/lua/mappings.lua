return function()
	-- Remap "," as map leader
	vim.g.mapleader = ","
	vim.g.maplocalleader = ","

	-- TODO:
	--     how set insert mode mapping in which-key.nvim ?
	--     1. skip out the next pairs
	--     2. remove previous word
	vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>(TaboutMulti)", { silent = true })
	vim.api.nvim_set_keymap("i", "<C-h>", "<Esc>caw", { silent = true })

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
