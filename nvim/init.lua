require("configs.opts")
require("configs.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("configs.cmds")
    end,
})

vim.cmd([[colorscheme nova]])
