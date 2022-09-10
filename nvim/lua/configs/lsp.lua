local M = {}

M.lsp = function()
    -- set border for hover signature and diagnostic preview
    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = require("options").border })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = require("options").border })

    -- set border for vim diagnostic float window
    vim.diagnostic.config({ float = { border = require("options").border } })

    -- Setup lspconfig.
    local capabilities =
        require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    for _, lsp in pairs({ "rust_analyzer", "clangd", "pylsp", "marksman" }) do
        require("lspconfig")[lsp].setup({
            capabilities = capabilities,
        })
    end
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
