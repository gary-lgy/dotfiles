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

"******************************** Fundamentals **********************************{{{
" Plugins that I think might as well be included in vanilla vim

" vim-surround.
Plug 'tpope/vim-surround'

" Additional text objects(pair, quote, separator, argument, and tag). Supports seeking.
Plug 'wellle/targets.vim'

" Repeat actions by some other plugins.
Plug 'tpope/vim-repeat'

" Easily abbreviate, substitute variants of a words and switch among different cases.
Plug 'tpope/vim-abolish'

" Pairs of shortcuts.
Plug 'tpope/vim-unimpaired'

" Easily define new text objects. Dependency for the following plugins.
Plug 'kana/vim-textobj-user'

" Collection of new text objects.
Plug 'kana/vim-textobj-entire' " ie and ae
Plug 'kana/vim-textobj-fold' " iz and az
Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC

"}}}

"******************************** Programming **********************************{{{
" Plugins that are helpful for programming.

" A git wrapper.
Plug 'tpope/vim-fugitive'
" TODO: compare with jreybert/vimagit

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
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" For Rails development
Plug 'tpope/vim-rails'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Automatically complete block structures
Plug 'tpope/vim-endwise'

" Highlight matching HTML and XML tags
Plug 'valloric/matchtagalways'

" Auto close HTML and XML tags
Plug 'alvan/vim-closetag'

" New text objects for Ruby
Plug 'whatyouhide/vim-textobj-erb', { 'for': 'eruby' } " iE and aE
Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' } " ro, rl, rc, rd, rr

" Testing
Plug 'janko/vim-test'

"}}}

"******************************** Enhancements **********************************{{{
" Plugins that improves vim experience in general.

" Heuristically adjust indentation
Plug 'tpope/vim-sleuth'

" Readline-like keybindings in insert and command mode
Plug 'tpope/vim-rsi'

" A pretty and configurable status bar.
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

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

" Unix helpers within Vim
Plug 'tpope/vim-eunuch'

" Easy alignment
Plug 'junegunn/vim-easy-align'

" Visual marks
Plug 'kshenoy/vim-signature'

" Increment/decrement date and time
Plug 'tpope/vim-speeddating'

" (Fake) Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

" Colorschemes
Plug 'flazz/vim-colorschemes'

" Org-mode in vim
Plug 'jceb/vim-orgmode'

" Synchronised markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'pandoc.markdown', 'rmd'] }

"}}}

"******************************** For the Sake of It **********************************{{{
" A fancy startup screen.
Plug 'mhinz/vim-startify'

" Smooth scrolling.
Plug 'yuttie/comfortable-motion.vim'

" Devicons
Plug 'ryanoasis/vim-devicons'

"}}}

call plug#end()
