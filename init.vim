" --------------------------------------------------------------------------------------------------
" author: Zang Leigang (zang.lg # outlook.com)
" --------------------------------------------------------------------------------------------------

let g:nvim_config_root = stdpath('config')

if empty(glob(g:nvim_config_root . '/autoload/plug.vim'))
    execute '!curl -fLo ' . g:nvim_config_root . '/autoload/plug.vim --create-dirs '
        \ . '"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --------------------------------------------------------------------------------------------------
" file editing
" --------------------------------------------------------------------------------------------------
    set nobackup                                                                " no backup file 
    set noswapfile                                                              " no swap file 
    set noundofile                                                              " no undo file
    set encoding=utf-8                                                          " default utf-8
    set ffs=unix,mac,dos                                                        " file format
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,latin1                        " file encoding fallback sequence
    set termencoding=utf-8                                                      " encoding output to terminal
    set autoread                                                                " detect when a file is changed
    set clipboard=unnamed                                                       " yank to system clipboard
    set backspace=eol,start,indent                                              " endofline, old char, cross indent
    set whichwrap+=<,>,h,l                                                      " keys can move across line

" --------------------------------------------------------------------------------------------------
" search related
" --------------------------------------------------------------------------------------------------
    set hlsearch                                                                " highlight search results
    set ignorecase                                                              " case insensitive searching
    set incsearch                                                               " set incremental search, like modern browsers
    set smartcase                                                               " case-sensitive if expresson contains a capital letter
    set nolazyredraw                                                            " don't redraw while executing macros
    set magic                                                                   " Set magic on, comfortable for regex

" --------------------------------------------------------------------------------------------------
" bells
" --------------------------------------------------------------------------------------------------
    set novisualbell                                                            " disable flash screen
    set noerrorbells                                                            " disable error bells
    set t_vb=                                                                   " clear code to flash screen

" --------------------------------------------------------------------------------------------------
" appearance
" --------------------------------------------------------------------------------------------------
    set cursorcolumn                                                            " highlight current column
    set cursorline                                                              " highligh current line
    set laststatus=2                                                            " always show the status line - use 2 lines for the status bar
    set number                                                                  " show line numbers
    set showcmd                                                                 " display command writing
    set showmode                                                                " display vim mode
    set showtabline=2                                                           " always show tabline
    set title                                                                   " set terminal title
    set wrap                                                                    " turn on line wrapping
    set signcolumn=yes                                                          " sign column always on
    set nofoldenable                                                            " disable session fold
    set foldmethod=marker                                                       " use markers as to specify folds.
    set termguicolors                                                           " enable 24 bit color support if supported
    set background=light

" --------------------------------------------------------------------------------------------------
" tab Control
" --------------------------------------------------------------------------------------------------
    set shiftround                                                              " round indent to a multiple of 'shiftwidth'
    set shiftwidth=4                                                            " number of spaces to use for indent and unindent
    set smarttab                                                                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set softtabstop=4                                                           " edit as if the tabs are 4 characters wide
    set tabstop=4                                                               " the visible width of tabs
    set expandtab                                                               " expand tab to space

" --------------------------------------------------------------------------------------------------
" completion control
" --------------------------------------------------------------------------------------------------
    set wildmenu                                                                " show list instead of just completing
    set completeopt=menuone                                                     " popup even have only one candidate
    set completeopt+=noinsert,noselect                                          " disable auto selection
    set shortmess+=c                                                            " Shut off completion messages"

" --------------------------------------------------------------------------------------------------
" mapleader
" --------------------------------------------------------------------------------------------------
    set tm=1000                                                                 " map sequence complete timeout
    let mapleader = ','                                                         " mapleader, must put before remapping

" --------------------------------------------------------------------------------------------------
" plugin Manager
" --------------------------------------------------------------------------------------------------
call plug#begin(g:nvim_config_root . '/plugged')

" --------------------------------------------------------------------------------------------------
" colorscheme
" --------------------------------------------------------------------------------------------------
    Plug 'zanglg/neocc.vim'
    Plug 'zanglg/nova.vim'
    Plug 'chriskempson/base16-vim'
    Plug 'joshdick/onedark.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'rafi/awesome-vim-colorschemes'

