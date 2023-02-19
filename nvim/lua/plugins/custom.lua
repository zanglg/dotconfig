return {
    {
        "configs/custom",
        dir = "configs",
        keys = {
            { "<c-n>", "*<cmd>noh<cr>", desc = "Next Reference", mode = "n" },
            { "<c-p>", "#<cmd>noh<cr>", desc = "Prev Reference", mode = "n" },

            { "q", require("configs/custom").quickfix_toggle, desc = "Quickfix Toggle" },
            { "<c-l>", require("configs/custom").escape_pair, desc = "Jump Out Pair", mode = "i" },
        },
    },
}
