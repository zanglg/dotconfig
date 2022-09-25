return function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done({
            map_char = {
                tex = "",
            },
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

    local config = {
        border = "single",
        scrollbar = "",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual",
    }

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
                == nil
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        window = {
            completion = cmp.config.window.bordered(config),
            documentation = cmp.config.window.bordered(config),
        },

        mapping = {
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
        },

        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
            { name = "nvim_lsp_signature_help" },
            { name = "dictionary", keyword_length = 3 },
        }),

        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    path = "[Path]",
                    buffer = "[Buffer]",
                    nvim_lsp_signature_help = "[LSPSig]",
                    dictionary = "[Dict]",
                })[entry.source.name]
                return vim_item
            end,
        },
    })

    -- Load own custom vscode style snippets
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets",
    })

    -- To use existing vs-code style snippets like rafamadriz/friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
end
