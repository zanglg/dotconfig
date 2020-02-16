" author: Zang Leigang

" ensure vim-plug is installed and then load it
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    !curl --insecure -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    source ~/.config/nvim/autoload/plug.vim
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
    set showtabline=2 "always show tabline
    set title " set terminal title
    set wrap " turn on line wrapping
    set signcolumn=yes

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
        Plug 'zanglg/neocc.vim'
        Plug 'zanglg/nova.vim'

        Plug 'chriskempson/base16-vim'
        Plug 'joshdick/onedark.vim'
        Plug 'lifepillar/vim-solarized8'
        Plug 'rafi/awesome-vim-colorschemes'

        set termguicolors " enable 24 bit color support if supported
        set background=dark
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
        Plug 'Yggdroot/indentLine' " indentation level
        let g:indentLine_fileTypeExclude = ['tex', 'markdown', 'rst']
    " }}}
" }}}

" Enhanced {{{
    " Git {{{
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'
    " }}}

    " vim-multiple-cursors {{{
        Plug 'terryma/vim-multiple-cursors'
    " }}}

    " floating terminal {{{
        Plug 'voldikss/vim-floaterm'
        let g:floaterm_position = 'center'
        nnoremap <silent> t :FloatermToggle<CR>
    " }}}

    " async run {{{
        Plug 'skywind3000/asyncrun.vim'

        " open quickfix windows with 12 lines height when AsynRun is executed
        let g:asyncrun_open = 12
        nnoremap <leader>z :AsyncRun
        " quickfix window toggle
        nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(12)<cr>
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

    " completion control {{{
        set wildmenu " show list instead of just completing
        set completeopt=longest,menu,preview
        autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif " auto close preview window
        " tab->next, shift-tab->prev, cr->select
        inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
    " }}}

    " LSP {{{
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        let g:lsp_highlights_enabled = 0 " disable highligh the concrete error text
        let g:lsp_virtual_text_enabled = 0 " disable inline text error info
        let g:lsp_signs_enabled = 1 " enable sign column
        let g:lsp_diagnostics_echo_cursor = 1 " Enables echo of diagnostic error for the current line to status
        let g:lsp_semantic_enabled = 1 " semantic highlight enabled
        let g:lsp_highlight_references_enabled = 1 " highlight references to the symbol under the cursor
        " lsp register {{{
            if executable('rls')
                " register to vim-lsp
                au User lsp_setup call lsp#register_server({
                    \ 'name': 'rls',
                    \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
                    \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
                    \ 'whitelist': ['rust'],
                    \ })
            endif
            if executable('clangd')
                au User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd', '-background-index']},
                    \ 'whitelist': ['c', 'cpp'],
                    \ 'semantic_highlight': {
                        \ 'entity.name.function.cpp': 'Function',
                        \ 'entity.name.function.preprocessor.cpp': 'Macro',
                        \ 'entity.name.type.class.cpp': 'Type',
                        \ 'entity.name.type.enum.cpp': 'Type',
                        \ 'entity.name.type.typedef.cpp': 'Type',
                        \ 'storage.type.primitive.cpp': 'Type',
                        \ 'variable.other.enummember.cpp': 'Include',
                        \ 'variable.other.field.cpp': 'Define',
                        \ 'variable.other.local.cpp': 'Include',
                        \ 'variable.parameter.cpp': 'PreCondit',
                        \ }
                    \ })
            endif
        " }}}
        " lsp keymaping {{{
            nnoremap <silent> <leader>d :LspDefinition<CR>
            nnoremap <silent> <leader>r :LspReferences<CR>
        " }}}
    " }}}
" }}}

" Navigation {{{
    " vista {{{
        Plug 'liuchengxu/vista.vim'
        let g:vista_default_executive = 'vim_lsp'
    " }}}

    " ctrlsf {{{
        Plug 'dyng/ctrlsf.vim'
        let g:ctrlsf_ackprg = 'rg'
        let g:ctrlsf_auto_preview = 1
        let g:ctrlsf_case_sensitive = 'no'
        let g:ctrlsf_search_mode = 'async'
        nnoremap <leader>s :CtrlSF
    " }}}

    " fzf {{{
        Plug 'junegunn/fzf', { 'do': './install --bin' }
        Plug 'junegunn/fzf.vim'

        " [[B]Commits] Customize the options used by 'git log':
        let g:fzf_commits_log_options =
                    \ '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cd by %cn"'

        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>b :Buffers<CR>
        nnoremap <silent> <leader>t :Tags<CR>

        let g:fzf_layout =
                    \ { 'window': { 'width': 0.6, 'height': 0.6, 'highlight': 'Keyword', 'border': 'sharp' } }
    " }}}

    " NERDTree {{{
        Plug 'scrooloose/nerdtree'
        nnoremap <silent> <leader>N :NERDTreeToggle<CR>
    " }}}

    " vim-clap {{{
        Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
        let g:clap_theme = 'material_design_dark'
    " }}}
" }}}

" Language Specific {{{
    " language packs {{{
        Plug 'sheerun/vim-polyglot'
    " }}}

    " rust.vim {{{
        Plug 'rust-lang/rust.vim'
        let g:rustfmt_autosave = 1
    " }}}
" }}}

" Formater {{{
    Plug 'sbdchd/neoformat'
    let g:neoformat_enabled_python = ['yapf', 'autopep8']
" }}}

" AutoGroups {{{
    " file formater
    augroup formater
        autocmd!
        autocmd FileType c,cpp  nnoremap <silent> <leader>c :LspDocumentFormat<CR>
        autocmd FileType c,cpp  vnoremap <silent> <leader>c :LspDocumentRangeFormat<CR>
        autocmd FileTYpe rust   nnoremap <silent> <leader>c :RustFmt<CR>
        autocmd FileTYpe rust   vnoremap <silent> <leader>c :RustFmtRange<CR>
        autocmd FileTYpe python noremap  <silent> <leader>c :Neoformat<CR>
    augroup END

    " write on save
    augroup wos
        autocmd!
        autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    augroup END
" }}}

" General Keymaping {{{
    " quicker window switching
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " clear highlighted search
    nnoremap <silent> <leader>n :noh<CR>

    " quick quit
    nnoremap qq :qa!<cr>

    " quick open MYVIMRC
    nnoremap <silent> <leader>v :e $MYVIMRC<CR>
" }}}
call plug#end()

" Colorscheme and final setup {{{
    " this call must happen after the plug#end()
    colorscheme neocc
    filetype plugin indent on
    syntax on
" }}}
