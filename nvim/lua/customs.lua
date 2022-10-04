local M = {}

M.hunk_format = function()
    require("gitsigns").select_hunk()

    vim.lsp.buf.format({ async = true })
end

M.document_format = function()
    vim.lsp.buf.format({ async = true })
end

return M
