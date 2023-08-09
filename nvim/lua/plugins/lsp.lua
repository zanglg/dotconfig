return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        ft = { "c", "cpp", "rust", "python", "lua" },
        dependencies = {
            "folke/neodev.nvim",
            "dgagn/diagflow.nvim",
            "lukas-reineke/lsp-format.nvim",
        },
        keys = {
            { "K",          vim.lsp.buf.hover,           desc = "Hover",              mode = { "n" } },
            { "gd",         vim.lsp.buf.definition,      desc = "Definition",         mode = { "n" } },
            { "gD",         vim.lsp.buf.declaration,     desc = "Definition",         mode = { "n" } },
            { "gr",         vim.lsp.buf.references,      desc = "References",         mode = { "n" } },
            { "gi",         vim.lsp.buf.implementation,  desc = "Implementation",     mode = { "n" } },
            { "gt",         vim.lsp.buf.type_definition, desc = "Type Definition",    mode = { "n" } },
            { "<leader>ca", vim.lsp.buf.code_action,     desc = "Code Action",        mode = { "n", "v" } },
            { "<leader>cf", vim.lsp.buf.format,          desc = "Format Document",    mode = { "n", "v" } },
            { "<leader>cr", vim.lsp.buf.rename,          desc = "Rename",             mode = { "n" } },
            { "<leader>dn", vim.diagnostic.goto_next,    desc = "Next Diagnostic",    mode = { "n" } },
            { "<leader>dp", vim.diagnostic.goto_prev,    desc = "Prev Diagnostic",    mode = { "n" } },
            { "<leader>dk", vim.diagnostic.open_float,   desc = "Preview Diagnostic", mode = { "n" } },
            { "<leader>dd", vim.diagnostic.setqflist,    desc = "List Diagnostics",   mode = { "n" } },
        },
        config = function()
            -- how diagnostic are displayed
            vim.diagnostic.config({
                underline = false,
                virtual_text = false,
                update_in_insert = false,
                float = { border = "rounded" },
            })

            -- change diagnostic symbols
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            for _, server in ipairs({ "clangd", "rust_analyzer", "pylsp" }) do
                require("lspconfig")[server].setup({
                    on_attach = require("lsp-format").on_attach,
                })
            end
            require("lspconfig")["lua_ls"].setup({
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        format = {
                            enable = true,
                        },
                    },
                },
                on_attach = require("lsp-format").on_attach,
            })
        end,
    },
    {
        "lukas-reineke/lsp-format.nvim",
        opts = {
            c = { exclude = { "clangd" } },
            cpp = { exclude = { "clangd" } },
        },
    },
    {
        "dgagn/diagflow.nvim",
        opts = {
            scope = "line",
            toggle_event = { "InsertEnter" },
        },
    },
    {
        "folke/neodev.nvim",
        opts = {
            setup_jsonls = false,
        },
    },
}
