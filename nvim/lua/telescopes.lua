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
        }
    }
end

return telescope
