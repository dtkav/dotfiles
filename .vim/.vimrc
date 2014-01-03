" Use Vim defaults instead of 100% vi compatibility 
set nocompatible

" Swap colon and semicolon
nore ; :
nore , ;

"Makefiles with tabs not spaces
autocmd FileType make setlocal noexpandtab

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Syntax-highlighting
" set background=dark
" syntax on

" Map leader key
let mapleader = ","

" Tab key configuration (use 4 spaces)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab       " Use spaces instead of tabs

" Tab shortcuts
map <C-n> :tabn<Enter>
map <C-p> :tabp<Enter>

" Toggle whitespace with ,s
set listchars=tab:>-,trail:?,eol:$
nmap <silent> <leader>w :set nolist!<CR>

" Toggle line numbers with ,n
nmap <silent> <leader>n :set nonu!<CR>

" Toggle paste mode with F3
set pastetoggle=<F3>

" Useful aliases
command! Q  q
command! W  w
command! Wq  wq
command! WQ  wq

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
