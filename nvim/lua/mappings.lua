local M = {}

M.setup = function()
    -- remap "," as map leader
    vim.g.mapleader = ","
    vim.g.maplocalleader = ","

    local wk = require("which-key")

    wk.setup({
        window = {
            border = "single",
        },
    })

    ---------- normal mode key mapping ------------
    wk.register({
        ---------- buffer switch ----------
        ["<s-l>"] = { "<cmd>bnext<cr>", "next buffer" },
        ["<s-h>"] = { "<cmd>bprevious<cr>", "prev buffer" },

        ---------- window switch ----------
        ["<c-h>"] = { "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", "window left" },
        ["<c-j>"] = { "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", "window down" },
        ["<c-k>"] = { "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", "window up" },
        ["<c-l>"] = { "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", "window right" },

        ---------- lsp goto ----------
        ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "declaration" },
        ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "definition" },
        ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implemention" },
        ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "reference" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "hover" },

        -- code operation
        ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
        ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
        ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },

        -- diagnostic
        ["dn"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "prev diagnostic" },
        ["dp"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "next diagnostic" },
        ["de"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "float diagnostic" },
        ["dq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "local diagnostic" },

        -- hop/motion
        ["s"] = { "<cmd>HopWord<cr>", "hop word" },
        ["f"] = { "<cmd>HopChar1<cr>", "hop char" },

        ---------- telescope ----------
        ["mf"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "find files" },
        ["mg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "live grep" },
        ["mb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "find buffers" },
        ["ms"] = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "find current word" },

        ---------- sidebar toggle ----------
        ["mn"] = { "<cmd>NvimTreeToggle<cr>", "nvim-tree" },
        ["mS"] = { "<cmd>SymbolsOutline<cr>", "symbols-outline" },

        ---------- terminal manager ----------
        ["mt"] = { '<cmd>exe v:count1 . "ToggleTerm"<cr>', "terminal" },

        -- helper
        ["mq"] = { "<cmd>quitall!<cr>", "quit all without save" },
        ["mW"] = { "<cmd>wq<cr>", "quit with save" },
        ["mw"] = { "<cmd>w<cr>", "save" },
        ["md"] = { "<cmd>bdelete<cr>", "delete current buffer" },
        ["mhl"] = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "cursor highlight group" },
    })

    ---------- visual mode key mapping ------------
    wk.register({
        ---------- buffer switch ----------
        ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "format" },
        ["aa"] = { "<cmd>lua require'align'.align_to_char(1, true)<cr>", "align to char" },
        ["aw"] = {
            "<cmd>lua require'align'.align_to_string(false, true, true)<cr>",
            "align to string",
        },
        ["ar"] = {
            "<cmd>lua require'align'.align_to_string(true, true, true)<cr>",
            "align to string(pattern)",
        },
    }, { mode = "v" })

    ---------- insert mode key mapping ------------
    wk.register({
        ---------- easy move in insert mode ----------
        ["<c-h>"] = { "<left>", "move: left (insert)" },
        ["<c-j>"] = { "<down>", "move: down (insert)" },
        ["<c-l>"] = { "<right>", "move: right (insert)" },
        ["<c-k>"] = { "<up>", "move: up (insert)" },
    }, { mode = "i" })

    ---------- terminal mode key mapping ------------
    local function t(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    wk.register({
        ["<c-h>"] = { t("<c-\\><c-n><c-w>h"), "move: left (terminal)" },
        ["<c-j>"] = { t("<c-\\><c-n><c-w>j"), "move: down (terminal)" },
        ["<c-k>"] = { t("<c-\\><c-n><c-w>k"), "move: up (terminal)" },
        ["<c-l>"] = { t("<c-\\><c-n><c-w>l"), "move: right (terminal)" },
        ["<esc>"] = { t("<c-\\><c-n>"), "escape (terminal)" },
    }, { mode = "t" })
end

return M
