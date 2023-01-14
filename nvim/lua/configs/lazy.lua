local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local configs = {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "nova" },
    },
    ui = {
        border = "single",
    },
    performance = {
        cache = {
            enabled = true,
        },
        disabled_plugins = {},
    },
}

if vim.loop.os_uname().sysname == "Darwin" then
    configs.dev = {
        path = "~/Workspace",
        patterns = { "zanglg" },
    }
end

require("lazy").setup("plugins", configs)
