-- VeryLazy loaded custom autocmds.

vim.api.nvim_create_autocmd("WinEnter", {
    group = vim.api.nvim_create_augroup("win-enter", { clear = true }),
    callback = function()
        vim.wo.cursorcolumn = true -- enable highlight current column
        vim.wo.cursorline = true -- enable highligh current line
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = vim.api.nvim_create_augroup("win-leave", { clear = true }),
    callback = function()
        vim.wo.cursorcolumn = false -- clear highlight current column
        vim.wo.cursorline = false -- clear highligh current line
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("quickfix", { clear = true }),
    pattern = "qf",
    callback = function(event)
        vim.keymap.set("n", "K", "<cmd>BqfToggle<cr>", {
            buffer = event.buf,
            silent = true,
        })
    end,
})
