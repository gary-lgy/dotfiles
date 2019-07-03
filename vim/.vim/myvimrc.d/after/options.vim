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
  autocmd TermOpen * setlocal nospell
  autocmd TermOpen * setlocal nonumber norelativenumber
endif

" Behavior
set hidden
set autoindent
set backspace=indent,eol,start " Backspace behavior
set clipboard=unnamed " Yank to PRIMARY selection
set foldmethod=manual " Fold with markers
set timeoutlen=3000
set ttimeoutlen=100
set scrolloff=5
set sidescrolloff=5
set wildmenu " Enable command completion menu
set wildmode=full " Cycle through completions
set visualbell " Show visual bell
set belloff=all " Turn off beep for all event
set wrap " Wrap long lines
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
set hlsearch " Highlight search items
set incsearch " Incremental search
set ignorecase " Make search case-insensitive
set smartcase " Make search case-sensitive if at least one letter is uppercase

" " Format settings (taken care of by vim-sleuth)
set tabstop=4 " Show tabs as 4-space wide.
" set smarttab
" set expandtab " On pressing tab, insert 4 spaces
" set softtabstop=4 " BS removes 4 spaces
" set shiftwidth=4 " Indent with 4 spaces equivalent

" Enable persistent undo
set undofile
set undodir=~/.cache/vim/undo

" Enable persistent views
set viewoptions-=options
set viewoptions-=curdir
set viewdir=~/.cache/vim/view
au BufWinLeave ?* silent! mkview
au BufWinEnter ?* silent! loadview