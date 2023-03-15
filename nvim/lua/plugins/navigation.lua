return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Telescope" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
            { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Current" },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--follow",
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "NvimTreeToggle" },
        keys = {
            { "<leader>tn", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        cmd = { "HopWord" },
        keys = {
            { "s", "<cmd>HopWord<cr>", desc = "Hop Word" },
        },
        config = function()
            require("hop").setup({})
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({ window = { border = "single" } })
            wk.register({
                mode = { "n" },
                ["g"] = { name = "Goto" },
                ["]"] = { name = "Next" },
                ["["] = { name = "Prev" },

                ["<leader>c"] = { name = "Code" },
                ["<leader>d"] = { name = "Diagnostics" },
                ["<leader>f"] = { name = "Find" },
                ["<leader>g"] = { name = "Git" },
                ["<leader>gh"] = { name = "Hunks" },
                ["<leader>t"] = { name = "Toggle" },
            })
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            require("smart-splits").setup({})
        end,
        keys = {
            -- resizing splits
            { "<a-h>", "<cmd>lua require('smart-splits').resize_left()<cr>", desc = "ResizeLeft" },
            { "<a-j>", "<cmd>lua require('smart-splits').resize_down()<cr>", desc = "ResizeDown" },
            { "<a-k>", "<cmd>lua require('smart-splits').resize_up()<cr>", desc = "ResizeUp" },
            { "<a-l>", "<cmd>lua require('smart-splits').resize_right()<cr>", desc = "ResizeRight" },
            -- moving between splits
            { "<c-h>", "<cmd>lua require('smart-splits').move_cursor_left()<cr>", desc = "MoveWinLeft" },
            { "<c-j>", "<cmd>lua require('smart-splits').move_cursor_down()<cr>", desc = "MoveWinDown" },
            { "<c-k>", "<cmd>lua require('smart-splits').move_cursor_up()<cr>", desc = "MoveWinUp" },
            { "<c-l>", "<cmd>lua require('smart-splits').move_cursor_right()<cr>", desc = "MoveWinRight" },
        },
    },
}
