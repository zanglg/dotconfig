vim.o.completeopt = "menuone,noselect"

require "lspconfig".clangd.setup {}
require "lspconfig".pyls.setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require "lspconfig".rust_analyzer.setup {capabilities = capabilities}

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

local snippet = vim.fn.stdpath('config')..'/snippet'
vim.g.vsnip_snippet_dir = snippet

vim.api.nvim_set_keymap('i', '<C-j>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'", {expr = true, noremap = false})
vim.api.nvim_set_keymap('s', '<C-j>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'", {expr = true, noremap = false})
vim.api.nvim_set_keymap('i', '<C-k>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'", {expr = true, noremap = false})
vim.api.nvim_set_keymap('s', '<C-k>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'", {expr = true, noremap = false})

vim.api.nvim_set_keymap('i', '<C-i>', "compe#confirm('<CR>')", {expr = true, noremap = true})
