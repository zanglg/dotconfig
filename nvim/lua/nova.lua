local nova = {}

nova.palette = {
    foreground = "#ECEFF1",
    inconspicuous = "#B0BEC5",
    selection = "#455A64",
    line = "#37474F",
    background = "#263238",

    red = "#EF5350",
    pink = "#EC407A",
    purple = "#AB47BC",
    deep_purple = "#7E57C2",
    indigo = "#5C6BC0",
    blue = "#42A5F5",
    light_blue = "#29B6F6",
    cyan = "#26C6DA",
    teal = "#26A69A",
    green = "#66BB6A",
    light_green = "#9CCC65",
    lime = "#D4E157",
    yellow = "#FFEE58",
    amber = "#FFCA28",
    orange = "#FFA726",
    deep_orange = "#FF7043",
    brown = "#8D6E63",

    bold = "bold",
    none = "none",
    reverse = "reverse",
    undercurl = "undercurl",
    underline = "underline"
}

function nova.highlight(group, color)
    local cmd = vim.api.nvim_command

    local st = color.st and 'gui=' .. color.st or 'gui=NONE'
    local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
    local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
    local sp = color.sp and 'guisp=' .. color.sp or 'guisp=NONE'
    cmd('hi ' .. group .. ' ' .. st .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
end

function nova.load_syntax()
    local p = nova.palette

    local classes = {
        general = {
            Normal = {fg = p.foreground, bg = p.background},
            ColorColumn = {bg = p.line},
            CursorColumn = {bg = p.line},
            CursorLine = {bg = p.line},
            VertSplit = {fg = p.line, bg = p.line},
            Visual = {bg = p.selection},
            LineNr = {fg = p.inconspicuous},
            CursorLineNr = {fg = p.deep_orange, p.bold},
            Folded = {fg = p.selection, bg = p.background},
            FoldColumn = {fg = p.selection, bg = p.background},
            SignColumn = {fg = p.blue, bg = p.background},
            Pmenu = {fg = p.foreground, bg = p.selection},
            PmenuSbar = {bg = p.inconspicuous},
            PmenuSel = {fg = p.selection, bg = p.blue},
            PmenuThumb = {bg = p.inconspicuous},
            DiffAdd = {fg = p.light_green, bg = p.line},
            DiffChange = {bg = p.line},
            DiffDelete = {fg = p.red, bg = p.line},
            DiffText = {fg = p.red, bg = p.line, p.bold},
            Directory = {fg = p.blue},
            Search = {fg = p.background, bg = p.orange},
            IncSearch = {fg = p.background, bg = p.orange},
            MatchParen = {fg = p.background, bg = p.orange},
            ModeMsg = {fg = p.light_green},
            MoreMsg = {fg = p.light_green},
            Question = {fg = p.light_green, p.bold},
            WarningMsg = {fg = p.red},
            ErrorMsg = {fg = p.red},
            StatusLine = {fg = p.lime, bg = p.line},
            StatusLineNC = {fg = p.foreground, bg = p.line},
            TabLine = {fg = p.foreground, bg = p.line},
            TabLineFill = {bg = p.line},
            TabLineSel = {fg = p.lime, bg = p.line},
            NonText = {fg = p.inconspicuous},
            SpecialKey = {fg = p.inconspicuous},
            SpellBad = {st = p.undercurl},
            SpellCap = {st = p.undercurl},
            SpellLocal = {st = p.undercurl},
            SpellRare = {st = p.undercurl},
            Title = {fg = p.orange, st = p.bold},
            WildMenu = {fg = p.red, bg = p.line, st = p.bold}
        },
        standard = {
            Boolean = {fg = p.amber},
            Character = {fg = p.amber},
            Comment = {fg = p.inconspicuous},
            Conditional = {fg = p.deep_orange},
            Constant = {fg = p.amber},
            Debug = {fg = p.foreground},
            Define = {fg = p.purple},
            Delimiter = {fg = p.foreground},
            EndOfBuffer = {fg = p.selection, st = p.bold},
            Error = {fg = p.foreground},
            Exception = {fg = p.light_green, st = p.bold},
            Float = {fg = p.amber},
            Function = {fg = p.blue},
            Identifier = {fg = p.red},
            Ignore = {fg = p.inconspicuous},
            Include = {fg = p.blue},
            Keyword = {fg = p.light_green, st = p.bold},
            Label = {fg = p.light_green, st = p.bold},
            Macro = {fg = p.cyan},
            Number = {fg = p.amber, st = p.bold},
            Operator = {fg = p.teal, st = p.bold},
            PreCondit = {fg = p.cyan},
            PreProc = {fg = p.cyan},
            Repeat = {fg = p.purple},
            Special = {fg = p.foreground},
            SpecialChar = {fg = p.foreground},
            SpecialComment = {fg = p.foreground},
            Statement = {fg = p.light_green, st = p.bold},
            StorageClass = {fg = p.cyan, st = p.none},
            String = {fg = p.light_green},
            Structure = {fg = p.purple},
            Tag = {fg = p.foreground},
            Todo = {fg = p.pink, st = p.bold},
            Type = {fg = p.pink, st = p.none},
            Typedef = {fg = p.pink, st = p.none},
            Underlined = {fg = p.blue, st = p.underline}
        }
    }

    for _, class in pairs(classes) do
        for group, color in pairs(class) do nova.highlight(group, color) end
    end
end

function nova.setup()
    vim.api.nvim_command('hi clear')
    vim.api.nvim_command('syntax reset')

    vim.o.background = 'dark'
    vim.o.termguicolors = true

    nova.load_syntax()
end

return nova
