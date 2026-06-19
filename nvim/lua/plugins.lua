pcall(function()
    require("nova").setup({ theme = "dark", popup_style = "bordered" })
end)
pcall(vim.cmd.colorscheme, "nova")

pcall(function()
    require("lualine").setup({
        options = {
            theme = "nova",
            globalstatus = true,
        },
        sections = {
            lualine_c = {
                { "filename", file_status = true, path = 1 },
            },
        },
        extensions = { "quickfix", "nvim-tree" },
    })
end)

pcall(function()
    require("which-key").setup()
end)

pcall(function()
    require("noice").setup({
        cmdline = {
            view = "cmdline",
        },
    })
end)

pcall(function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        pickers = {
            buffers = {
                mappings = {
                    i = { ["<C-d>"] = actions.delete_buffer },
                },
            },
            grep_string = {
                additional_args = { "--follow" },
            },
        },
        extensions = {
            live_grep_args = {
                additional_args = { "--follow" },
            },
            zoxide = {},
        },
    })

    pcall(telescope.load_extension, "live_grep_args")
    pcall(telescope.load_extension, "zoxide")
end)

pcall(function()
    require("flash").setup({
        modes = {
            search = { enabled = false },
            char = { keys = { "f", "F", "t", "T", ";" } },
        },
    })
end)

pcall(function()
    require("nvim-tree").setup()
end)

pcall(function()
    require("outline").setup({})
end)

pcall(function()
    require("nvim-autopairs").setup({})
end)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/completion", args.buf) then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.lsp.enable({ "clangd", "rust_analyzer" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

pcall(function()
    require("rainbow-delimiters.setup").setup({})
end)

pcall(function()
    require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>, <abbrev_sha> - <summary>",
    })
end)
