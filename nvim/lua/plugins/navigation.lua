return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "jvgrootveld/telescope-zoxide",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        cmd = { "Telescope" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",                desc = "Find String" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers" },
            { "<leader>fc", "<cmd>Telescope grep_string<cr>",                   desc = "Find Current" },
            { "<leader>fj", "<cmd>Telescope jumplist<cr>",                      desc = "Find Jumps" },
            { "<leader>fd", "<cmd>Telescope git_status<cr>",                    desc = "Find Diff Files" },
            { "<leader>ft", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Find Document Symbols" },
            { "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>",         desc = "Find Workspace Symbols" },
            { "<leader>fw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find All Worksapce Symbols" },
            { "<leader>fr", "<cmd>Telescope resume<cr>",                        desc = "Open Previous Picker" },
            { "<leader>fz", "<cmd>Telescope zoxide list<cr>",                   desc = "Smater Cd" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
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
                                ["<c-d>"] = actions.delete_buffer,
                            },
                        },
                    },
                },
                extensions = { zoxide = {} },
            })
            telescope.load_extension("live_grep_args")
            telescope.load_extension("zoxide")
        end,
    },
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                char = {
                    keys = { "f", "F", "t", "T", ";" },
                },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "m",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
        },
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
        "simrat39/symbols-outline.nvim",
        keys = {
            { "<leader>ts", "<cmd>SymbolsOutline<cr>", desc = "Toggle SymbolsOutline" },
        },
        config = function()
            require("symbols-outline").setup({})
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
        config = function()
            require("smart-splits").setup({
                resize_mode = {
                    silent = true,
                },
            })
        end,
        keys = {
            -- resize mode
            { "<leader>W", "<cmd>lua require('smart-splits').start_resize_mode()<cr>", desc = "ResizeMode" },
            -- moving between splits
            { "<c-h>",     "<cmd>lua require('smart-splits').move_cursor_left()<cr>",  desc = "MoveWinLeft" },
            { "<c-j>",     "<cmd>lua require('smart-splits').move_cursor_down()<cr>",  desc = "MoveWinDown" },
            { "<c-k>",     "<cmd>lua require('smart-splits').move_cursor_up()<cr>",    desc = "MoveWinUp" },
            { "<c-l>",     "<cmd>lua require('smart-splits').move_cursor_right()<cr>", desc = "MoveWinRight" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({ window = { border = "rounded" } })
            wk.register({
                mode = { "n" },
                ["g"] = { name = "Goto" },
                ["]"] = { name = "Next" },
                ["["] = { name = "Prev" },

                ["<leader>b"] = { name = "Buffer" },
                ["<leader>c"] = { name = "Code" },
                ["<leader>d"] = { name = "Diagnostic" },
                ["<leader>f"] = { name = "Find" },
                ["<leader>g"] = { name = "Git" },
                ["<leader>m"] = { name = "Edit" },
                ["<leader>t"] = { name = "Toggle" },

                ["<leader>q"] = { "<cmd>qall <cr>", "Quit All" },
                ["<leader>Q"] = { "<cmd>qall!<cr>", "Quit All Without Save" },
                ["<leader>w"] = { "<cmd>w    <cr>", "Save" },
                ["<leader>W"] = { "<cmd>wqall<cr>", "Save All and Quit" },
                ["<leader>,"] = { "<cmd>noh  <cr>", "No Highlight" },
            })
        end,
    },
}
