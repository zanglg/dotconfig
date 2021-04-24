local nova = {}

nova.palette = {
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
            CursorLineNr = {fg = p.orange, p.bold},
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
            Search = {fg = p.background, bg = p.orange},
            IncSearch = {fg = p.background, bg = p.orange},
            MatchParen = {fg = p.background, bg = p.orange},
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
            Title = {fg = p.orange, st = p.bold},
            WildMenu = {fg = p.red, bg = p.line, st = p.bold},
        },
        standard = {
            Boolean = {fg = p.yellow},
            Character = {fg = p.yellow},
            Comment = {fg = p.inconspicuous},
            Conditional = {fg = p.violet},
            Constant = {fg = p.yellow},
            Debug = {fg = p.yellow},
            Define = {fg = p.cyan},
            Delimiter = {fg = p.green},
            EndOfBuffer = {fg = p.inconspicuous},
            Error = {fg = p.red},
            Exception = {fg = p.violet},
            Float = {fg = p.yellow},
            Function = {fg = p.blue},
            Identifier = {fg = p.foreground},
            Ignore = {fg = p.inconspicuous},
            Include = {fg = p.purple},
            Keyword = {fg = p.violet},
            Label = {fg = p.violet},
            Macro = {fg = p.violet},
            Number = {fg = p.yellow},
            Operator = {fg = p.green},
            PreCondit = {fg = p.yellow},
            PreProc = {fg = p.blue},
            Repeat = {fg = p.violet},
            Special = {fg = p.inconspicuous},
            SpecialChar = {fg = p.inconspicuous},
            SpecialComment = {fg = p.inconspicuous},
            Statement = {fg = p.violet},
            StorageClass = {fg = p.violet},
            String = {fg = p.green},
            Structure = {fg = p.violet},
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
            TSConditional = {fg = p.pink},
            TSConstant = {fg = p.yellow},
            TSConstBuiltin = {fg = p.yellow},
            TSConstMacro = {fg = p.yellow},
            TSError = {fg = p.red},
            TSException = {fg = p.violet},
            TSField = {fg = p.purple},
            TSFloat = {fg = p.yellow},
            TSFunction = {fg = p.blue},
            TSFuncBuiltin = {fg = p.blue},
            TSFuncMacro = {fg = p.blue},
            TSInclude = {fg = p.purple},
            TSKeyword = {fg = p.violet},
            TSKeywordFunction = {fg = p.violet},
            TSLabel = {fg = p.violet},
            TSMethod = {fg = p.purple},
            TSNamespace = {fg = p.violet},
            TSNumber = {fg = p.yellow},
            TSOperator = {fg = p.cyan},
            TSParameter = {fg = p.brown},
            TSParameterReference = {fg = p.cyan},
            TSProperty = {fg = p.purple},
            TSPunctDelimiter = {fg = p.cyan},
            TSPunctBracket = {fg = p.cyan},
            TSPunctSpecial = {fg = p.cyan},
            TSRepeat = {fg = p.pink},
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
 
