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
		["<leader>N"] = { "<cmd>NvimTreeToggle<cr>", "nvim-tree toggle" },
		["<leader>S"] = { "<cmd>SymbolsOutline<cr>", "symbols-outline toggle" },

		---------- telescope ----------
		["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "find files" },
		["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "live grep" },
		["<leader>fb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "find buffers" },

		---------- lsp ----------
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },
		["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implemention" },
		["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "reference" },

		["<leader>f"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
		["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },

		-- diagnostic
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "prev diagnostic" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "next diagnostic" },
		["<leader>e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "float diagnostic" },
		["<leader>q"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "local diagnostic" },

		-- hop/motion
		["f"] = { "<cmd>HopWord<cr>", "hop word" },
	})
end
