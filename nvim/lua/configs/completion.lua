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

	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

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

		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					path = "[Path]",
				})[entry.source.name]
				return vim_item
			end,
		},
	})

	-- Setup lspconfig.
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	for _, lsp in pairs({ "rust_analyzer", "clangd" }) do
		require("lspconfig")[lsp].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- auto format on save for lsp based client buffer
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

	-- Load own custom vscode style snippets
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = vim.fn.stdpath("config") .. "/snippets",
	})

	-- To use existing vs-code style snippets like rafamadriz/friendly-snippets
	require("luasnip.loaders.from_vscode").lazy_load()
end
