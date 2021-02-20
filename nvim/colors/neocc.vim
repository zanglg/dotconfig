" ==============================================================================
"   Name:        neocc.vim
"   Author:      Zang Leigang <zang.lg@outlook.com>
"   License:     The MIT License (MIT)
" ==============================================================================

set background=light
highlight clear
syntax reset
let colors_name = 'neocc'

" HSL(200, 15%, 25%/50%/85%/95%/99%)
let s:foreground    = "#364349"
let s:inconspicuous = "#6c8693"
let s:selection     = "#d3dbde"
let s:line          = "#f0f3f4"
let s:background    = "#fcfdfd"

let s:blue          = "#2196f3"
let s:green         = "#50a14f"
let s:purple        = "#6666cc"
let s:red           = "#e45649"
let s:teal          = "#2aa1ae"
let s:violet        = "#a626a4"
let s:yellow        = "#C18401"

let s:bold          = "bold"
let s:none          = "none"
let s:reverse       = "reverse"
let s:undercurl     = "undercurl"
let s:underline     = "underline"
let s:strikethrough = "strikethrough"

fun! s:HL(group, guifg, guibg, gui)
	let histring = "hi " . a:group

	if a:guifg != ''
		let histring .= " guifg= " . a:guifg
	endif

	if a:guibg != ''
		let histring .= " guibg= " . a:guibg
	endif

	if a:gui != ''
		let histring .= " gui= " . a:gui
	endif

	execute histring
endfun

" General highlight group
call s:HL("ColorColumn",        ''              , s:line          , '')
call s:HL("Conceal",            ''              , s:selection     , '')
call s:HL("CursorColumn",       ''              , s:line          , '')
call s:HL("CursorLine",         ''              , s:line          , '')
call s:HL("CursorLineNr",       s:yellow        , ''              , s:bold)
call s:HL("DiffAdd",            s:green         , s:line          , '')
call s:HL("DiffChange",         s:foreground    , s:line          , '')
call s:HL("DiffDelete",         s:red           , s:line          , '')
call s:HL("DiffText",           s:violet        , s:line          , '')
call s:HL("Directory",          s:blue          , ''              , '')
call s:HL("ErrorMsg",           s:red           , s:background    , s:bold)
call s:HL("FoldColumn",         s:inconspicuous , s:background    , '')
call s:HL("Folded",             s:inconspicuous , s:background    , '')
call s:HL("IncSearch",          s:background    , s:red           , s:bold)
call s:HL("LineNr",             s:inconspicuous , ''              , '')
call s:HL("MatchParen",         ''              , s:selection     , '')
call s:HL("ModeMsg",            s:green         , s:background    , s:bold)
call s:HL("MoreMsg",            s:green         , s:background    , s:bold)
call s:HL("NonText",            s:inconspicuous , ''              , s:bold)
call s:HL("Normal",             s:foreground    , s:background    , '')
call s:HL("Pmenu",              s:foreground    , s:selection     , '')
call s:HL("PmenuSbar",          ''              , s:inconspicuous , '')
call s:HL("PmenuSel",           s:selection     , s:blue          , '')
call s:HL("PmenuThumb",         ''              , s:inconspicuous , '')
call s:HL("Question",           s:green         , ''              , s:bold)
call s:HL("Search",             s:background    , s:violet        , s:bold)
call s:HL("SignColumn",         s:inconspicuous , s:background    , '')
call s:HL("SpecialKey",         s:inconspicuous , ''              , s:bold)
call s:HL("SpellBad",           ''              , ''              , s:undercurl)
call s:HL("SpellCap",           ''              , ''              , s:undercurl)
call s:HL("SpellLocal",         ''              , ''              , s:undercurl)
call s:HL("SpellRare",          ''              , ''              , s:undercurl)
call s:HL("StatusLine",         s:yellow        , s:line          , s:bold)
call s:HL("StatusLineNC",       s:foreground    , s:line          , s:none)
call s:HL("TabLine",            s:foreground    , s:line          , s:none)
call s:HL("TabLineFill",        s:foreground    , s:line          , s:none)
call s:HL("TabLineSel",         s:yellow        , s:line          , s:bold)
call s:HL("Title",              s:blue          , ''              , s:bold)
call s:HL("VertSplit",          s:line          , s:line          , '')
call s:HL("Visual",             ''              , s:selection     , '')
call s:HL("VisualNC",           ''              , s:line          , '')
call s:HL("WarningMsg",         s:yellow        , s:background    , s:bold)
call s:HL("WildMenu",           s:red           , s:line          , '')

