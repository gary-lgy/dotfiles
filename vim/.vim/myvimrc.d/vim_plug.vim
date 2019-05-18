"*************************** VIM PLUG ******************************{{{
" Check if vim-plug is installed in the autoload directory.
" If not, install it.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif" Arguments to plug#begin specifies the directory to install the plugins
"}}}

"******************************** Plugins **********************************

call plug#begin('~/.vim/plugged')

"******************************** Pure Vim **********************************{{{
" Plugins that adhere closely to the vim philosophy (text objects and composability)

" vim-surround.
Plug 'tpope/vim-surround'

" Additional text objects(pair, quote, separator, argument, and tag). Supports seeking.
Plug 'wellle/targets.vim'

" Repeat actions by some other plugins.
Plug 'tpope/vim-repeat'

" Easily abbreviate, substitute variants of a words and switch among different cases.
Plug 'tpope/vim-abolish'

" Easily define new text objects. Dependency for the following plugins.
Plug 'kana/vim-textobj-user'

" Collection of new text objects.
Plug 'kana/vim-textobj-entire' " ie and ae
Plug 'kana/vim-textobj-fold' " iz and az
Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
Plug 'whatyouhide/vim-textobj-erb', { 'for': 'eruby' } " iE and aE
Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' } " ro, rl, rc, rd, rr
Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC

"}}}
"******************************** Programming **********************************{{{
" Plugins that are helpful for programming.

" Comment source code.
Plug 'tpope/vim-commentary'

" Toggle between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" Standardize source code formatting.
Plug 'editorconfig/editorconfig-vim'

" Provide indentation guides.
Plug 'nathanaelkane/vim-indent-guides'

" Display git status in sign column.
Plug 'airblade/vim-gitgutter'

" Extra filetypes
Plug 'sheerun/vim-polyglot'

" Lint while typing
Plug 'w0rp/ale'

" IntelliSense and LSP
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" A git wrapper. (Not sure if it is actually required)
Plug 'tpope/vim-fugitive'

" Preview CSS colors
Plug 'gko/vim-coloresque'

" Org-mode in vim
Plug 'jceb/vim-orgmode'

" For Rails development
Plug 'tpope/vim-rails'
"}}}
"******************************** Enhancements **********************************{{{
" Plugins that improves vim experience in general.

" FZF. The best shit ever.
" Basic vim plugin that came with fzf
if !empty(glob('/usr/share/vim/vimfiles'))
  " if installed system-wide
  Plug '/usr/share/vim/vimfiles'
elseif !empty(glob('~/.fzf'))
  " if installed for user
  Plug '~/.fzf'
endif

" Actual fzf.vim plugin with more powerful features
Plug 'junegunn/fzf.vim'

" Easy alignment
Plug 'junegunn/vim-easy-align'

" (Fake) Multiple cursors.
Plug 'terryma/vim-multiple-cursors'

" Maintains a yank stack similar to Emacs' killring.
Plug 'bfredl/nvim-miniyank'

" Smooth scrolling.
Plug 'yuttie/comfortable-motion.vim'

" File browser and syntax highlight for it.
Plug 'scrooloose/nerdtree' | Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

" Colorschemes
Plug 'flazz/vim-colorschemes'

" Org-mode in vim
Plug 'jceb/vim-orgmode'
"}}}
"******************************* Not Actually Useful but wth ********************************{{{

" A pretty and configurable status bar.
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" A fancy startup screen.
Plug 'mhinz/vim-startify'

"}}}

call plug#end()
