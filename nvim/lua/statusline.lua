local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}

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
    Separator1 = {
        provider = function()
            return " "
        end,
        highlight = {colors.background, colors.blue}
    }
}

gls.left[2] = {
    VimIcon = {
        provider = function()
            return " "
        end,
        highlight = {colors.line, colors.blue}
    }
}

gls.left[3] = {
    Separator2 = {
        provider = function()
            return " "
        end,
        highlight = {colors.blue, colors.line}
    }
}
