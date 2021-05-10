
local mappings = {}

function mappings.init()
    local map = vim.api.nvim_set_keymap

    map("i", "<C-h>", "<C-Left>",  {expr = false, noremap = true})
    map("i", "<C-l>", "<C-Right>", {expr = false, noremap = true})
    
    map("n", "<leader>f", "<cmd>Telescope fd<cr>",                       {expr = false, noremap = true})
    map("n", "<leader>b", "<cmd>Telescope buffers<cr>",                  {expr = false, noremap = true})
    map("n", "<leader>/", "<cmd>Telescope live_grep<cr>",                {expr = false, noremap = true})
    map("n", "<leader>d", "<cmd>Telescope lsp_definitions<cr>",          {expr = false, noremap = true})
    map("n", "<leader>r", "<cmd>Telescope lsp_references<cr>",           {expr = false, noremap = true})
    map("n", "<leader>c", "<cmd>lua vim.lsp.buf.formatting()<CR>",       {expr = false, noremap = true})
    map("v", "<leader>c", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {expr = false, noremap = true})

    map("n", "<leader>q", "<cmd>q!<cr>",                                 {expr = false, noremap = true})

    map("n", "<leader>N", "<cmd>NvimTreeToggle<cr>",                     {expr = false, noremap = true})
end

return mappings
