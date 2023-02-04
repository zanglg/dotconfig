local M = {}

M.format = function(client, buf)
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
        buffer = buf,
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
end

return M
