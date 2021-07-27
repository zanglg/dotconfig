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
