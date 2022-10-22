local M = {}

M.setup = function()
    -- general options of neovim
    require("core.options").setup()

    -- lsp
    require("core.lsp").setup()

    -- diagnostic
    require("core.diagnostic").setup()
end

return M
