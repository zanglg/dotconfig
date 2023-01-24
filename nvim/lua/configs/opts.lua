-- file editing
vim.opt.backup = false -- no backup file
vim.opt.swapfile = false -- no swap file
vim.opt.shadafile = "NONE" -- shadont
vim.opt.undofile = false -- no undo file
vim.opt.encoding = "utf-8" -- default utf-8
vim.opt.fileformats = "unix,mac,dos" -- file format
vim.opt.fileencoding = "utf-8" -- default file encoding
vim.opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,latin1" -- file encoding fallback sequence
vim.opt.autoread = true -- detect when a file is changed
vim.opt.clipboard = "unnamed" -- yank to system clipboard
vim.opt.backspace = "eol,start,indent" -- endofline, old char, cross indent
vim.opt.whichwrap = "<,>,h,l,[,]" -- keys can move across line
vim.opt.hidden = true -- buffer switch without saving
vim.opt.formatoptions = "tcqmMj" -- wrap for multiple byte characters
vim.opt.mouse = "" -- disable mouse

-- search related
vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.incsearch = true -- set incremental search, like modern browsers
vim.opt.smartcase = true -- case-sensitive if expresson contains a capital letter
vim.opt.lazyredraw = false -- don't redraw while executing macros
vim.opt.magic = true -- Set magic on, comfortable for regex

-- bells
vim.opt.visualbell = false -- disable flash screen
vim.opt.errorbells = false -- disable errors bells

-- appearance
vim.opt.cursorcolumn = true -- highlight current column
vim.opt.cursorline = true -- highligh current line
vim.opt.laststatus = 3 -- always and ONLY the last window
vim.opt.number = true -- show line numbers
vim.opt.showcmd = true -- display command writing
vim.opt.showmode = true -- display vim mode
vim.opt.showtabline = 0 -- always show tabline
vim.opt.title = true -- set terminal title
vim.opt.wrap = true -- turn on line wrapping
vim.opt.signcolumn = "yes" -- sign column always on
vim.opt.foldenable = false -- disable session fold
vim.opt.foldmethod = "manual" -- folds are created manually
vim.opt.termguicolors = true -- enable 24 bit color support if supported
vim.opt.guicursor = "" -- never override terminal's cursor shape
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep

-- tab Control
vim.opt.shiftround = true -- round indent to a multiple of 'shiftwidth'
vim.opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
vim.opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
vim.opt.tabstop = 4 -- the visible width of tabs
vim.opt.expandtab = true -- expand tab to space

vim.g.mapleader = ","
vim.g.maplocalleader = ","
