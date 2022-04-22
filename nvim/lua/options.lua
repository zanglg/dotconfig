-- short command and function
local g         = vim.g
local o         = vim.opt

-- file editing
o.backup        = false                                -- no backup file
o.swapfile      = false                                -- no swap file
o.shadafile     = 'NONE'                               -- shadont
o.undofile      = false                                -- no undo file
o.encoding      = 'utf-8'                              -- default utf-8
o.fileformats   = 'unix,mac,dos'                       -- file format
o.fileencoding  = 'utf-8'                              -- default file encoding
o.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,latin1' -- file encoding fallback sequence
o.autoread      = true                                 -- detect when a file is changed
o.clipboard     = 'unnamed'                            -- yank to system clipboard
o.backspace     = 'eol,start,indent'                   -- endofline, old char, cross indent
o.whichwrap     = '<,>,h,l,[,]'                        -- keys can move across line
o.hidden        = true                                 -- buffer switch without saving
o.formatoptions = 'tcqmMj'                             -- wrap for multiple byte characters

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

-- appearance
o.cursorcolumn  = false                                -- highlight current column
o.cursorline    = false                                -- highligh current line
o.laststatus    = 3                                    -- always and ONLY the last window
o.number        = true                                 -- show line numbers
o.showcmd       = true                                 -- display command writing
o.showmode      = true                                 -- display vim mode
o.showtabline   = 0                                    -- always show tabline
o.title         = true                                 -- set terminal title
o.wrap          = true                                 -- turn on line wrapping
o.signcolumn    = 'yes'                                -- sign column always on
o.foldenable    = false                                -- disable session fold
o.foldmethod    = 'marker'                             -- use markers as to specify folds.
o.termguicolors = true                                 -- enable 24 bit color support if supported
o.guifont       = 'CaskaydiaCove NF:h16'               -- font for gui
o.guicursor     = ''

-- tab Control
o.shiftround    = true                                 -- round indent to a multiple of 'shiftwidth'
o.shiftwidth    = 4                                    -- number of spaces to use for indent and unindent
o.smarttab      = true                                 -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
o.softtabstop   = 4                                    -- edit as if the tabs are 4 characters wide
o.tabstop       = 4                                    -- the visible width of tabs
o.expandtab     = true                                 -- expand tab to space

-- disable_distribution_plugins
g.loaded_gzip              = 1
g.loaded_tar               = 1
g.loaded_tarPlugin         = 1
g.loaded_zip               = 1
g.loaded_zipPlugin         = 1
g.loaded_getscript         = 1
g.loaded_getscriptPlugin   = 1
g.loaded_vimball           = 1
g.loaded_vimballPlugin     = 1
g.loaded_matchit           = 1
g.loaded_matchparen        = 1
g.loaded_2html_plugin      = 1
g.loaded_logiPat           = 1
g.loaded_rrhelper          = 1
g.loaded_netrw             = 1
g.loaded_netrwPlugin       = 1
g.loaded_netrwSettings     = 1
g.loaded_netrwFileHandlers = 1
