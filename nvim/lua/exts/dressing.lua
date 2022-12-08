return function()
    require("dressing").setup({
        input = {
            border = "single",
            win_options = {
                winblend = 0,
            },
        },
        select = {
            backend = { "builtin" },
            builtin = {
                border = "single",
                win_options = {
                    winblend = 0,
                },
            },
        },
    })
end
