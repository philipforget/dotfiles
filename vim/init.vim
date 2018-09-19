" Not necessary for nvim but wont bother anything if it's present
set nocompatible

if has("nvim")
    " Fix issue in terminfo + neovim where C-h actually sends the ascii
    " backspace character.
    nmap <BS> <C-W>h
    " Enable python plugin support
    runtime! plugin/python_setup.vim
endif

call plug#begin()

" Plugins
Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'benekastah/neomake'
Plug 'benmills/vimux'
Plug 'honza/vim-snippets'
Plug 'kien/rainbow_parentheses.vim'
Plug 'rking/ag.vim'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'zanglg/nova.vim'
Plug 'chrisbra/csv.vim'
Plug 'jgdavey/tslime.vim'

" Syntax highlighters
Plug 'chase/vim-ansible-yaml'
Plug 'ekalinin/Dockerfile.vim'     
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'saltstack/salt-vim'
Plug 'smerrill/vcl-vim-plugin'
Plug 'robbles/logstash'
Plug 'lepture/vim-jinja'

call plug#end()

" Indent Rules
filetype plugin indent on
set smartindent

" Set colorscheme
syntax on
set background=dark
colorscheme solarized

" Turn on 3 modelines, these allow us to set filetype etc using the first 3
" commented lines of a given file.
set modeline
set modelines=3

" Change buffers without saving them
set hidden

" Use the already open buffer if it exists
set switchbuf=useopen,usetab 

" Filetype detection based on extension for lesser known filetypes
autocmd BufRead,BufNewFile *.as set filetype=actionscript
autocmd BufRead,BufNewFile *.hx set filetype=haxe
autocmd BufRead,BufNewFile *.ino set filetype=arduino
autocmd BufRead,BufNewFile *.ncx set filetype=xml
autocmd BufRead,BufNewFile *.opf set filetype=xml
autocmd BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar,*.epub set filetype=zip

" babel and eslint config files ar ejson but dont end in .json
autocmd BufRead,BufNewFile .babelrc,.eslintrc set filetype=json

" Run neomake after writing any buffer
autocmd BufWritePost * Neomake

" Visual bell and no beep
set vb
set noerrorbells

" Allow backspacing over everything in insert mode
set bs=indent,eol,start

" Change backup directory
set backupdir=/tmp
" I have more than 8k of memory, dont need swapfile thanks
set noswapfile

" Turn on mouse
set mouse=a

" Start without wrapping
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

" 4 spaces, expand tab by default, like a sane person
set sw=4 sts=4 ts=4 expandtab

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

" Leader stuff
" Map shortcut leader to space
let mapleader = "\<space>"

" Clear the search highlight with <leader>n
nmap <silent> <leader>n :noh<CR>

" Paste mode toggle
nmap <silent> <leader>p :set paste!<CR>

" Paste mode toggle
nmap <silent> <leader>d :r!date<CR>

" Softwarp text
nmap <silent> <leader>w :set wrap! linebreak! textwidth=0<CR>
" Toggle NERDTree
map <leader>t :NERDTreeToggle<CR>

" Start Ag command
map <leader>a :AgFromSearch<CR>

vnoremap <leader>so :sort<CR>

" NERDTree
let NERDTreeIgnore=['\.pyc']
let NERDTreeShowHidden=1

" Vimux leader shortcuts
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
 " Zoom the tmux runner page
map <Leader>vz :VimuxZoomRunner<CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a split command with the path of the currently edited file filled in
" Normal mode: <Leader>s
map <Leader>se :split <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>v
map <Leader>ve :vsplit <C-R>=expand("%:p:h") . "/" <CR>

set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list

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

" Remap C-c to escape
inoremap <C-c> <ESC>

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

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

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

" Add blank lines below cursor with Shift-Enter
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

" json-vim
let g:vim_json_syntax_conceal = 0

" vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript']

" Tslime plugin
vmap <C-b><C-b> <Plug>SendSelectionToTmux
nmap <C-b><C-b> <Plug>NormalModeSendToTmux
nmap <C-b>r <Plug>SetTmuxVars
