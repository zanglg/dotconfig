local M = {}

M.lsp = function()
    -- set border for hover signature and diagnostic preview
    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "signle" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    -- Setup lspconfig.
    local capabilities =
        require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    for _, lsp in pairs({ "rust_analyzer", "clangd", "pylsp", "marksman" }) do
        require("lspconfig")[lsp].setup({
            capabilities = capabilities,
        })
    end
    require("lspconfig").sumneko_lua.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
                format = { enable = false },
            },
        },
        on_attach = function(client, _)
            -- Disable formatting capability so that null-ls handles it.
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end,
    })
end

M.nulllsp = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.taplo,
            require("null-ls").builtins.formatting.shfmt,
            require("null-ls").builtins.formatting.asmfmt,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = bufnr,
                })
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

return M
