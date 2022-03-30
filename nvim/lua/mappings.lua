local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Remap "," as map leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Better window navigation
map("n", "<C-h>", "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", opts)
map("n", "<C-j>", "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", opts)
map("n", "<C-k>", "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", opts)
map("n", "<C-l>", "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", opts)

-- Resize with arrows -- not work with hhkb
-- map("n", "<C-Up>", "<cmd>lua require'smart-splits'.resize_up()<cr>", opts)
-- map("n", "<C-Down>", "<cmd>lua require'smart-splits'.resize_down()<cr>", opts)
-- map("n", "<C-Left>", "<cmd>lua require'smart-splits'.resize_left()<cr>", opts)
-- map("n", "<C-Right>", "<cmd>lua require'smart-splits'.resize_right()<cr>", opts)
