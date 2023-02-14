return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "uga-rosa/cmp-dictionary",
        "windwp/nvim-autopairs",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("cmp_dictionary").setup({
            dic = { ["*"] = { "/usr/share/dict/words" } },
        })

        require("nvim-autopairs").setup({})
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = "single",
                    scrollbar = false,
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
                },
                documentation = {
                    border = "single",
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
                },
            },
            mapping = {
                ["<c-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<c-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<c-b>"] = cmp.mapping.scroll_docs(-4),
                ["<c-f>"] = cmp.mapping.scroll_docs(4),
                ["<c-e>"] = cmp.mapping.abort(),
                ["<c-i>"] = cmp.mapping.confirm({ select = true }),
                ["<cr>"] = cmp.mapping.confirm({ select = true }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "emoji" },
                { name = "nvim_lsp_signature_help" },
                { name = "dictionary", keyword_length = 3 },
            }),
            formatting = {
                format = require("lspkind").cmp_format({}),
            },
        })
        -- Load own custom vscode style snippets
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets",
        })

        -- To use existing vs-code style snippets like rafamadriz/friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
