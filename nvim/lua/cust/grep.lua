local M = {}

-- global grep prg and format
if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case --follow --no-messages"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

return M
