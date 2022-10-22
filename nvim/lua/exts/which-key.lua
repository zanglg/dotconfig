local M = {}

M.setup = function()
    -- remap "," as map leader
    vim.g.mapleader = ","
    vim.g.maplocalleader = ","

    local wk = require("which-key")
    local ss = require("smart-splits")
    local dia = vim.diagnostic
    local lsp = vim.lsp.buf

    wk.setup({ window = { border = "single" } })

    wk.register({
        ---------- window switch ----------
        ["<c-h>"] = { ss.move_cursor_left, "window left" },
        ["<c-j>"] = { ss.move_cursor_down, "window down" },
        ["<c-k>"] = { ss.move_cursor_up, "window up" },
        ["<c-l>"] = { ss.move_cursor_right, "window right" },

        ---------- goto ----------
        g = {
            name = "goto",

            ---------- lsp ----------
            d = { lsp.definition, "definition" },
            D = { lsp.declaration, "declaration" },
            k = { lsp.hover, "hover" },
            K = { lsp.signature_help, "signature help" },
            f = { lsp.format, "format" },
            F = { lsp.format, "format" },
            r = { lsp.references, "reference" },
            R = { lsp.rename, "rename" },
            a = { lsp.code_action, "action" },
            A = { lsp.range_code_action, "range action" },
            I = { lsp.implementation, "implementation" },
            s = { lsp.document_symbol, "document symbol" },
            S = { lsp.workspace_symbol, "workspace symbol" },
        },

        ---------- diagnostic ----------
        d = {
            name = "diagnostic",

            n = { dia.goto_prev, "prev diagnostic" },
            p = { dia.goto_next, "next diagnostic" },
            e = { dia.open_float, "float diagnostic" },
            q = { dia.setqflist, "quickfix diagnostic" },
            l = { dia.setloclist, "local diagnostic" },
        },

        ---------- motion ----------
        s = { "<cmd>HopWord<cr>", "hop word" },
        f = { "<cmd>HopChar1<cr>", "hop char" },
    }, { mode = "n" })
end

return M
