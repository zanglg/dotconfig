return function()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
		},
	})
end
