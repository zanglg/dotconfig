return {
    {
        "configs/custom",
        dir = "configs",
        keys = {
            { "<c-n>", "*<cmd>noh<cr>", desc = "Next Reference", mode = "n" },
            { "<c-p>", "#<cmd>noh<cr>", desc = "Prev Reference", mode = "n" },

            { "q", require("configs/custom").quickfix_toggle, desc = "Quickfix Toggle" },
            { "<c-l>", require("configs/custom").escape_pair, desc = "Jump Out Pair", mode = "i" },

            { "[b", "<cmd>bnext     <cr>", desc = "Next Buffer" },
            { "]b", "<cmd>bprevious <cr>", desc = "Prev Buffer" },

            { "<leader>q", "<cmd>qall<cr>", desc = "Quit All" },
            { "<leader>w", "<cmd>w   <cr>", desc = "Save" },
            { "<leader>,", "<cmd>noh <cr>", desc = "No Highlight" },
        },
    },
}