" Standard syntax highlight group
call s:HL("Boolean",            s:yellow        , ''              , '')
call s:HL("Character",          s:yellow        , ''              , '')
call s:HL("Comment",            s:inconspicuous , ''              , '')
call s:HL("Conditional",        s:violet        , ''              , '')
call s:HL("Constant",           s:yellow        , ''              , '')
call s:HL("Debug",              s:yellow        , s:background    , s:bold)
call s:HL("Define",             s:teal          , ''              , '')
call s:HL("Delimiter",          s:green         , ''              , '')
call s:HL("EndOfBuffer",        s:inconspicuous , ''              , '')
call s:HL("Error",              s:red           , s:background    , s:bold)
call s:HL("Exception",          s:violet        , ''              , '')
call s:HL("Float",              s:yellow        , ''              , '')
call s:HL("Function",           s:blue          , ''              , '')
call s:HL("Identifier",         s:foreground    , ''              , '')
call s:HL("Ignore",             s:inconspicuous , ''              , '')
call s:HL("Include",            s:purple        , ''              , '')
call s:HL("Keyword",            s:violet        , ''              , '')
call s:HL("Label",              s:violet        , ''              , '')
call s:HL("Macro",              s:violet        , ''              , '')
call s:HL("Number",             s:yellow        , ''              , '')
call s:HL("Operator",           s:green         , ''              , '')
call s:HL("PreCondit",          s:yellow        , ''              , '')
call s:HL("PreProc",            s:blue          , ''              , '')
call s:HL("Repeat",             s:violet        , ''              , '')
call s:HL("Special",            s:inconspicuous , ''              , '')
call s:HL("SpecialChar",        s:inconspicuous , ''              , '')
call s:HL("SpecialComment",     s:inconspicuous , ''              , '')
call s:HL("Statement",          s:violet        , ''              , '')
call s:HL("StorageClass",       s:violet        , ''              , s:none)
call s:HL("String",             s:green         , ''              , '')
call s:HL("Structure",          s:violet        , ''              , '')
call s:HL("Tag",                s:red           , s:background    , s:bold)
call s:HL("Todo",               s:red           , s:background    , s:bold)
call s:HL("Type",               s:red           , ''              , s:none)
call s:HL("Typedef",            s:red           , ''              , s:none)
call s:HL("Underlined",         s:blue          , ''              , s:underline)

" treesitter syntax highlight group
call s:HL("TSBoolean",          s:yellow        , ''              , '')
call s:HL("TSCharacter",        s:yellow        , ''              , '')
call s:HL("TSComment",          s:inconspicuous , ''              , '')
call s:HL("TSConditional",      s:violet        , ''              , '')
call s:HL("TSConstant",         s:yellow        , ''              , '')
call s:HL("TSConstBuiltin",     s:yellow        , ''              , '')
call s:HL("TSConstMacro",       s:yellow        , ''              , '')
call s:HL("TSError",            s:red           , ''              , s:bold)
call s:HL("TSException",        s:violet        , ''              , '')
call s:HL("TSField",            s:purple        , ''              , '')
call s:HL("TSFloat",            s:yellow        , ''              , '')
call s:HL("TSFunction",         s:blue          , ''              , '')
call s:HL("TSFuncBuiltin",      s:blue          , ''              , '')
call s:HL("TSFuncMacro",        s:blue          , ''              , '')
call s:HL("TSInclude",          s:purple        , ''              , '')
call s:HL("TSKeyword",          s:violet        , ''              , '')
call s:HL("TSKeywordFunction",  s:violet        , ''              , '')
call s:HL("TSLabel",            s:violet        , ''              , '')
call s:HL("TSMethod",           s:purple        , ''              , '')
call s:HL("TSNamespace",        s:violet        , ''              , '')
call s:HL("TSNumber",           s:yellow        , ''              , '')
call s:HL("TSOperator",         s:teal          , ''              , '')
call s:HL("TSParameter",        s:yellow        , ''              , '')
call s:HL("TSParameterReference",s:teal         , ''              , '')
call s:HL("TSProperty",         s:purple        , ''              , '')
call s:HL("TSPunctDelimiter",   s:teal          , ''              , '')
call s:HL("TSPunctBracket",     s:teal          , ''              , '')
call s:HL("TSPunctSpecial",     s:teal          , ''              , '')
call s:HL("TSRepeat",           s:violet        , ''              , '')
call s:HL("TSString",           s:green         , ''              , '')
call s:HL("TSStringRegex",      s:green         , ''              , '')
call s:HL("TSStringEscape",     s:green         , ''              , '')
call s:HL("TSTag",              s:red           , ''              , '')
call s:HL("TSTagDelimiter",     s:teal          , ''              , '')
call s:HL("TSText",             s:foreground    , s:background    , '')
call s:HL("TSEmphasis",         s:foreground    , s:background    , s:bold)
call s:HL("TSUnderline",        s:foreground    , s:background    , s:underline)
call s:HL("TSStrike",           s:foreground    , s:background    , s:strikethrough)
call s:HL("TSTitle",            s:blue          , ''              , '')
call s:HL("TSLiteral",          s:blue          , ''              , '')
call s:HL("TSURI",              s:red           , ''              , s:underline)
call s:HL("TSType",             s:red           , ''              , '')
call s:HL("TSTypeBuiltin",      s:red           , ''              , '')
call s:HL("TSVariable",         s:foreground    , ''              , '')
call s:HL("TSVariableBuiltin",  s:foreground    , ''              , '')

call s:HL("fzf1",               s:blue          , ''              , '')
call s:HL("fzf2",               s:blue          , ''              , '')
call s:HL("fzf3",               s:blue          , ''              , '')
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Function'],
            \ 'fg+':     ['fg', 'CursorLine',   'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine',   'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let g:rainbow_conf = { 'guifgs' : [ s:red, s:teal, s:violet, s:yellow, s:blue, s:green, s:purple ] }
let g:indentLine_color_gui          = s:selection
if has('nvim')
    let g:terminal_color_0          = s:inconspicuous
    let g:terminal_color_1          = s:red
    let g:terminal_color_2          = s:green
    let g:terminal_color_3          = s:yellow
    let g:terminal_color_4          = s:blue
    let g:terminal_color_5          = s:purple
    let g:terminal_color_6          = s:violet
    let g:terminal_color_7          = s:teal
    let g:terminal_color_8          = s:inconspicuous
    let g:terminal_color_9          = s:red
    let g:terminal_color_10         = s:green
    let g:terminal_color_11         = s:yellow
    let g:terminal_color_12         = s:blue
    let g:terminal_color_13         = s:purple
    let g:terminal_color_14         = s:violet
    let g:terminal_color_15         = s:teal
    let g:terminal_color_background = s:background
    let g:terminal_color_foreground = s:foreground
endif
