local M = {}

M.setup = function()
    vim.api.nvim_create_augroup("PackerCompile", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*/nvim/lua/plugins/*.lua" },
        command = "source <afile> | PackerCompile",
        group = "PackerCompile",
    })
end

return M
