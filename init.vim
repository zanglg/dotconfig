" author: Zang Leigang

" ensure vim-plug is installed and then load it
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" General {{{
    " no backup
    set nobackup
    set noswapfile
    set noundofile

    set autoread " detect when a file is changed
    set clipboard=unnamed " yank to system clipboard

    " search
    set hlsearch " highlight search results
    set ignorecase " case insensitive searching
    set incsearch " set incremental search, like modern browsers
    set smartcase " case-sensitive if expresson contains a capital letter
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

    " diable error bells
    set novisualbell
    set noerrorbells
    set t_vb=
    set tm=500

    " configure backspace so it acts as it should act
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l

    " file encoding
    set encoding=utf-8
    set ffs=unix,mac,dos
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    set termencoding=utf-8

    " mapleader, must put before remapping
    let mapleader = ','
" }}}

" Appearance {{{
    set cursorcolumn " highlight current column
    set cursorline " highligh current line
    set laststatus=2 " always show the status line - use 2 lines for the status bar
    set number " show line numbers
    set showcmd " display command writing
    set showmode "display vim mode
    set title " set terminal title
    set wrap " turn on line wrapping
    set signcolumn=yes

    " completion
    set wildmenu " show list instead of just completing
    set wildmode=list:longest,full " use powerful wildmenu
    set completeopt=longest,menu

    " tab control
    set shiftround " round indent to a multiple of 'shiftwidth'
    set shiftwidth=4 " number of spaces to use for indent and unindent
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set tabstop=4 " the visible width of tabs
    set expandtab " expand tab to space

    " code fold
    set nofoldenable
    set foldmethod=marker

    " colorschemes {{{
        set termguicolors " enable 24 bit color support if supported
        set background=dark
        Plug 'zanglg/nova.vim'
    " }}}

    " rainbow parentheses {{{
        Plug 'luochen1990/rainbow'
        let g:rainbow_active = 1
    " }}}

    " LightLine {{{
        Plug 'itchyny/lightline.vim'
        let g:lightline = {
        \   'separator': { 'left': '', 'right': '' },
        \   'subseparator': { 'left': '', 'right': '' }
        \ }
    " }}}}

    " indentLine {{{
        Plug 'Yggdroot/indentLine' " indentation level
    " }}}

    " vim-bufferline {{{
        Plug 'bling/vim-bufferline' " buffer line
    " }}}

" }}}

" Enhanced {{{
    " Git {{{
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'
    " }}}

    " auto pairs {{{
        Plug 'jiangmiao/auto-pairs'
        let g:AutoPairsWildClosedPair = ''
    " }}}

    " Completion {{{
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        let g:lsp_highlights_enabled = 0 " disable highligh the concrete error text
        let g:lsp_virtual_text_enabled = 0 " disable inline text error info
        let g:lsp_signs_enabled = 1 " enable sign column
        let g:lsp_diagnostics_echo_cursor = 1 " Enables echo of diagnostic error for the current line to status

        " completion control {{{
            set completeopt+=preview " enable preview window
            autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif " auto close preview window
            " tab->next, shift-tab->prev, cr->select
            inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
            inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
            inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
        " }}}
    " }}}

    " Linter {{{
    " }}}
" }}}

" Navigation {{{
    " vista {{{
        Plug 'liuchengxu/vista.vim'
    " }}}
" }}}

" Language Specific {{{
    " rust.vim {{{
        Plug 'rust-lang/rust.vim'
        let g:rustfmt_autosave = 1
        if executable('rls')
            " register to vim-lsp
            au User lsp_setup call lsp#register_server({
                \ 'name': 'rls',
                \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
                \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
                \ 'whitelist': ['rust'],
                \ })
        endif
    " }}}
    " c & cpp {{{
        if executable('clangd')
            au User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': {server_info->['clangd', '-background-index']},
                \ 'whitelist': ['c', 'cpp'],
                \ })
        endif
    " }}}
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        autocmd BufWritePost init.vim source %
    augroup END
" }}}

" General Keymaping {{{
    " quicker window switching
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " clear highlighted search
" }}}
call plug#end()

" Colorscheme and final setup {{{
    " this call must happen after the plug#end()
    colorscheme nova
    filetype plugin indent on
    syntax on
" }}}
