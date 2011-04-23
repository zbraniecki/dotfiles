set nocompatible
let mapleader = ","

" UI
set t_Co=256 " 256 colors
set background=dark
colorscheme wombat256
let g:molokai_original = 0
if has("gui_running")
    set guifont=Menlo:h12
    set go-=T
    set go-=rlRL
    set fuoptions=background:Normal
    colorscheme wombat
endif

syntax on
set number
set relativenumber
set splitbelow splitright
set cursorline
set showcmd
set ruler
set textwidth=79
set formatoptions=cqrnw1
set colorcolumn=80
" Highlight text in 75th-79th columns and after 79th column in Python
au BufWinEnter *.py let w:m1=matchadd('Search', '\%<80v.\%>75v', -1)
au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

" Searching
set incsearch
set hlsearch
set showmatch
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase
nnoremap / /\v
vnoremap / /\v
set gdefault
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <tab> %
vnoremap <tab> %


" Invisible characters
if has("gui_running")
    set listchars=trail:⋅,tab:▸\ ,eol:¬
else
    set listchars=trail:.,tab:>-,eol:$
endif
set nolist
noremap <leader>i :set list!<CR>
" Toggle invisible chars

" Coding style
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nosmartindent

" Mappings ********************************************************************
 
" easier commands
nnoremap ; :

" home row
map <C-H> :tabprevious<CR>
map <C-L> :tabnext<CR>
map <C-J> <C-D>
map <C-K> <C-U>
nnoremap j gj
nnoremap k gk

" don't open help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" autocomplete
inoremap <C-L> <Tab>
imap <Tab> <C-P>

imap jj <Esc>
imap uu _
imap hh ->
imap aa @

" File explorer
nnoremap <F12> :Explore<CR>
nnoremap <C-T> :tabnew<CR>

" Insert New Line
nnoremap <S-Enter> O<ESC>
nnoremap <Enter> o<ESC>

" Highlight text after 79th column
nnoremap <F10> :match ErrorMsg '\%>79v.\+'<CR>

" Set a PuDB breakpoint
nnoremap <F11> ofrom pudb import set_trace; set_trace()<ESC>

" select lines that were just pasted
nnoremap <leader>v V`]


" Directories *****************************************************************
" Setup backup location and enable
set backupdir=~/.bkp/vim
set backup
set undofile

" Set Swap directory
set directory=~/.bkp/vim/swap

" Misc ************************************************************************
set backspace=indent,eol,start
set matchpairs+=<:>

" Functions *******************************************************************
"
let s:editing_text = 0
function! Toggle_text_editing()
    if s:editing_text
        " turn off text editing
        let s:editing_text = 0
        setlocal formatoptions-=ta
        setlocal relativenumber
        setlocal autoindent
        setlocal textwidth=79
        setlocal colorcolumn=80
        if has("gui_running")
            colorscheme wombat
        else
            colorscheme wombat256
        endif
    else
        " turn on text editing
        let s:editing_text = 1
        setlocal formatoptions+=ta
        setlocal norelativenumber
        setlocal textwidth=71
        setlocal colorcolumn=72
        if has("gui_running")
            colorscheme freya
        else
            colorscheme freya256
        endif
    endif
    return
endfunction
nnoremap <leader>t :call Toggle_text_editing()<CR>

let s:is_fullscreen = 0
function! Toggle_fullscreen()
    if s:is_fullscreen
        " turn fullscreen off
        let s:is_fullscreen = 0
        set nofullscreen
        redraw!
    else
        " turn fullscreen on
        let s:is_fullscreen = 1
        set fullscreen
        redraw!
    endif
endfunction
nnoremap <leader>fu :call Toggle_fullscreen()<CR>

" Crontab doesn't like the way Vim does backups *******************************
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" Filetype-specific ***********************************************************
au BufRead sup.* set ft=mail
au BufRead sup.* call Toggle_text_editing()
