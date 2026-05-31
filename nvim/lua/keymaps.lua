local function map(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend("force", { desc = desc, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

local function command(name)
    return ("<cmd>%s<cr>"):format(name)
end

-- Editing.
map("n", "<leader>w", command("write"), "Save")
map("n", "<leader>q", command("qall"), "Quit all")
map("n", "<leader>Q", command("qall!"), "Quit all without saving")
map("n", "<leader>,", command("nohlsearch"), "Clear search highlight")

-- Buffers.
map("n", "<leader>bd", command("bdelete"), "Delete buffer")
map("n", "<leader>bn", command("bnext"), "Next buffer")
map("n", "<leader>bp", command("bprevious"), "Previous buffer")

-- Code.
map({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, "Format")

-- Find.
for _, item in ipairs({
    { "<leader>ff", "find_files", "Find files" },
    { "<leader>fg", "live_grep_args", "Find string" },
    { "<leader>fb", "buffers", "Find buffers" },
    { "<leader>fc", "grep_string", "Find current word" },
    { "<leader>fj", "jumplist", "Find jumps" },
    { "<leader>fd", "git_status", "Find diff files" },
    { "<leader>ft", "lsp_document_symbols", "Find document symbols" },
    { "<leader>fs", "lsp_workspace_symbols", "Find workspace symbols" },
    { "<leader>fw", "lsp_dynamic_workspace_symbols", "Find all workspace symbols" },
    { "<leader>fr", "resume", "Resume picker" },
    { "<leader>fz", "zoxide list", "Smarter cd" },
}) do
    map("n", item[1], command("Telescope " .. item[2]), item[3])
end

-- Git.
for _, item in ipairs({
    { "<leader>gk", "preview_hunk", "Preview hunk" },
    { "<leader>gr", "reset_hunk", "Reset hunk" },
    { "<leader>gs", "select_hunk", "Select hunk" },
    { "<leader>gn", "next_hunk", "Next hunk" },
    { "<leader>gp", "prev_hunk", "Previous hunk" },
    { "<leader>gb", "blame_line", "Blame line" },
    { "<leader>gd", "diffthis", "Diff buffer" },
}) do
    map("n", item[1], command("Gitsigns " .. item[2]), item[3])
end

-- Navigation.
map("o", "r", "<cmd>lua require('flash').remote()<cr>", "Remote flash")
map("n", "<leader>tn", command("NvimTreeToggle"), "Toggle nvim-tree")
map("n", "<leader>ts", command("Outline!"), "Toggle outline")

-- Windows.
map("n", "<leader>W", command("ResizeMode"), "Resize mode")
map("n", "<C-h>", command("wincmd h"), "Move window left")
map("n", "<C-j>", command("wincmd j"), "Move window down")
map("n", "<C-k>", command("wincmd k"), "Move window up")
map("n", "<C-l>", command("wincmd l"), "Move window right")

-- which-key.
pcall(function()
    local wk = require("which-key")

    wk.add({
        { "g", group = "Goto" },
        { "]", group = "Next" },
        { "[", group = "Prev" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Toggle" },
    })
end)
