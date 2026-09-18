require("nova").setup({
    theme = "dark",
    variant = "default",
})
vim.cmd.colorscheme("nova")

local nova_config = require("nova.config")
local status_colors = require("nova.colors").setup(nova_config.options, nova_config.resolve_theme())
local mode_colors = {
    n = status_colors.blue,
    i = status_colors.green,
    v = status_colors.violet,
    V = status_colors.violet,
    ["\22"] = status_colors.violet,
    s = status_colors.violet,
    S = status_colors.violet,
    ["\19"] = status_colors.violet,
    R = status_colors.red,
    c = status_colors.yellow,
    t = status_colors.teal,
}

local function lsp_names()
    local names, seen = {}, {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if not seen[client.name] then
            names[#names + 1] = client.name
            seen[client.name] = true
        end
    end
    table.sort(names)
    return table.concat(names, ", ")
end

require("lualine").setup({
    options = {
        theme = "nova",
        globalstatus = true,
        component_separators = { left = "•", right = "•" },
        section_separators = "",
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                function() return " NVIM" end,
                color = { fg = status_colors.background, bg = status_colors.blue, gui = "bold" },
                separator = { right = "" },
                padding = 1,
            },
            {
                "mode",
                color = function()
                    local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                    return { fg = mode_colors[mode] or status_colors.blue, gui = "bold" }
                end,
            },
            {
                "filename",
                file_status = true,
                path = 0,
                separator = "",
                color = function()
                    return { fg = vim.bo.modified and status_colors.yellow or status_colors.foreground }
                end,
            },
            {
                "branch",
                -- Keep the leading dot with the branch so both hide outside Git.
                icon = "• ",
                color = { fg = status_colors.violet },
                separator = "",
                padding = { left = 0, right = 1 },
            },
            {
                -- A second alignment point gives dynamic content its own middle area.
                function() return "%=" end,
                separator = "",
                padding = 0,
            },
            {
                "diff",
                -- Reuse gitsigns' live buffer counts without running Git on redraw.
                source = function()
                    local status = vim.b.gitsigns_status_dict
                    if status then
                        return {
                            added = status.added,
                            modified = status.changed,
                            removed = status.removed,
                        }
                    end
                end,
                symbols = { added = " ", modified = " ", removed = " " },
                diff_color = {
                    added = { fg = status_colors.green },
                    modified = { fg = status_colors.yellow },
                    removed = { fg = status_colors.red },
                },
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = { error = " ", warn = " " },
                diagnostics_color = {
                    error = { fg = status_colors.red },
                    warn = { fg = status_colors.yellow },
                },
            },
            {
                lsp_names,
                icon = "",
                color = { fg = status_colors.teal },
                cond = function()
                    return vim.o.columns >= 100
                end,
            },
        },
        lualine_x = {
            {
                "filetype",
                icons_enabled = true,
                colored = true,
                color = { fg = status_colors.foreground },
            },
            {
                "location",
                icon = "",
                color = { fg = status_colors.foreground },
                separator = "",
                padding = { left = 1, right = 2 },
            },
        },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "quickfix", "nvim-tree" },
})

require("which-key").setup()

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

vim.lsp.enable({ "clangd", "rust_analyzer", "pyright" })

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
