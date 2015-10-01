call pathogen#infect()

" Disable compatibility with vi
set nocompatible

" Turn on syntax highlighting
syntax on

" Indent Rules
filetype plugin indent on

set smartindent

" These are needed on mac with iterm and the solarized colors
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

set background=light
colorscheme solarized

" Automatically reload file when changed outside of buffer
set autoread

" Turn on modelines
set modeline
set modelines=3

" Change buffers without saving them
set hidden

" Use the already open buffer if it exists
set switchbuf=useopen,usetab 

" Filetype detection
autocmd BufRead,BufNewFile *.as set filetype=actionscript
autocmd BufRead,BufNewFile *.hx set filetype=haxe
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.ino set filetype=arduino
autocmd BufRead,BufNewFile *.ncx set filetype=xml
autocmd BufRead,BufNewFile *.opf set filetype=xml
autocmd BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar,*.epub set filetype=zip
autocmd BufWritePost * Neomake

" Visual bell and no beep
set vb
set noerrorbells

" Allow backspacing over everything in insert mode
set bs=indent,eol,start

" Change backup directory
"set backupdir=/tmp
" Change swp directory
"set directory=/tmp
" Turning these off as vim is messing up watching files
" Fuck a swp file
set nobackup
set nowritebackup
set noswapfile

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

" Allow L and H to go to beginning and end of line respectively
nnoremap H 0
nnoremap L $

" I have yet to find a use for Ex mode
nnoremap Q <Nop>

" Scroll 3 lines at a time with C-y and C-x
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Make Y and D yank til the end of the line like other capital letters
map Y y$
map D d$

" Hide the toolbar
set go-=T

" Enable the status bar
set laststatus=2

" Keep some space between the current line and the window frame
set scrolloff=4

" 4 spaces, expand tab by default
set sw=4 sts=4 ts=4 expandtab

" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf

" Search for the visually selected text
vnoremap // y/<C-R>"<CR>

" See lines numbers, ruler, and current line
set number
set ruler
set cursorline

" set bash style word completion
set wildmode=longest:full
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class

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

" Map shortcut leader to ',' instead of '/'
let mapleader = ","

" Clear the search highlight with <leader>n
nmap <silent> <leader>n :noh<CR>

" Paste mode toggle
nmap <silent> <leader>p :set paste!<CR>
" Softwarp text
nmap <silent> <leader>w :set wrap! linebreak! textwidth=0<CR>
" Toggle NERDTree
map <leader>t :NERDTreeToggle<CR>

" Toggle NERDTree
vmap <leader>s :sort<CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a split command with the path of the currently edited file filled in
" Normal mode: <Leader>s
map <Leader>se :split <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>v
map <Leader>ve :vsplit <C-R>=expand("%:p:h") . "/" <CR>

let NERDTreeIgnore=['\.pyc']

set listchars=tab:>.,trail:.,extends:#,nbsp:.

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

" Split to the file under the cursor and line number
map gs <C-W>F

" Turn on 256 colors if this is xterm or xterm compatible
set t_Co=256

" Remove some of the more annoying 'Press ENTER to continue' messages
set shortmess=atI

" Automatically reload vimrc when save
autocmd! BufWritePost .vimrc source %
autocmd! BufWritePost .gvimrc source %

" Remember cursor position on files
autocmd BufReadPost * normal `"

" I don't need help dammit
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" In vim, C-c closes insert mode but doesnt trigger the events that ESC does
" but ESC is so farrrrrrrrrrrrrrrrrrrr away. So important
inoremap <C-c> <ESC>

" I'm not quick enough when releasing shift
command! W w

" autocomplete on dashed-words, very useful for css
set iskeyword+=-

" Don't flicker when executing macros/functions
set lazyredraw

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Compile coffeescript files on write
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw

" I can't let go of the shift key fast enough :(
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Qal qa
cnoreabbrev Qall qa
cnoreabbrev W w
cnoreabbrev Wa wa
cnoreabbrev Wal wa
cnoreabbrev Wall wa
cnoreabbrev Set set

" json-vim
let g:vim_json_syntax_conceal = 0

" Syntastic
" Check syntax on open
let g:syntastic_check_on_open=1
" Populate the error window
let g:syntastic_always_populate_loc_list = 1
