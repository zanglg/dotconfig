local M = {}

M.setup = function()
    -- remap "," as map leader
    vim.g.mapleader = ","
    vim.g.maplocalleader = ","

    local wk = require("which-key")

    wk.setup({ window = { border = "single" } })

    wk.register({
        ---------- window switch ----------
        ["<c-h>"] = { require("smart-splits").move_cursor_left, "window left" },
        ["<c-j>"] = { require("smart-splits").move_cursor_down, "window down" },
        ["<c-k>"] = { require("smart-splits").move_cursor_up, "window up" },
        ["<c-l>"] = { require("smart-splits").move_cursor_right, "window right" },

        ---------- goto ----------
        g = {
            name = "goto",

            ---------- lsp ----------
            d = { require("telescope.builtin").lsp_definitions, "definition" },
            i = { require("telescope.builtin").lsp_implementations, "references" },
            r = { require("telescope.builtin").lsp_references, "reference" },
        },

        ---------- diagnostic ----------
        d = {
            name = "diagnostic",
            n = { vim.diagnostic.goto_prev, "prev diagnostic" },
            p = { vim.diagnostic.goto_next, "next diagnostic" },
            e = { vim.diagnostic.open_float, "float diagnostic" },
            q = { vim.diagnostic.setqflist, "quickfix diagnostic" },
            l = { vim.diagnostic.setloclist, "local diagnostic" },
        },

        ---------- hover ----------
        K = { vim.lsp.buf.hover, "lsp hover" },

        ---------- motion ----------
        s = { "<cmd>HopWord<cr>", "hop word" },
        f = { "<cmd>HopChar1<cr>", "hop char" },

        ---------- modify ----------
        m = {
            name = "modify",

            q = { "<cmd>quitall!<cr>", "quit all without save" },
            W = { "<cmd>wq<cr>", "quit with save" },
            w = { "<cmd>w<cr>", "save" },
            d = { "<cmd>bdelete<cr>", "delete current buffer" },
            l = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "cursor highlight group" },
        },
    }, { mode = "n" })

    ---------- normal mode, leader key mapping ------------
    wk.register({
        ---------- code ----------
        c = {
            name = "code",

            f = {
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                "document format",
            },
            c = {
                function()
                    require("gitsigns").select_hunk()

                    vim.lsp.buf.format({ async = true })
                end,
                "hunk format",
            },
            a = { vim.lsp.buf.code_action, "code action" },
            r = { vim.lsp.buf.rename, "rename" },
        },

        ---------- symbols ----------
        s = {
            name = "symbols",

            w = { require("telescope.builtin").lsp_workspace_symbols, "workspace symbols" },
            s = { require("telescope.builtin").lsp_document_symbols, "document symbols" },
        },

        ---------- find ----------
        f = {
            name = "find",

            f = { require("telescope.builtin").find_files, "find files" },
            b = { require("telescope.builtin").buffers, "find buffers" },
            g = { require("telescope.builtin").live_grep, "live grep" },
            c = { require("telescope.builtin").grep_string, "search current word" },
        },

        ---------- git ----------
        g = {
            name = "git",

            ---------- hunk ----------
            n = { require("gitsigns").next_hunk, "next hunk" },
            p = { require("gitsigns").prev_hunk, "prev hunk" },

            K = { require("gitsigns").preview_hunk, "preview hunk" },
            s = { require("gitsigns").select_hunk, "select hunk" },
        },

        ---------- toggle ----------
        t = {
            name = "toggle",

            n = { "<cmd>NvimTreeToggle<cr>", "nvim-tree" },
            s = { "<cmd>SymbolsOutline<cr>", "symbols-outline" },
        },
    }, { mode = "n", prefix = "<leader>" })

    wk.register({
        ---------- code ----------
        c = {
            name = "code",

            f = {
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                "range format",
            },
        },
    }, { mode = "v", prefix = "<leader>" })
end

return M
