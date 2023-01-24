local M = {}

-- stylua: ignore
local colors = {
    foreground = "#c2cad6",
    comment    = "#737d8c",
    separator  = "#282f39",
    selection  = "#2c343f",
    stripline  = "#212830",
    background = "#1b2027",
    popupmenu  = "#15191e",

    red        = "#e06c75",
    brown      = "#93766c",
    yellow     = "#e5c07b",
    lime       = "#bac653",
    green      = "#98c379",
    teal       = "#1dc9ac",
    cyan       = "#5edced",
    blue       = "#61afef",
    violet     = "#8c8cd9",
    purple     = "#c678dd",
}
M.colors = colors

local default = {
    ColorColumn = { fg = colors.stripline },
    Conceal = { fg = colors.comment },
    CurSearch = { fg = colors.red, reverse = true },
    Cursor = { fg = colors.red },
    lCursor = { fg = colors.red },
    CursorIM = { fg = colors.red },
    CursorColumn = { bg = colors.stripline },
    CursorLine = { bg = colors.stripline },
    Directory = { fg = colors.red },
    DiffAdd = { fg = colors.green, reverse = true },
    DiffChange = { fg = colors.blue, reverse = true },
    DiffDelete = { fg = colors.red, reverse = true },
    DiffText = { fg = colors.red },
    EndOfBuffer = { fg = colors.comment },
    TermCursor = { fg = colors.red },
    TermCursorNC = { fg = colors.stripline },
    ErrorMsg = { fg = colors.red },
    WinSeparator = { fg = colors.separator },
    FloatBorder = { fg = colors.separator },
    Folded = { fg = colors.comment, bg = colors.stripline },
    FoldColumn = { bg = colors.stripline },
    SignColumn = { fg = colors.comment, bg = colors.background },
    IncSearch = { fg = colors.lime, reverse = true },
    Substitute = { fg = colors.lime, reverse = true },
    LineNr = { fg = colors.comment },
    LineNrAbove = { fg = colors.comment },
    LineNrBelow = { fg = colors.comment },
    CursorLineNr = { fg = colors.yellow },
    CursorLineSign = { fg = colors.comment },
    CursorLineFold = { fg = colors.comment },
    MatchParen = { fg = colors.lime, reverse = true },
    ModeMsg = { fg = colors.comment },
    MsgArea = { bg = colors.background },
    MsgSeparator = { fg = colors.separator },
    MoreMsg = { fg = colors.green },
    NonText = { fg = colors.comment },
    Normal = { fg = colors.foreground, bg = colors.background },
    NormalFloat = { fg = colors.foreground },
    NormalNC = { fg = colors.foreground },
    Pmenu = { bg = colors.popupmenu },
    PmenuSel = { bg = colors.selection },
    PmenuSbar = { bg = colors.popupmenu },
    PmenuThumb = { bg = colors.selection },
    Question = { fg = colors.red },
    QuickFixLine = { bg = colors.selection },
    Search = { fg = colors.lime, reverse = true },
    SpecialKey = { fg = colors.stripline },
    SpellBad = { fg = colors.red, underline = true },
    SpellCap = { fg = colors.red, underline = true },
    SpellLocal = { fg = colors.red, underline = true },
    SpellRare = { fg = colors.red, underline = true },
    StatusLine = { fg = colors.red, bg = colors.popupmenu },
    StatusLineNC = { bg = colors.popupmenu },
    TabLine = { bg = colors.popupmenu },
    TabLineFill = { bg = colors.popupmenu },
    TabLineSel = { fg = colors.red, bg = colors.background },
    Title = { bg = colors.background },
    Visual = { bg = colors.selection },
    VisualNOS = { bg = colors.selection },
    WarningMsg = { fg = colors.yellow },
    Whitespace = { fg = colors.comment },
    WildMenu = { bg = colors.selection },
    WinBar = { bg = colors.popupmenu },
    WinBarNC = { bg = colors.popupmenu },

    Comment = { fg = colors.comment },

    Constant = { fg = colors.yellow },
    String = { fg = colors.green },
    Character = { fg = colors.green },
    Number = { fg = colors.yellow },
    Boolean = { fg = colors.yellow },
    Float = { fg = colors.yellow },

    Identifier = { fg = colors.foreground },
    Function = { fg = colors.blue },

    Statement = { fg = colors.purple },
    Conditional = { fg = colors.purple },
    Repeat = { fg = colors.purple },
    Label = { fg = colors.purple },
    Operator = { fg = colors.cyan },
    Keyword = { fg = colors.purple },
    Exception = { fg = colors.purple },

    PreProc = { fg = colors.violet },
    Include = { fg = colors.violet },
    Define = { fg = colors.violet },
    Macro = { fg = colors.yellow },
    PreCondit = { fg = colors.violet },

    Type = { fg = colors.red },
    StorageClass = { fg = colors.purple },
    Structure = { fg = colors.purple },
    Typedef = { fg = colors.red },

    Special = { fg = colors.brown },
    SpecialChar = { fg = colors.brown },
    Tag = { fg = colors.red },
    Delimiter = { fg = colors.cyan },
    SpecialComment = { fg = colors.comment },
    Debug = { fg = colors.red },

    Underlined = { underline = true },
    Ignore = { fg = colors.comment },
    Error = { fg = colors.red },
    Todo = { fg = colors.red },
}

local plugins = {
    -- diagnostics
    DiagnosticError = { link = "ErrorMsg" },
    DiagnosticWarn  = { link = "WarningMsg" },
    DiagnosticInfo  = { link = "MoreMsg" },
    DiagnosticHint  = { link = "MoreMsg" },

    -- treesitter
    ["@parameter"] = { fg = colors.teal },
    ["@field"] = { fg = colors.violet },
    ["@property"] = { fg = colors.violet },
    ["@namespace"] = { fg = colors.violet },
    ["@text.title"] = { fg = colors.red },
    ["@text.literal"] = { fg = colors.violet },

    -- GitSigns
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.blue },
    GitSignsDelete = { fg = colors.red },

    -- Hop
    HopNextKey   = { fg = colors.red, bold = true },
    HopNextKey1  = { fg = colors.blue, bold = true },
    HopNextKey2  = { fg = colors.purple, bold = true },
    HopUnmatched = { fg = colors.comment },
    HopCursor    = { fg = colors.yellow },

    -- telescope
    TelescopeBorder = { link = "FloatBorder" },
}

for _, groups in ipairs({ default, plugins }) do
    for hl, col in pairs(groups) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

return M
