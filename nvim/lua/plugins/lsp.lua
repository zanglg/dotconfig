return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {},
        keys = {
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
            { "gr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References" },
            { "gI", "<cmd>TroubleToggle lsp_implementations<cr>", desc = "Goto Implementation" },
            { "gt", "<cmd>TroubleToggle lsp_type_definitions<cr>", desc = "Goto Type Definition" },

            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },

            { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
            { "<leader>dp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
            { "<leader>dk", vim.diagnostic.open_float, desc = "Preview Diagnostic" },

            { "<leader>dd", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
            { "<leader>dw", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },

            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
            { "<leader>cf", vim.lsp.buf.format, desc = "Format Document", mode = { "n", "v" } },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
        },
        config = function()
            -- how diagnostic are displayed
            vim.diagnostic.config({
                underline = false,
                virtual_text = false,
                update_in_insert = false,
                float = { border = "single" },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

            -- change diagnostic symbols
            local signs = { Error = "", Warn = "", Hint = "", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            local on_attach = function(client, buf)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
                    buffer = buf,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end

            local servers = {
                clangd = { on_attach = on_attach },
                rust_analyzer = { on_attach = on_attach },
                pylsp = { on_attach = on_attach },
            }

            for _, server in ipairs({ "clangd", "rust_analyzer", "pylsp" }) do
                require("lspconfig")[server].setup({
                    on_attach = require("lsp-format").on_attach,
                })
            end
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            require("null-ls").setup({
                sources = {
                    -- non-lsp formatter
                    require("null-ls").builtins.formatting.stylua,
                    require("null-ls").builtins.formatting.taplo,
                    require("null-ls").builtins.formatting.shfmt,
                    require("null-ls").builtins.formatting.asmfmt,
                },
                on_attach = require("lsp-format").on_attach,
            })
        end,
    },
    {
        "lukas-reineke/lsp-format.nvim",
        opts = {},
    },
}
