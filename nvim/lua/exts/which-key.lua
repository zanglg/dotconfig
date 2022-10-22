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
            i = { require("telescope.builtin").lsp_implementations, "implementation" },
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
    }, { mode = "n" })
end

return M
