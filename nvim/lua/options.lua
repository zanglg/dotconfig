local options = {}

function options:init()
    -- short command and function
    local o         = vim.o
    local b         = vim.bo
    local w         = vim.wo

    -- file editing
    o.backup        = false                                -- no backup file
    b.swapfile      = false                                -- no swap file
    b.undofile      = false                                -- no undo file
    o.encoding      = 'utf-8'                              -- default utf-8
    o.fileformats   = 'unix,mac,dos'                       -- file format
    b.fileencoding  = 'utf-8'                              -- default file encoding
    o.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,latin1' -- file encoding fallback sequence
    o.autoread      = true                                 -- detect when a file is changed
    o.clipboard     = 'unnamed'                            -- yank to system clipboard
    o.backspace     = 'eol,start,indent'                   -- endofline, old char, cross indent
    o.whichwrap     = '<,>,h,l,[,]'                        -- keys can move across line
    o.hidden        = true                                 -- buffer switch without saving

    -- search related
    o.hlsearch      = true                                 -- highlight search results
    o.ignorecase    = true                                 -- case insensitive searching
    o.incsearch     = true                                 -- set incremental search, like modern browsers
    o.smartcase     = true                                 -- case-sensitive if expresson contains a capital letter
    o.lazyredraw    = false                                -- don't redraw while executing macros
    o.magic         = true                                 -- Set magic on, comfortable for regex

    -- bells
    o.visualbell    = false                                -- disable flash screen
    o.errorbells    = false                                -- disable errors bells
    o.t_vb          = ''                                   -- clear code to flash screen

    -- appearance
    w.cursorcolumn  = true                                 -- highlight current column
    w.cursorline    = true                                 -- highligh current line
    o.laststatus    = 2                                    -- always show the status line - use 2 lines for the status bar
    w.number        = true                                 -- show line numbers
    o.showcmd       = true                                 -- display command writing
    o.showmode      = true                                 -- display vim mode
    o.showtabline   = 0                                    -- always show tabline
    o.title         = true                                 -- set terminal title
    w.wrap          = true                                 -- turn on line wrapping
    w.signcolumn    = 'yes'                                -- sign column always on
    w.foldenable    = false                                -- disable session fold
    w.foldmethod    = 'marker'                             -- use markers as to specify folds.
    o.termguicolors = true                                 -- enable 24 bit color support if supported

    -- tab Control
    o.shiftround    = true                                 -- round indent to a multiple of 'shiftwidth'
    b.shiftwidth    = 4                                    -- number of spaces to use for indent and unindent
    o.smarttab      = true                                 -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    b.softtabstop   = 4                                    -- edit as if the tabs are 4 characters wide
    b.tabstop       = 4                                    -- the visible width of tabs
    b.expandtab     = true                                 -- expand tab to space
end

return options
