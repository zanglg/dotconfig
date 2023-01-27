return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {},
    keys = {
        { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
        { "gr", vim.lsp.buf.references, desc = "References" },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
        { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },

        { "K", vim.lsp.buf.hover, desc = "Hover" },
        { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },

        { "[d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        { "]d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
        { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        { "<leader>dp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
        { "<leader>df", vim.diagnostic.open_float, desc = "Float Diagnostic" },
        { "<leader>dq", vim.diagnostic.setqflist, desc = "Diagnostic to Quickfix" },
        { "<leader>dl", vim.diagnostic.setloclist, desc = "Diagnostic to LocList" },

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
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local on_attach = function(client, buf)
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
                buffer = buf,
                callback = function()
                    if client and client.supports_method("textDocument/rangeFormatting") then
                        -- TODO move to configs.format.lua and check if gitsigns requirable
                        for _, hunk in ipairs(require("gitsigns").get_hunks()) do
                            vim.lsp.buf.format({
                                async = true,
                                range = {
                                    start = { hunk.added.start, 0 },
                                    ["end"] = { hunk.added.start + hunk.added.count - 1, -1 },
                                },
                            })
                        end
                    else
                        vim.lsp.buf.format({ async = true })
                    end
                end,
            })
        end

        local servers = {
            clangd = { on_attach = on_attach },
            rust_analyzer = { on_attach = on_attach },
            pylsp = { on_attach = on_attach },
            marksman = {},
        }

        for server, opts in pairs(servers) do
            require("lspconfig")[server].setup(opts)
        end
    end,
}
