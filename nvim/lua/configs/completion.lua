return function()
	local cmp = require("cmp")
	local nvim_lsp = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local luasnip = require("luasnip")

	cmp.event:on(
		"confirm_done",
		require("nvim-autopairs.completion.cmp").on_confirm_done({
			map_char = { tex = "" },
		})
	)
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		mapping = {
			["<C-i>"] = cmp.mapping.confirm({ select = true }),
			["<C-j>"] = function(callback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end,
			["<C-k>"] = function(callback)
				luasnip.jump(-1)
			end,
		},

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}),
	})

	-- Setup lspconfig.
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	for _, lsp in pairs({ "rust_analyzer" }) do
		require("lspconfig")[lsp].setup({ capabilities = capabilities })
	end
	require("luasnip/loaders/from_vscode").lazy_load()
end
