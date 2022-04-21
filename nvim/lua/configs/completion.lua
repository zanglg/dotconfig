return function()
	local cmp = require("cmp")
	local nvim_lsp = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local luasnip = require("luasnip")

	-- set border for hover signature and diagnostic preview
	local lsp = vim.lsp
	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })
	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" })
	vim.diagnostic.config({ float = { border = "rounded" } })

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

		mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-p>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		}),
	})

	-- Setup lspconfig.
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	for _, lsp in pairs({ "rust_analyzer", "clangd" }) do
		require("lspconfig")[lsp].setup({ capabilities = capabilities })
	end
	require("luasnip/loaders/from_vscode").lazy_load()
end
