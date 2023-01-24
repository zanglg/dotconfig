return {
    {
        "lewis6991/gitsigns.nvim",
        cmd = { "Gitsigns" },
        keys = {
            { "<leader>gk", "<cmd>Gitsigns preview_hunk<cr>", desc = "Hunk Preview" },
            { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Hunk Next" },
            { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Hunk Prev" },
            { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
        },
        config = function()
            require("gitsigns").setup({
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>, <abbrev_sha> - <summary>",
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "DiffviewClose",
            "DiffviewFileHistory",
            "DiffviewFocusFiles",
            "DiffviewLog",
            "DiffviewOpen",
            "DiffviewRefresh",
            "DiffviewToggleFiles",
        },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
            { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
        },
    },
}
