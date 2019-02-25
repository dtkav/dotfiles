" enable xterm colors
set term=xterm-256color
highlight PmenuSel ctermfg=black ctermbg=cyan
highlight Pmenu ctermfg=green ctermbg=black

" enable modelines
set modeline

" Swap colon and semicolon
nore ; :
nore , ;

"Makefiles with tabs not spaces
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Syntax-highlighting
" set background=dark
" syntax on

" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

set tags=./tags;/
set rtp+=~/.fzf

" Map leader key
let mapleader = ","

" Tab key configuration (use 4 spaces)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab       " Use spaces instead of tabs
set incsearch
set smartcase  " ignore case, unless I dont want to
execute pathogen#infect()
syntax on
filetype on
filetype plugin indent on

" Setup vim temp and swap directory to a common location to keep swaps from
" littering the source tree.
set directory=~/.vim/tmp

" 80 column 
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.\+/

" Tab shortcuts
map <C-n> :tabn<Enter>
map <C-p> :tabp<Enter>
map <C-l> :NERDTreeToggle<CR>

" Toggle whitespace with ,s
set listchars=tab:>-,trail:?,eol:$
nmap <silent> <leader>w :set nolist!<CR>

" Enable relative line numbers
set rnu
set nu

" Toggle line numbers with ,n
nmap <silent> <leader>n :set nonu!<CR> :set nornu!<CR>

" Toggle paste mode with F3
set pastetoggle=<F3>
nmap <F6> :exec '!'.getline('.')

" Useful aliases
command! Q  q
command! W  w
command! Wq  wq
command! WQ  wq

" hide file types when navigating filesystem (called netrw)
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'

" Starting with Vim 7, the filetype of empty .tex files defaults to 'plaintex'
" instead of 'tex'. The following changes the default filetype back to 'tex'
let g:tex_flavor = 'latex'

" Enable vundle to load plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

set encoding=utf-8
set laststatus=2

" Let vundle manage vundle
Bundle 'gmarik/vundle'

" Enhanced status line
Bundle 'Lokaltog/powerline'

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Python indentation
let g:pyindent_nested_paren="&sw*2"
let g:pyindent_open_paren="&sw*2"
let g:pyindent_continue = ''
