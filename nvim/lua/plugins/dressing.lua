return function()
    require("dressing").setup({
        input = {
            border = "single",
            winblend = 0,
        },
        select = {
            backend = { "builtin" },
            builtin = {
                border = "single",
                winblend = 10,
            },
        },
    })
end
