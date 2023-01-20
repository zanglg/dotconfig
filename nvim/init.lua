require("configs.opts")
require("configs.nova")
require("configs.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        -- require("config.cmds")
        -- require("config.maps")
    end,
})
