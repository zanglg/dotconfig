local M = {}

M.lsp = function()
	-- set border for hover signature and diagnostic preview
	local lsp = vim.lsp
	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })
	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" })
	vim.diagnostic.config({ float = { border = "rounded" } })

	-- Setup lspconfig.
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	for _, lsp in pairs({ "rust_analyzer", "clangd", "pylsp", "marksman" }) do
		require("lspconfig")[lsp].setup({ capabilities = capabilities })
	end
end

M.nulllsp = function()
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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

return M
