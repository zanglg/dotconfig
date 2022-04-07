return function()
	-- Remap "," as map leader
	vim.g.mapleader = ","
	vim.g.maplocalleader = ","

	require("which-key").register({
		---------- buffer switch ----------
		["<S-l>"] = { "<cmd>bnext<cr>", "next buffer" },
		["<S-h>"] = { "<cmd>bprevious<cr>", "prev buffer" },

		---------- window switch ----------
		["<C-h>"] = { "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", "window left" },
		["<C-j>"] = { "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", "window down" },
		["<C-k>"] = { "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", "window up" },
		["<C-l>"] = { "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", "window right" },

		---------- sidebar toggle ----------
		["<leader>N"] = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
		["<leader>S"] = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" },

		---------- lsp ----------
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
		["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implemention" },
		["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "reference" },
		["<leader>f"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
	})
end
