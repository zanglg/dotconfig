if vim.loop.os_uname().sysname == "Darwin" then
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
