" Disable compatibility with vi
set nocompatible

" Turn on syntax highlighting
syntax on

" Automatically reload file when changed outside of vim
set autoread

" Change buffers without saving them
set hidden

"Filetype detection for AS3
autocmd BufNewFile, BufRead *.as set filetype=actionscript

"Filetype detection for haxe
autocmd BufNewFile, BufRead *.hx set filetype=haxe

" Visual bell
set vb

" Allow backspacing over everything in insert mode
set bs=indent,eol,start

" Change backup directory
set backupdir=/tmp

" Turn on mouse
set mouse=a

" wrapping options
set nowrap

" Allow j and k keys to move down physical lines on screen
nnoremap j gj
nnoremap k gk
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" Hide the toolbar
set go-=T

" Enable the status bar
set laststatus=2

" Indent Rules
filetype on
filetype plugin indent on
" Default to tabs (for html, javascript etc.) and auto indent
set autoindent
set sw=4 sts=4 ts=4 noexpandtab

"Python specific tabbing
autocmd FileType python setlocal expandtab

"Enable folding with the spacebar
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

colorscheme kellys

" See lines numbers, ruler, and current line
set number
set ruler
setlocal cursorline

" Insert Mode Map hh to be esc
"imap jj <ESC>

" set bash style word completion
set wildmode=longest:full
set wildmenu

" Search Options
" enable search highlighting
set hlsearch
" enable incremental search
set incsearch
" case-insensitive search
set ignorecase
" unless there's uppercase letters on the pattern
set smartcase

" do not move the cursor when highlighting
noremap * *N
noremap # #N

" When splitting window, split to bottom and to right
set splitright
set splitbelow

" Resize windows when loading sessions
set sessionoptions+=resize

" After shifting a visual block, reselect it to be able to shift again
vnoremap > >gv
vnoremap < <gv

" Run current line/selection as Python code and replace with output
nmap gp :.!python<CR>
vmap gp :!python<CR>

" Move between windows with ctrl + movement keys
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Automatically reload vimrc when save
autocmd! BufWritePost .vimrc source %

" Turn on 256 colors if this is xterm or xterm compatible
if &term == 'xterm'
	set t_Co=256
endif
