return function()
    require("dressing").setup({
        input = {
            border = require("options").border,
            winblend = 0,
        },
        select = {
            backend = { "builtin" },
            builtin = {
                border = require("options").border,
                winblend = 10,
            },
        },
    })
end
