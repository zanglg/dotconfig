
local mappings = {}

function mappings.init()
    local map = vim.api.nvim_set_keymap

    map("i", "<C-h>", "<C-Left>",  {expr = false, noremap = true})
    map("i", "<C-l>", "<C-Right>", {expr = false, noremap = true})
    
    map("n", "<leader>f", "<cmd>Telescope fd<cr>",         {expr = false, noremap = true})
    map("n", "<leader>/", "<cmd>Telescope live_grep<cr>",  {expr = false, noremap = true})
end

return mappings