" --------------------------------------------------------------------------------------------------
" ui appearance
" --------------------------------------------------------------------------------------------------
    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    let g:lightline = { }
    let g:lightline.colorscheme = 'PaperColor_light'
    let g:lightline.separator = { 'left': "\uE0BC", 'right': "\uE0BE" }
    let g:lightline.subseparator = { 'left': "\uE0BD", 'right': "\uE0BF" }
    let g:lightline.active = { 'left': [['mode', 'paste'], ['readonly', 'absolutepath', 'modified']] }
    let g:lightline.tabline = { 'left': [ ['buffers']  ], 'right': [ ['close']  ] }
    let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
    let g:lightline.component_type = { 'buffers': 'tabsel' }
    let g:lightline#bufferline#show_number  = 1 

    Plug 'Yggdroot/indentLine'
    let g:indentLine_fileTypeExclude = ['tex', 'markdown', 'rst']

" --------------------------------------------------------------------------------------------------
" git related
" --------------------------------------------------------------------------------------------------
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

" --------------------------------------------------------------------------------------------------
" language packs
" --------------------------------------------------------------------------------------------------
    Plug 'editorconfig/editorconfig-vim'
    Plug 'sheerun/vim-polyglot'

    Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1

" --------------------------------------------------------------------------------------------------
" enhance file editing
" --------------------------------------------------------------------------------------------------
    Plug 'junegunn/vim-easy-align'
    Plug 'terryma/vim-multiple-cursors'

    Plug 'fidian/hexmode'
    let g:hexmode_patterns = '*.bin,*.img'

    Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsWildClosedPair = ''

    Plug 'sbdchd/neoformat'
    let g:neoformat_enabled_python = ['yapf', 'autopep8']

" --------------------------------------------------------------------------------------------------
" floating terminal
" --------------------------------------------------------------------------------------------------
    Plug 'voldikss/vim-floaterm'
    let g:floaterm_position = 'center'

" --------------------------------------------------------------------------------------------------
" navigation
" --------------------------------------------------------------------------------------------------
    Plug 'liuchengxu/vista.vim'
    Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

" --------------------------------------------------------------------------------------------------
" auto completion
" --------------------------------------------------------------------------------------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'nvim-lua/completion-nvim'
    let g:mucomplete#enable_auto_at_startup = 1

call plug#end()

" --------------------------------------------------------------------------------------------------
" custom function
" --------------------------------------------------------------------------------------------------
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" --------------------------------------------------------------------------------------------------
" general key binding
" --------------------------------------------------------------------------------------------------
    autocmd! bufwritepost $MYVIMRC source $MYVIMRC          " Auto-source vimrc when saved

    " nvim-lspconfig
    nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <leader>i <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <leader>s <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    " formater
    autocmd FileType rust   nnoremap <silent> <leader>c :RustFmt<CR>
    autocmd FileType rust   vnoremap <silent> <leader>c :RustFmtRange<CR>
    autocmd FileType python noremap  <silent> <leader>c :Neoformat<CR>

    " easy align
    map <silent> <leader>g <Plug>(EasyAlign)

    " plugin toggle
    nnoremap <silent> <leader>N :NERDTreeToggle<CR>
    nnoremap <silent> <leader>t :FloatermToggle<CR>

    " tab navigation
    nnoremap <silent> <leader>h :bp<CR>
    nnoremap <silent> <leader>l :bn<CR>
    nnoremap <silent> <leader>n :noh<CR>

    " quick open MYVIMRC
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>b :Buffers<CR>

    " quick file open
    nnoremap <silent> <leader>v :e $MYVIMRC<CR>
    nnoremap <silent> <leader>g :e $HOME/.gitconfig<CR>

    " quickfix toggle
    nnoremap <silent> <leader>q :call ToggleQuickFix()<CR>

    " quick exit without save
    nnoremap qq :qa!<cr>

" --------------------------------------------------------------------------------------------------
" Colorscheme and final setup
" --------------------------------------------------------------------------------------------------
    colorscheme neocc                                                           " my precious color scheme
    filetype plugin indent on                                                   " not used now
    syntax on                                                                   " syntax highligh

    lua require'lspconfig'.clangd.setup          { on_attach=require'completion'.on_attach }
    lua require'lspconfig'.rust_analyzer.setup   { on_attach=require'completion'.on_attach }
    lua require'lspconfig'.pyls.setup            { on_attach=require'completion'.on_attach }
