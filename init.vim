" author: Zang Leigang

let g:nvim_config_root = stdpath('config')

if empty(glob(g:nvim_config_root . '/autoload/plug.vim'))
    execute '!curl -fLo ' . g:nvim_config_root . '/autoload/plug.vim --create-dirs '
        \ . '"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:nvim_config_root . '/plugged')

" File editing {{{
    set nobackup                                            " no backup file 
    set noswapfile                                          " no swap file 
    set noundofile                                          " no undo file
    set encoding=utf-8                                      " default utf-8
    set ffs=unix,mac,dos                                    " file format
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,latin1    " file encoding fallback sequence
    set termencoding=utf-8                                  " encoding output to terminal
    set autoread                                            " detect when a file is changed
    set clipboard=unnamed                                   " yank to system clipboard
    set backspace=eol,start,indent                          " endofline, old char, cross indent
    set whichwrap+=<,>,h,l                                  " keys can move across line
" }}}

" Search {{{
    set hlsearch                                            " highlight search results
    set ignorecase                                          " case insensitive searching
    set incsearch                                           " set incremental search, like modern browsers
    set smartcase                                           " case-sensitive if expresson contains a capital letter
    set nolazyredraw                                        " don't redraw while executing macros
    set magic                                               " Set magic on, comfortable for regex
" }}}

" Bells {{{
    set novisualbell                                        " disable flash screen
    set noerrorbells                                        " disable error bells
    set t_vb=                                               " clear code to flash screen
" }}}

" Appearance {{{
    set cursorcolumn                                        " highlight current column
    set cursorline                                          " highligh current line
    set laststatus=2                                        " always show the status line - use 2 lines for the status bar
    set number                                              " show line numbers
    set showcmd                                             " display command writing
    set showmode                                            " display vim mode
    set showtabline=2                                       " always show tabline
    set title                                               " set terminal title
    set wrap                                                " turn on line wrapping
    set signcolumn=yes                                      " sign column always on
    set nofoldenable                                        " disable session fold
    set foldmethod=marker                                   " use markers as to specify folds.
" }}}

" Tab Control {{{
    set shiftround                                          " round indent to a multiple of 'shiftwidth'
    set shiftwidth=4                                        " number of spaces to use for indent and unindent
    set smarttab                                            " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set softtabstop=4                                       " edit as if the tabs are 4 characters wide
    set tabstop=4                                           " the visible width of tabs
    set expandtab                                           " expand tab to space
" }}}

" Mapleader {{{
    set tm=1000                                             " map sequence complete timeout
    let mapleader = ','                                     " mapleader, must put before remapping
" }}}

" colorschemes {{{
    Plug 'zanglg/neocc.vim'
    Plug 'zanglg/nova.vim'

    Plug 'chriskempson/base16-vim'
    Plug 'joshdick/onedark.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'rafi/awesome-vim-colorschemes'

    set termguicolors                                       " enable 24 bit color support if supported
    set background=light
" }}}

" rainbow parentheses {{{
    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1
" }}}

" LightLine {{{
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    let g:lightline = {
    \   'colorscheme': 'PaperColor_light',
    \   'tabline': {'left': [['buffers']], 'right': [['close']]},
    \   'component_expand': {'buffers': 'lightline#bufferline#buffers'},
    \   'component_type': {'buffers': 'tabsel'},
    \   'separator': {'left': '', 'right': ''},
    \   'subseparator': {'left': '', 'right': ''}
    \ }
    let g:lightline#bufferline#filename_modifier = ':t'
" }}}}

" indentLine {{{
    Plug 'Yggdroot/indentLine'
    let g:indentLine_fileTypeExclude = ['tex', 'markdown', 'rst']
" }}}

" Git {{{
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
" }}}

" hexmode {{{
    Plug 'fidian/hexmode'
    let g:hexmode_patterns = '*.bin,*.img'
" }}}

" vim-multiple-cursors {{{
    Plug 'terryma/vim-multiple-cursors'
" }}}

" floating terminal {{{
    Plug 'voldikss/vim-floaterm'
    let g:floaterm_position = 'center'
    nnoremap <silent> t :FloatermToggle<CR>
" }}}

" auto pairs {{{
    Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsWildClosedPair = ''
" }}}

" vim-easy-align {{{
    Plug 'junegunn/vim-easy-align'

    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
" }}}

" editorconfig {{{
    Plug 'editorconfig/editorconfig-vim'
" }}}

" language packs {{{
    Plug 'sheerun/vim-polyglot'
" }}}

" vista {{{
    Plug 'liuchengxu/vista.vim'
" }}}

" NERDTree {{{
    Plug 'scrooloose/nerdtree'
    nnoremap <silent> <leader>N :NERDTreeToggle<CR>
" }}}

" vim-clap {{{
    Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
" }}}

" completion control {{{
    set wildmenu                                                                " show list instead of just completing
    set completeopt=menuone,noinsert,noselect                                   " popup even have only one candidate
    set completeopt+=noinsert,noselect                                          " disable auto selection

    " Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" NeovimLSP {{{
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
" }}}

" rust.vim {{{
    Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
" }}}

" Formater {{{
    Plug 'sbdchd/neoformat'
    let g:neoformat_enabled_python = ['yapf', 'autopep8']

    autocmd FileType c,cpp  nnoremap <silent> <leader>c :LspDocumentFormat<CR>
    autocmd FileType c,cpp  vnoremap <silent> <leader>c :LspDocumentRangeFormat<CR>
    autocmd FileType rust   nnoremap <silent> <leader>c :RustFmt<CR>
    autocmd FileType rust   vnoremap <silent> <leader>c :RustFmtRange<CR>
    autocmd FileType python noremap  <silent> <leader>c :Neoformat<CR>
" }}}

" AutoGroups {{{
    autocmd! bufwritepost $MYVIMRC source $MYVIMRC          " Auto-source vimrc when saved
" }}}

" General Keymaping {{{
    " quicker tab switching
    nnoremap <silent> <C-h> :bp<CR>
    nnoremap <silent> <C-j> :bn<CR>

    " clear highlighted search
    nnoremap <silent> <leader>n :noh<CR>

    " quick quit
    nnoremap qq :qa!<cr>

    " quick open MYVIMRC
    nnoremap <silent> <leader>v :e $MYVIMRC<CR>
" }}}  

call plug#end()

" Colorscheme and final setup {{{
    colorscheme neocc                                       " my precious color scheme
    filetype plugin indent on                               " not used now
    syntax on                                               " syntax highligh

    lua require'nvim_lsp'.rust_analyzer.setup   { on_attach=require'completion'.on_attach }
    lua require'nvim_lsp'.clangd.setup          { on_attach=require'completion'.on_attach }
    lua require'nvim_lsp'.pyls.setup            { on_attach=require'completion'.on_attach }
" }}}
