local M = {}

M.setup = function()
    local options = {
        -- file editing
        backup = false, -- no backup file
        swapfile = false, -- no swap file
        shadafile = "NONE", -- shadont
        undofile = false, -- no undo file
        encoding = "utf-8", -- default utf-8
        fileformats = "unix,mac,dos", -- file format
        fileencoding = "utf-8", -- default file encoding
        fileencodings = "ucs-bom,utf-8,cp936,gb18030,latin1", -- file encoding fallback sequence
        autoread = true, -- detect when a file is changed
        clipboard = "unnamed", -- yank to system clipboard
        backspace = "eol,start,indent", -- endofline, old char, cross indent
        whichwrap = "<,>,h,l,[,]", -- keys can move across line
        hidden = true, -- buffer switch without saving
        formatoptions = "tcqmMj", -- wrap for multiple byte characters
        mouse = "", -- disable mouse

        -- search related
        hlsearch = true, -- highlight search results
        ignorecase = true, -- case insensitive searching
        incsearch = true, -- set incremental search, like modern browsers
        smartcase = true, -- case-sensitive if expresson contains a capital letter
        lazyredraw = false, -- don't redraw while executing macros
        magic = true, -- Set magic on, comfortable for regex

        -- bells
        visualbell = false, -- disable flash screen
        errorbells = false, -- disable errors bells

        -- appearance
        cursorcolumn = false, -- highlight current column
        cursorline = false, -- highligh current line
        laststatus = 3, -- always and ONLY the last window
        number = true, -- show line numbers
        showcmd = true, -- display command writing
        showmode = true, -- display vim mode
        showtabline = 0, -- always show tabline
        title = true, -- set terminal title
        wrap = true, -- turn on line wrapping
        signcolumn = "yes", -- sign column always on
        foldenable = false, -- disable session fold
        foldmethod = "marker", -- use markers as to specify folds.
        termguicolors = true, -- enable 24 bit color support if supported
        guicursor = "", -- never override terminal's cursor shape

        -- tab Control
        shiftround = true, -- round indent to a multiple of 'shiftwidth'
        shiftwidth = 4, -- number of spaces to use for indent and unindent
        smarttab = true, -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
        softtabstop = 4, -- edit as if the tabs are 4 characters wide
        tabstop = 4, -- the visible width of tabs
        expandtab = true, -- expand tab to space
    }
    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    -- disable_distribution_plugins
    local builtins = {
        "loaded_gzip",
        "loaded_tar",
        "loaded_tarPlugin",
        "loaded_zip",
        "loaded_zipPlugin",
        "loaded_getscript",
        "loaded_getscriptPlugin",
        "loaded_vimball",
        "loaded_vimballPlugin",
        "loaded_matchit",
        "loaded_matchparen",
        "loaded_2html_plugin",
        "loaded_logiPat",
        "loaded_rrhelper",
        "loaded_netrw",
        "loaded_netrwPlugin",
        "loaded_netrwSettings",
        "loaded_netrwFileHandlers",
    }
    for _, plugin in ipairs(builtins) do
        vim.g[plugin] = 1
    end
end

return M
