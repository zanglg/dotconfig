
local mappings = {}

function mappings.init()
    local map = vim.api.nvim_set_keymap

    map("i", "<C-h>", "<C-Left>",  {expr = false, noremap = true})
    map("i", "<C-l>", "<C-Right>", {expr = false, noremap = true})
end

return mappings
