local M = {}

M.toggle = function()
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

return M
