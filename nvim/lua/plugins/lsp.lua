return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {},
    config = function()
        -- how diagnostic are displayed
        vim.diagnostic.config({
            underline = false,
            virtual_text = false,
            update_in_insert = false,
        })

        -- change diagnostic symbols
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local servers = {
            rust_analyzer = {},
            clangd = {},
            pylsp = {},
            marksman = {},
        }

        for server, opts in pairs(servers) do
            opts.capabilities = capabilities
            require("lspconfig")[server].setup(opts)
        end
    end,
}
