local M = {}

M.setup = function()
    -- remap "," as map leader
    vim.g.mapleader = ","
    vim.g.maplocalleader = ","

    local diagnostic = vim.diagnostic
    local lsp = vim.lsp

    local wk = require("which-key")
    local ss = require("smart-splits")
    local builtin = require("telescope.builtin")

    local quickfix = require("cust").quickfix

    wk.setup({ window = { border = "single" } })

    wk.register({
        ---------- window switch ----------
        ["<c-h>"] = { ss.move_cursor_left, "window left" },
        ["<c-j>"] = { ss.move_cursor_down, "window down" },
        ["<c-k>"] = { ss.move_cursor_up, "window up" },
        ["<c-l>"] = { ss.move_cursor_right, "window right" },
        ["<c-w>"] = { ss.start_resize_mode, "window resize" },

        ---------- goto ----------
        g = {
            name = "goto",

            ---------- lsp ----------
            d = { lsp.buf.definition, "definition" },
            D = { lsp.buf.declaration, "declaration" },
            k = { lsp.buf.hover, "hover" },
            K = { lsp.buf.signature_help, "signature help" },
            f = { lsp.buf.format, "format" },
            F = { lsp.buf.format, "format" },
            r = { lsp.buf.references, "reference" },
            R = { lsp.buf.rename, "rename" },
            a = { lsp.buf.code_action, "action" },
            A = { lsp.buf.range_code_action, "range action" },
            I = { lsp.buf.implementation, "implementation" },
            s = { lsp.buf.document_symbol, "document symbol" },
            S = { lsp.buf.workspace_symbol, "workspace symbol" },
        },

        ---------- telescope pickers ----------
        m = {
            name = "pickers",

            ---------- File Pickers ----------
            f = { builtin.find_files, "find files" },
            s = { builtin.grep_string, "search current cursor" },
            g = { builtin.live_grep, "live grep" },

            ---------- Vim Pickers ----------
            b = { builtin.buffers, "buffers" },
            q = { builtin.quickfix, "quickfix" },
            j = { builtin.jumplist, "jump list" },
        },

        ---------- diagnostic ----------
        d = {
            name = "diagnostic",

            n = { diagnostic.goto_prev, "prev diagnostic" },
            p = { diagnostic.goto_next, "next diagnostic" },
            e = { diagnostic.open_float, "float diagnostic" },
            q = { diagnostic.setqflist, "quickfix diagnostic" },
            l = { diagnostic.setloclist, "local diagnostic" },
        },

        ---------- motion ----------
        s = { "<cmd>HopWord<cr>", "hop word" },
        f = { "<cmd>HopChar1<cr>", "hop char" },

        ---------- quickfix ----------
        q = { quickfix.toggle, "quickfix toggle" },
    }, { mode = "n" })

    wk.register({
        [","] = { "<cmd>noh<cr>", "clear hlsearch" },
        N = { "<cmd>NvimTreeToggle<cr>", "nvim tree toggle" },
    }, { mode = "n", prefix = "<leader>" })
end

return M
