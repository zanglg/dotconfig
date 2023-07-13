local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("i", "<c-l>", "<right>", opts)
keymap("i", "<c-h>", "<left>", opts)

keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

keymap("n", "<leader>cc", "ciw", opts)
keymap("n", "<leader>bd<cr>", ":bdelete", opts)
