return {
    {
        "configs/custom",
        dir = "configs",
        keys = {
            { "<c-n>", "*<cmd>noh<cr>", desc = "Next Reference", mode = "n" },
            { "<c-p>", "#<cmd>noh<cr>", desc = "Prev Reference", mode = "n" },

            { "q", "<cmd>TroubleToggle<cr>", desc = "Quickfix Toggle" },
            { "<c-l>", require("configs/custom").escape_pair, desc = "Jump Out Pair", mode = "i" },

            { "<leader>q", "<cmd>qall <cr>", desc = "Quit All" },
            { "<leader>Q", "<cmd>qall!<cr>", desc = "Quit All Without Save" },
            { "<leader>w", "<cmd>w    <cr>", desc = "Save" },
            { "<leader>,", "<cmd>noh  <cr>", desc = "No Highlight" },
        },
    },
}
