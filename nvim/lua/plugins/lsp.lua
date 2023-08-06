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
            { "gd",         vim.lsp.buf.definition,                         desc = "Goto Definition" },
            { "gr",         "<cmd>TroubleToggle lsp_references<cr>",        desc = "References" },
            { "gI",         "<cmd>TroubleToggle lsp_implementations<cr>",   desc = "Goto Implementation" },
            { "gt",         "<cmd>TroubleToggle lsp_type_definitions<cr>",  desc = "Goto Type Definition" },
            { "K",          vim.lsp.buf.hover,                              desc = "Hover" },
            { "<leader>dn", vim.diagnostic.goto_next,                       desc = "Next Diagnostic" },
            { "<leader>dp", vim.diagnostic.goto_prev,                       desc = "Prev Diagnostic" },
            { "<leader>dk", vim.diagnostic.open_float,                      desc = "Preview Diagnostic" },
            { "<leader>dd", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
            { "<leader>dw", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
            { "<leader>ca", vim.lsp.buf.code_action,                        desc = "Code Action" },
            { "<leader>cf", vim.lsp.buf.format,                             desc = "Format Document", },
            { "<leader>cr", vim.lsp.buf.rename,                             desc = "Rename" },
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
