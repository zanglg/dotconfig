local M = {}

function M.start_resize_mode()
    local bufnr = vim.api.nvim_get_current_buf()
    local keys = { "h", "j", "k", "l", "q", "<Esc>" }

    local function exit_resize_mode()
        for _, key in ipairs(keys) do
            pcall(vim.keymap.del, "n", key, { buffer = bufnr })
        end
    end

    local opts = { buffer = bufnr, nowait = true, silent = true }
    vim.keymap.set("n", "h", "<cmd>vertical resize -2<cr>", opts)
    vim.keymap.set("n", "l", "<cmd>vertical resize +2<cr>", opts)
    vim.keymap.set("n", "j", "<cmd>resize +1<cr>", opts)
    vim.keymap.set("n", "k", "<cmd>resize -1<cr>", opts)
    vim.keymap.set("n", "q", exit_resize_mode, opts)
    vim.keymap.set("n", "<Esc>", exit_resize_mode, opts)
    vim.notify("Resize mode: h/l width, j/k height, q/Esc quit")
end

vim.api.nvim_create_user_command("ResizeMode", M.start_resize_mode, {})

return M
