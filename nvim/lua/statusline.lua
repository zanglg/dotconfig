local statusline = {}

function statusline.setup()
    local gl = require("galaxyline")
    local condition = require("galaxyline.condition")
    local gls = gl.section

    local colors = {
        foreground = "#364349",
        inconspicuous = "#6c8693",
        selection = "#d3dbde",
        line = "#f0f3f4",
        background = "#fcfdfd",
        blue = "#2196f3",
        green = "#50a14f",
        purple = "#6666cc",
        red = "#e45649",
        pink = "#d81b60",
        cyan = "#2aa1ae",
        violet = "#a626a4",
        yellow = "#C18401",
        brown = "#8d6e63"
    }

    gls.left[1] = {
        FirstElement = {
            provider = function() return "" end,
            highlight = {colors.blue, colors.background}
        }
    }
    gls.left[2] = {
        ViMode = {
            provider = function()
                local mode = {
                    n = {"NORMAL", colors.blue},
                    i = {"INSERT", colors.pink},
                    c = {"COMMAND", colors.cyan},
                    c = {"COMMAND-LINE", colors.cyan},
                    V = {"VISUAL", colors.green},
                    [""] = {"VISUAL", colors.green},
                    v = {"VISUAL", colors.green},
                    Rv = {"VIRTUAL", colors.green},
                    R = {"REPLACE", colors.violet},
                    s = {"SELECT", colors.yellow},
                    S = {"SELECT", colors.yellow},
                    [""] = {"SELECT", colors.yellow},
                    ["r?"] = {":CONFIRM", colors.purple},
                    rm = {"--MORE", colors.purple},
                    ["r"] = {"HIT-ENTER", colors.purple},
                    t = {"TERMINAL", colors.purple},
                    ["!"] = {"SHELL", colors.purple}
                }
                local vmode = vim.fn.mode()
                return mode[vmode][1]
            end,
            icon = "  ",
            separator = "",
            separator_highlight = {colors.blue, colors.red},
            highlight = {colors.line, colors.blue, "bold"}
        }
    }

    gls.left[3] = {
        GitBranch = {
            provider = "GitBranch",
            condition = condition.check_git_workspace,
            icon = "  ",
            separator = "",
            separator_highlight = {colors.line, colors.red},
            highlight = {colors.line, colors.red, "bold"}
        }
    }

    gls.left[4] = {
        DiffAdd = {
            provider = "DiffAdd",
            condition = condition.hide_in_width,
            icon = "  ",
            separator = "",
            separator_highlight = {colors.line, colors.red},
            highlight = {colors.line, colors.red}
        }
    }
    gls.left[5] = {
        DiffModified = {
            provider = "DiffModified",
            condition = condition.hide_in_width,
            icon = " 柳",
            separator = "",
            separator_highlight = {colors.line, colors.red},
            highlight = {colors.line, colors.red}
        }
    }
    gls.left[6] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = condition.hide_in_width,
            icon = "  ",
            highlight = {colors.line, colors.red}
        }
    }
    gls.left[10] = {
        LeftEnd = {
            provider = function() return "" end,
            highlight = {colors.red, colors.line}
        }
    }
    gls.mid[1] = {
        FileIcon = {
            provider = {"FileIcon", "FileName"},
            condition = condition.buffer_not_empty,
            highlight = {colors.foreground, colors.line}
        }
    }
    gls.right[1] = {
        FileFormat = {
            provider = "FileFormat",
            separator = "",
            separator_highlight = {colors.red, colors.line},
            highlight = {colors.line, colors.red}
        }
    }
    gls.right[2] = {
        FileEncode = {
            provider = "FileEncode",
            separator = "",
            separator_highlight = {colors.line, colors.red},
            highlight = {colors.line, colors.red}
        }
    }
    gls.right[3] = {
        LineInfo = {
            provider = "LineColumn",
            separator = "",
            separator_highlight = {colors.blue, colors.red},
            highlight = {colors.line, colors.blue}
        }
    }
    gls.right[4] = {
        PerCent = {
            provider = "LinePercent",
            separator = "",
            separator_highlight = {colors.line, colors.blue},
            highlight = {colors.line, colors.blue}
        }
    }
    gls.right[5] = {
        RightEnd = {
            provider = function() return "" end,
            highlight = {colors.blue, colors.background}
        }
    }

end

return statusline
