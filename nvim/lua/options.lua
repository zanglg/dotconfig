vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false

vim.opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "latin1" }
vim.opt.clipboard = "unnamedplus"
vim.opt.whichwrap = "<,>,h,l,[,]"
vim.opt.formatoptions = "tcqmMj"
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.mouse = ""

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.showtabline = 0
vim.opt.title = true
vim.opt.signcolumn = "yes"
vim.opt.foldenable = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.splitkeep = "screen"

if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case --follow --no-messages"
end

if vim.uv.os_uname().sysname == "Darwin" and vim.fn.executable("im-select") == 1 then
    vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("config-im-select", { clear = true }),
        callback = function()
            vim.fn.jobstart({ "im-select", "com.apple.keylayout.ABC" }, { detach = true })
        end,
    })
end
