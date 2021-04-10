local completion = {}

function completion.lspconfig()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require "lspconfig".clangd.setup {capabilities = capabilities}
    require "lspconfig".pyls.setup {capabilities = capabilities}
    require "lspconfig".rust_analyzer.setup {capabilities = capabilities}
end

function completion.compe()
    vim.o.completeopt = "menuone,noselect"

    require "lspkind".init {}

    require "compe".setup {
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true,
            vsnip = true,
            emoji = true
        }
    }

    vim.api.nvim_set_keymap(
        "i",
        "<C-j>",
        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'",
        {expr = true, noremap = false}
    )
    vim.api.nvim_set_keymap(
        "s",
        "<C-j>",
        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'",
        {expr = true, noremap = false}
    )
    vim.api.nvim_set_keymap(
        "i",
        "<C-k>",
        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'",
        {expr = true, noremap = false}
    )
    vim.api.nvim_set_keymap(
        "s",
        "<C-k>",
        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'",
        {expr = true, noremap = false}
    )
    vim.api.nvim_set_keymap("i", "<C-i>", "compe#confirm('<C-i>')", {expr = true, noremap = true})
end

return completion
