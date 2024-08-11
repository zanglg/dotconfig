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

