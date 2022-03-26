local telescope = {}

function telescope.setup()
    require("telescope").setup {
        defaults = {
            borderchars = {
                "─",
                "│",
                "─",
                "│",
                "┌",
                "┐",
                "┘",
                "└"
            },
            vimgrep_arguments = {
                'rg',
                '--follow',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case'
            }
        },
        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = require("telescope.actions").delete_buffer,
                    },
                    n = {
                        ["<c-d>"] = require("telescope.actions").delete_buffer,
                    }
                }
            }
        }
    }
end

return telescope
