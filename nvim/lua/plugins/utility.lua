return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = function()
            require("glow").setup({
                border = "single",
            })
        end,
    },
}
