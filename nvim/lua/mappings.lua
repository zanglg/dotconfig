return function()
	-- Remap "," as map leader
	vim.g.mapleader = ","
	vim.g.maplocalleader = ","

	local wk = require("which-key")

	wk.register({
		-- nvim-tree
		["<leader>N"] = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },

		-- symbols-outline.nvim
		["<leader>S"] = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" },

		-- Navigate buffers
		["<S-l>"] = { "<cmd>bnext<CR>", "Next Buffer" },
		["<S-h>"] = { "<cmd>bprevious<CR>", "Prev Buffer" },

		-- Better window navigation
		["<C-h>"] = { "<cmd>lua require'smart-splits'.move_cursor_left()<CR>", "Window Left" },
		["<C-j>"] = { "<cmd>lua require'smart-splits'.move_cursor_down()<CR>", "Window Down" },
		["<C-k>"] = { "<cmd>lua require'smart-splits'.move_cursor_up()<CR>", "Window Up" },
		["<C-l>"] = { "<cmd>lua require'smart-splits'.move_cursor_right()<CR>", "Window Right" },
	})
end
