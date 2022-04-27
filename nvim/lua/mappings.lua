return function()
	-- Remap "," as map leader
	vim.g.mapleader = ","
	vim.g.maplocalleader = ","

	local wk = require("which-key")

	---------- Normal mode key mapping ------------
	wk.register({
		---------- buffer switch ----------
		["<S-l>"] = { "<cmd>bnext<cr>", "next buffer" },
		["<S-h>"] = { "<cmd>bprevious<cr>", "prev buffer" },

		---------- window switch ----------
		["<C-h>"] = { "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", "window left" },
		["<C-j>"] = { "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", "window down" },
		["<C-k>"] = { "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", "window up" },
		["<C-l>"] = { "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", "window right" },

		---------- lsp goto ----------
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
		["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implemention" },
		["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "reference" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },

		-- code operation
		["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
		["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },

		-- diagnostic
		["dn"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "prev diagnostic" },
		["dp"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "next diagnostic" },
		["de"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "float diagnostic" },
		["dq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "local diagnostic" },

		-- hop/motion
		["s"] = { "<cmd>HopWord<cr>", "hop word" },

		---------- telescope ----------
		["mf"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "find files" },
		["mg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "live grep" },
		["mb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "find buffers" },
		["ms"] = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "find buffers" },

		---------- sidebar toggle ----------
		["mn"] = { "<cmd>NvimTreeToggle<cr>", "nvim-tree toggle" },
		["mt"] = { "<cmd>SymbolsOutline<cr>", "symbols-outline toggle" },

		-- utilties
		["mq"] = { "<cmd>q!<cr>", "quit without save" },
		["mw"] = { "<cmd>wq<cr>", "quit with save" },
		["md"] = { "<cmd>bdelete<cr>", "delete current buffer" },
	})

	---------- Visual mode key mapping ------------
	wk.register({
		---------- buffer switch ----------
		["<leader>cf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "format" },
	}, { mode = "v" })
end
