" Based on http://dougblack.io/words/a-good-vimrc.html
" Colors
set background=dark
colorscheme wombat256
syntax enable

" Spaces & Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
filetype indent on
filetype plugin on
set autoindent

" UI Config
set backspace=indent,eol,start
set number
set showcmd
set cursorline
set wildmenu
set showmatch
set inccommand=nosplit
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 &&
  \ exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Leader Shortcuts
let mapleader=","
inoremap jk <esc>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ag
map <C-n> :NERDTreeToggle<CR>

" Searching
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase
"nnoremap / /\v
"vnoremap / /\v
"set gdefault
"nnoremap <tab> %
"vnoremap <tab> %

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

" Movement
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap gV `[v`]
set whichwrap=<,>,[,],h,l
com! -nargs=1 -complete=dir Ncd NERDTree | cd <args> |NERDTreeCWD
vnoremap < <gv
vnoremap > >gv

" tabs
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" nnoremap <C-t>     :tabnew<CR>
" nnoremap <C-w>     :tabclose<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i
" inoremap <C-t>     <Esc>:tabnew<CR>
" inoremap <C-w>     :tabclose<CR>

" Launch Config

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

set nocompatible
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', { 'on': [] }
Plug 'rust-lang/rust.vim'
Plug 'marijnh/tern_for_vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'kh3phr3n/python-syntax'
Plug 'heavenshell/vim-jsdoc'

call plug#end()

" Autogroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

autocmd BufNewFile,BufRead *.rs set filetype=rust ts=4 et sts=4 sw=4

" Backups
set backup
set backupdir=~/.local/bkp/vim
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.local/bkp/vim/swap
set writebackup

" Custom Functions

let python_self_cls_highlight = 1

" Ruler
set ruler
set colorcolumn=90
" Highlight text in 75th-79th columns and after 79th column in Python
au BufWinEnter *.* let w:m1=matchadd('Search', '\%<90v.\%>85v', -1)
au BufWinEnter *.* let w:m2=matchadd('ErrorMsg', '\%>89v.\+', -1)

" YouCompleteMe

augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| call youcompleteme#Enable() | autocmd! load_us_ycm
augroup END

let g:ycm_rust_src_path = '/home/zbraniecki/projects/rust/src'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1

" tern_for_vim

let g:tern_show_argument_hints='on_hold'

" Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

" JSDoc
let g:jsdoc_enable_es6 = 1
