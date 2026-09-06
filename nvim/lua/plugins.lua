require("nova").setup({ theme = "dark" })
vim.cmd.colorscheme("nova")

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

require("which-key").setup()

require("noice").setup({
    cmdline = {
        view = "cmdline",
    },
})

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

require("flash").setup({
    modes = {
        search = { enabled = false },
        char = { keys = { "f", "F", "t", "T", ";" } },
    },
})

require("nvim-tree").setup()
require("outline").setup({})
require("nvim-autopairs").setup({})

local lsp_group = vim.api.nvim_create_augroup("config-lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/completion", args.buf) then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.lsp.enable({ "clangd", "rust_analyzer" })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("config-treesitter", { clear = true }),
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require("rainbow-delimiters.setup").setup({})

require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>, <abbrev_sha> - <summary>",
})
