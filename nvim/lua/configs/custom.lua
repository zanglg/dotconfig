local M = {}

M.format = function(client, buf)
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
        buffer = buf,
        callback = function()
            if client.name == "clangd" then
                require("gitsigns").select_hunk()
            end
            vim.lsp.buf.format({ async = false })
        end,
    })
end

M.quickfix_toggle = function()
    local has_quickfix = function()
        for _, info in ipairs(vim.fn.getwininfo()) do
            if info.quickfix == 1 and info.loclist == 0 then
                return true
            end
        end
        return false
    end

    if has_quickfix() == true then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end

M.escape_pair = function()
    local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local after = line:sub(col + 1, -1)
    local closer_col = #after + 1
    local closer_i = nil
    for i, closer in ipairs(closers) do
        local cur_index, _ = after:find(closer)
        if cur_index and (cur_index < closer_col) then
            closer_col = cur_index
            closer_i = i
        end
    end
    if closer_i then
        vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
    else
        vim.api.nvim_win_set_cursor(0, { row, col + 1 })
    end
end

return M
