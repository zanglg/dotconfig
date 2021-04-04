local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}

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
        provider = function()
            return ""
        end,
        highlight = {colors.blue, colors.background}
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                v = "VISUAL",
                V = "VISUAL LINE",
                [""] = "VISUAL BLOCK"
            }
            return alias[vim.fn.mode()]
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
        provider = function()
            return ""
        end,
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
        provider = function()
            return ""
        end,
        highlight = {colors.blue, colors.background}
    }
}
