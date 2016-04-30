" Based on http://dougblack.io/words/a-good-vimrc.html
" Colors
set background=dark
colorscheme wombat256
"set transparency=5
syntax enable

" Spaces & Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" UI Config
set number
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

" Ruler
set ruler
set textwidth=79
"set formatoptions=cqrnw1
set colorcolumn=80
" Highlight text in 75th-79th columns and after 79th column in Python
au BufWinEnter *.* let w:m1=matchadd('Search', '\%<80v.\%>75v', -1)
au BufWinEnter *.* let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

" Leader Shortcuts
let mapleader=","
inoremap jk <esc>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ag

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

" Searching
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Launch Config
call pathogen#infect()

" Tmux
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Autogroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
"    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
"                \:call <SID>StripTrailingWhitespaces()
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

autocmd BufNewFile,BufRead *.rs set filetype=rust ts=2 et sts=2 sw=2

" Backups
set backup
set backupdir=~/.local/bkp/vim
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.local/bkp/vim/swap
set writebackup

" Custom Functions
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" UI

"set splitbelow splitright

" Searching
"set ignorecase " Ignore case when searching
"set smartcase " Ignore case when searching lowercase
"nnoremap / /\v
"vnoremap / /\v
"set gdefault
"nnoremap <tab> %
"vnoremap <tab> %

" Coding style


