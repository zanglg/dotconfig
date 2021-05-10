local nova = {}

function hsl2rgb(h, s, l)
    local c = (1 - math.abs(2 * l - 1)) * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = l - c / 2

    if (0 <= h and h < 60) then
        r, g, b = c, x, 0
    elseif (60 <= h and h < 120) then
        r, g, b = x, c, 0
    elseif (120 <= h and h < 180) then
        r, g, b = 0, c, x
    elseif (180 <= h and h < 240) then
        r, g, b = 0, x, c
    elseif (240 <= h and h < 300) then
        r, g, b = x, 0, c
    elseif (300 <= h and h < 360) then
        r, g, b = c, 0, x
    end

    r, g, b = ((r + m) * 255), ((g + m) * 255), ((b + m) * 255)

    function round(float)
        return math.floor(float + .5)
    end

    sr = string.format("%02x", round(r))
    sg = string.format("%02x", round(g))
    sb = string.format("%02x", round(b))

    return "#" .. sr .. sg .. sb
end

nova.palette = {
    light = {
        foreground    = "#364349",
        inconspicuous = "#6c8693",
        selection     = "#d3dbde",
        line          = "#f0f3f4",
        background    = "#fcfdfd",

        blue          = "#2196f3",
        green         = "#50a14f",
        purple        = "#6666cc",
        red           = "#e45649",
        pink          = "#d81b60",
        cyan          = "#2aa1ae",
        violet        = "#a626a4",
        yellow        = "#C18401",
        brown         = "#8d6e63",

        bold          = "bold",
        none          = "none",
        reverse       = "reverse",
        undercurl     = "undercurl",
        underline     = "underline"
    },
    dark = {
        foreground    = hsl2rgb(220, 0.13, 0.80),
        inconspicuous = hsl2rgb(220, 0.13, 0.70),
        selection     = hsl2rgb(220, 0.13, 0.30),
        line          = hsl2rgb(220, 0.13, 0.22),
        background    = hsl2rgb(220, 0.13, 0.18),

        red           = hsl2rgb(355, 0.65, 0.65),
        brown         = hsl2rgb(16, 0.18, 0.47),
        yellow        = hsl2rgb(39, 0.67, 0.69),
        green         = hsl2rgb(95, 0.38, 0.62),
        cyan          = hsl2rgb(187, 0.47, 0.55),
        blue          = hsl2rgb(207, 0.82, 0.66),
        violet        = hsl2rgb(240, 0.40, 0.67),
        purple        = hsl2rgb(286, 0.60, 0.67),

        bold          = "bold",
        none          = "none",
        reverse       = "reverse",
        undercurl     = "undercurl",
        underline     = "underline"
    }
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
    local p = nova.palette.dark

    local classes = {
        general = {
            Normal = {fg = p.foreground, bg = p.background},
            ColorColumn = {bg = p.line},
            CursorColumn = {bg = p.line},
            CursorLine = {bg = p.line},
            VertSplit = {fg = p.line, bg = p.line},
            Visual = {bg = p.selection},
            LineNr = {fg = p.inconspicuous},
            CursorLineNr = {fg = p.yellow, p.bold},
            Folded = {fg = p.selection},
            FoldColumn = {fg = p.selection},
            SignColumn = {fg = p.blue},
            Pmenu = {fg = p.foreground, bg = p.selection},
            PmenuSbar = {bg = p.inconspicuous},
            PmenuSel = {fg = p.selection, bg = p.blue},
            PmenuThumb = {bg = p.inconspicuous},
            DiffAdd = {fg = p.green, bg = p.line},
            DiffChange = {bg = p.line},
            DiffDelete = {fg = p.red, bg = p.line},
            DiffText = {fg = p.red, bg = p.line, p.bold},
            Directory = {fg = p.blue},
            Search = {fg = p.background, bg = p.yellow},
            IncSearch = {fg = p.background, bg = p.yellow},
            MatchParen = {fg = p.background, bg = p.yellow},
            ModeMsg = {fg = p.green},
            MoreMsg = {fg = p.green},
            Question = {fg = p.green, p.bold},
            WarningMsg = {fg = p.red},
            ErrorMsg = {fg = p.red},
            StatusLine = {fg = p.yellow, bg = p.line},
            StatusLineNC = {fg = p.foreground, bg = p.line},
            TabLine = {fg = p.foreground, bg = p.line},
            TabLineFill = {bg = p.line},
            TabLineSel = {fg = p.yellow, bg = p.line},
            NonText = {fg = p.inconspicuous},
            SpecialKey = {fg = p.inconspicuous},
            SpellBad = {st = p.undercurl},
            SpellCap = {st = p.undercurl},
            SpellLocal = {st = p.undercurl},
            SpellRare = {st = p.undercurl},
            Title = {fg = p.yellow, st = p.bold},
            WildMenu = {fg = p.red, bg = p.line, st = p.bold},
        },
        standard = {
            Boolean = {fg = p.yellow},
            Character = {fg = p.yellow},
            Comment = {fg = p.inconspicuous},
            Conditional = {fg = p.purple},
            Constant = {fg = p.yellow},
            Debug = {fg = p.yellow},
            Define = {fg = p.cyan},
            Delimiter = {fg = p.green},
            EndOfBuffer = {fg = p.inconspicuous},
            Error = {fg = p.red},
            Exception = {fg = p.purple},
            Float = {fg = p.yellow},
            Function = {fg = p.blue},
            Identifier = {fg = p.foreground},
            Ignore = {fg = p.inconspicuous},
            Include = {fg = p.violet},
            Keyword = {fg = p.purple},
            Label = {fg = p.purple},
            Macro = {fg = p.purple},
            Number = {fg = p.yellow},
            Operator = {fg = p.green},
            PreCondit = {fg = p.yellow},
            PreProc = {fg = p.blue},
            Repeat = {fg = p.purple},
            Special = {fg = p.inconspicuous},
            SpecialChar = {fg = p.inconspicuous},
            SpecialComment = {fg = p.inconspicuous},
            Statement = {fg = p.purple},
            StorageClass = {fg = p.purple},
            String = {fg = p.green},
            Structure = {fg = p.purple},
            Tag = {fg = p.red, st = p.bold},
            Todo = {fg = p.red, st = p.bold},
            Type = {fg = p.red},
            Typedef = {fg = p.red},
            Underlined = {fg = p.blue, st = p.underline},
        },
        treesitter = {
            TSBoolean = {fg = p.yellow},
            TSCharacter = {fg = p.yellow},
            TSComment = {fg = p.inconspicuous},
            TSConditional = {fg = p.red},
            TSConstant = {fg = p.yellow},
            TSConstBuiltin = {fg = p.yellow},
            TSConstMacro = {fg = p.yellow},
            TSError = {fg = p.red},
            TSException = {fg = p.purple},
            TSField = {fg = p.violet},
            TSFloat = {fg = p.yellow},
            TSFunction = {fg = p.blue},
            TSFuncBuiltin = {fg = p.blue},
            TSFuncMacro = {fg = p.blue},
            TSInclude = {fg = p.violet},
            TSKeyword = {fg = p.purple},
            TSKeywordFunction = {fg = p.purple},
            TSLabel = {fg = p.purple},
            TSMethod = {fg = p.violet},
            TSNamespace = {fg = p.purple},
            TSNumber = {fg = p.yellow},
            TSOperator = {fg = p.cyan},
            TSParameter = {fg = p.brown},
            TSParameterReference = {fg = p.brown},
            TSProperty = {fg = p.violet},
            TSPunctDelimiter = {fg = p.cyan},
            TSPunctBracket = {fg = p.cyan},
            TSPunctSpecial = {fg = p.cyan},
            TSRepeat = {fg = p.red},
            TSString = {fg = p.green},
            TSStringRegex = {fg = p.green},
            TSStringEscape = {fg = p.green},
            TSTag = {fg = p.red},
            TSTagDelimiter = {fg = p.cyan},
            TSText = {fg = p.foreground},
            TSEmphasis = {fg = p.foreground, st = p.bold},
            TSUnderline = {fg = p.foreground, st = p.underline},
            TSStrike = {fg = p.foreground, st = p.strikethrough},
            TSTitle = {fg = p.blue},
            TSLiteral = {fg = p.blue},
            TSURI = {fg = p.red, st = p.underline},
            TSType = {fg = p.red},
            TSTypeBuiltin = {fg = p.red},
            TSVariable = {fg = p.foreground},
            TSVariableBuiltin = {fg = p.foreground},
        },
        treesitter_rainbow = {
            rainbowcol1 = {fg = p.red},
            rainbowcol2 = {fg = p.yellow},
            rainbowcol3 = {fg = p.green},
            rainbowcol4 = {fg = p.cyan},
            rainbowcol5 = {fg = p.blue},
            rainbowcol6 = {fg = p.violet},
            rainbowcol7 = {fg = p.purple},
        },
        lsp = {
            LspDiagnosticsDefaultHint = {fg = p.inconspicuous},
            LspDiagnosticsDefaultError = {fg = p.inconspicuous},
            LspDiagnosticsDefaultWarning = {fg = p.inconspicuous},
            LspDiagnosticsDefaultInformation = {fg = p.inconspicuous},
            LspDiagnosticsUnderlineError = {fg = p.red},
            LspDiagnosticsUnderlineWarning = {fg = p.yellow},
            LspDiagnosticsUnderlineInformation = {fg = p.green},
            LspDiagnosticsUnderlineHint = {fg = p.inconspicuous},
        }
    }

    for _, class in pairs(classes) do
        for group, color in pairs(class) do nova.highlight(group, color) end
    end
end

function nova.init()
    vim.api.nvim_command('hi clear')
    vim.api.nvim_command('syntax reset')

    vim.o.background = 'light'
    vim.o.termguicolors = true
    vim.g.colors_name = 'nova'

    nova.load_syntax()
end

return nova
