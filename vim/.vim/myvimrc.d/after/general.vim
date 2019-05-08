" Basic
filetype plugin indent on
syntax on
if !has('nvim')
  set nocompatible
endif
set encoding=utf-8

" Use fish shell
set shell=fish
set termguicolors
if has('nvim')
  autocmd BufEnter term://* startinsert
endif

" Behavior
set hidden
set backspace=indent,eol,start " Backspace behavior
set clipboard=unnamedplus " Yank to system clipboard
set foldmethod=marker " Fold with markers
set timeoutlen=3000
set ttimeoutlen=100
set scrolloff=5
set wildmenu " Enable ommand completion menu
set wildmode=full " Cycle through completions
set visualbell " Show visual bell
set belloff=all " Turn off beep for all event
set wrap " Wrap long lines

" Appearance
set ruler
set showcmd
set number
set relativenumber
set mouse=a
set cursorline
colorscheme gruvbox

" Search
set hlsearch " Highlight search items
set incsearch " Incremental search
set ignorecase " Make search case-insensitive
set smartcase " Make search case-sensitive if at least one letter is uppercase

" Format settings
set autoindent
set smarttab
set tabstop=4 " Show tabs as 4-space wide.
set expandtab " On pressing tab, insert 4 spaces
set softtabstop=4 " BS removes 4 spaces
set shiftwidth=4 " Indent with 4 spaces equivalent

" Enable persistent undo
set undofile
set undodir=~/.cache/vim/undo

" Enable persistent views
set viewoptions-=options
set viewdir=~/.cache/vim/view
au BufWinLeave ?* silent! mkview
au BufWinEnter ?* silent! loadview
