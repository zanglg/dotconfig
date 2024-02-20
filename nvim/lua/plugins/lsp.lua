return {
    {
        "neovim/nvim-lspconfig",
        ft = { "c", "cpp", "rust", "python" },
        keys = {
            { "K", vim.lsp.buf.hover, desc = "Hover", mode = { "n" } },
            { "gd", vim.lsp.buf.definition, desc = "Definition", mode = { "n" } },
            { "gD", vim.lsp.buf.declaration, desc = "Definition", mode = { "n" } },
            { "gr", vim.lsp.buf.references, desc = "References", mode = { "n" } },
            { "gi", vim.lsp.buf.implementation, desc = "Implementation", mode = { "n" } },
            { "gt", vim.lsp.buf.type_definition, desc = "Type Definition", mode = { "n" } },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
            { "<leader>cf", vim.lsp.buf.format, desc = "Format Document", mode = { "n", "v" } },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", mode = { "n" } },
            { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic", mode = { "n" } },
            { "<leader>dp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic", mode = { "n" } },
            { "<leader>dk", vim.diagnostic.open_float, desc = "Preview Diagnostic", mode = { "n" } },
            { "<leader>dd", vim.diagnostic.setqflist, desc = "List Diagnostics", mode = { "n" } },
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

            local on_attach = function(client, bufnr)
                local lsp_attach = vim.api.nvim_create_augroup("LspAttach", { clear = true })
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = vim.diagnostic.open_float,
                    group = lsp_attach,
                })
                if vim.fn.has("nvim-0.10") == 1 then
                    if client.server_capabilities.inlayHintProvider then
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.inlay_hint.enable(bufnr, true)
                            end,
                            group = lsp_attach,
                        })
                        vim.api.nvim_create_autocmd("InsertLeave", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.inlay_hint.enable(bufnr, false)
                            end,
                            group = lsp_attach,
                        })
                    end
                end
            end

            local servers = {
                clangd = { on_attach = on_attach },
                rust_analyzer = { on_attach = on_attach },
                pylsp = { on_attach = on_attach },
            }

            for server, opts in pairs(servers) do
                require("lspconfig")[server].setup(opts)
            end
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        ft = { "lua", "toml" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.taplo,
                    null_ls.builtins.formatting.gn_format,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        cmd = {
            "MasonToolsInstall",
            "MasonToolsInstallSync",
            "MasonToolsUpdate",
            "MasonToolsUpdateSync",
            "MasonToolsClean",
        },
        opts = {
            ensure_installed = {},
        },
    },
}
