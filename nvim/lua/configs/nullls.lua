return function()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.formatting.taplo,
			require("null-ls").builtins.formatting.shfmt,
			require("null-ls").builtins.formatting.asmfmt,
		},
	})
end
