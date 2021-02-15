" Basic
filetype plugin indent on
syntax on
if !has('nvim')
  set nocompatible
endif

" Terminal color capabilities
if $TERM =~? '\(.*tmux.*\)\|\(.*xterm.*\)'
  set termguicolors
else
  set notermguicolors
endif

" Terminal settings
if has('nvim')
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nospell nonumber norelativenumber
endif

" Behavior
set hidden
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set foldmethod=manual
set timeoutlen=3000
set ttimeoutlen=100
set scrolloff=5
set sidescrolloff=5
set wildmenu
set wildmode=full
set visualbell
set belloff=all
set wrap
set splitbelow
set splitright
set lazyredraw
set linebreak
set title
set confirm

" Appearance
set ruler
set showcmd
set number
set relativenumber
set mouse=a
set cursorline
colorscheme gruvbox

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
if has('nvim')
  set inccommand=nosplit
endif

" Format settings
set tabstop=4 " Show tabs as 4-space wide.
set smarttab
set expandtab " On pressing tab, insert 4 spaces
set softtabstop=4 " BS removes 4 spaces
set shiftwidth=4 " Indent with 4 spaces equivalent

" Enable persistent undo
set undofile
set undodir=~/.cache/vim/undo

" Enable persistent views
set viewoptions-=options
set viewoptions-=curdir
set viewdir=~/.cache/vim/view
au BufWinLeave ?* silent! mkview
au BufWinEnter ?* silent! loadview
