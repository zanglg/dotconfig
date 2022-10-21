local M = {}

M.lsp = function()
    -- Setup lspconfig.
    local capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    })
end

M.nulllsp = function()
    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.taplo,
            require("null-ls").builtins.formatting.shfmt,
            require("null-ls").builtins.formatting.asmfmt,
        },
    })
end

return M
