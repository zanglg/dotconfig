local set = vim.keymap.set

-- quick move in insert mode
set("i", "<c-l>", "<right>")
set("i", "<c-h>", "<left>")
set("i", "<c-j>", "<down>")
set("i", "<c-k>", "<up>")
set("i", "<c-o>", "<esc>o")

-- edit helper
set("n", "cc", "ciw")

-- buffer manager
set("n", "<leader>bd", ":bdelete<cr>")
set("n", "<leader>bn", ":bnext<cr>")
set("n", "<leader>bp", ":bprevious<cr>")

-- quickfix manager
local toggle_quickfix = function()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end
vim.keymap.set("n", "q", toggle_quickfix)
