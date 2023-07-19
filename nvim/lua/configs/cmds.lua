if vim.loop.os_uname().sysname == "Darwin" and vim.fn.executable("im-select") == 1 then
    vim.api.nvim_create_autocmd({
        "VimEnter",
        "InsertLeave",
    }, {
        callback = function()
            vim.fn.jobstart("im-select com.apple.keylayout.ABC", { detach = true })
        end,
        group = vim.api.nvim_create_augroup("im-select", { clear = true }),
    })
end

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
