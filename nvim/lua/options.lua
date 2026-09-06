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
vim.opt.autocomplete = false
vim.opt.complete = { ".^5", "w^5", "b^5", "o^10" }
vim.opt.completeopt = { "menuone", "popup", "preinsert" }
vim.opt.mouse = ""

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

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

local autocomplete_group = vim.api.nvim_create_augroup("config-autocomplete", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = autocomplete_group,
    callback = function(args)
        vim.api.nvim_set_option_value("autocomplete", false, { buf = args.buf })
    end,
})

vim.api.nvim_create_autocmd("TextChangedI", {
    group = autocomplete_group,
    callback = function(args)
        if not vim.api.nvim_get_option_value("autocomplete", { buf = args.buf }) then
            vim.api.nvim_set_option_value("autocomplete", true, { buf = args.buf })
        end
    end,
})

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
