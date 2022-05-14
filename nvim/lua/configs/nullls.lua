local augroup = vim.api.nvim_create_augroup("NullLspFormatting", {})

return function()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.taplo,
			require("null-ls").builtins.formatting.shfmt,
			require("null-ls").builtins.formatting.asmfmt,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.formatting_sync()
					end,
				})
			end
		end,
	})
end
