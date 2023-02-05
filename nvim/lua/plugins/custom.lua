return {
    {
        "configs/quickfix",
        dir = "configs",
        keys = {
            { "<c-n>", "*<cmd>noh<cr>", desc = "Next Reference", mode = "n" },
            { "<c-p>", "#<cmd>noh<cr>", desc = "Prev Reference", mode = "n" },

            { "q", require("configs/quickfix").toggle, desc = "Quickfix Toggle" },
        },
    },
}
