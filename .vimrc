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

"Filetype detection for json
autocmd BufNewFile, BufRead *.json set filetype=javascript

" Visual bell and no beep
set vb
set noerrorbells

set title

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

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Hide the toolbar
set go-=T

" Enable the status bar
set laststatus=2

" Keep some space between the current line and the window frame
set scrolloff=4

" Indent Rules
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

" Insert Mode Map jj to esc
imap jj <ESC>

" set bash style word completion
set wildmode=longest:full
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class

set history=1000
set undolevels=1000

" Search Options
" enable search highlighting
set hlsearch
" enable incremental search
set incsearch
" case-insensitive search
set ignorecase
" unless there's uppercase letters on the pattern
set smartcase

" Leader Stuff "
" Map shortcut leader to ','
let mapleader = ","

" Clear the search highlight with <leader>n
nmap <silent> <leader>n :silent :nohlsearch<CR>

nmap <silent> <leader>l :set nolist!<CR>
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Paste mode toggle
nmap <silent> <leader>p :set paste!<CR>

" Softwarp text
nmap <silent> <leader>w :set wrap! linebreak! textwidth=0<CR>

" Toggle NERDTree
let NERDTreeIgnore=['\.pyc']
map <leader>t :NERDTreeToggle<CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a split command with the path of the currently edited file filled in
" Normal mode: <Leader>s
map <Leader>se :split <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>v
map <Leader>ve :vsplit <C-R>=expand("%:p:h") . "/" <CR>

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

" Turn on 256 colors if this is xterm or xterm compatible
if &term == 'xterm'
	set t_Co=256
endif

" Remove some of the more annoying 'Press ENTER to continue' messages
set shortmess=atI

" Automatically reload vimrc when save
autocmd! BufWritePost .vimrc source %

" Remember cursor position on files
autocmd BufReadPost * normal `"

" I don't need help dammit
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Show highlighting groups for current word, useful for developing themes
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
