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

" Exchange pieces of text
Plug 'tommcdo/vim-exchange'

" Repeat actions by some other plugins.
Plug 'tpope/vim-repeat'

" Easily abbreviate, substitute variants of a words and switch among different cases.
Plug 'tpope/vim-abolish'

" Pairs of shortcuts.
Plug 'tpope/vim-unimpaired'

" * or # search from a visual block
Plug 'nelstrom/vim-visual-star-search'

"}}}

"******************************** Text Objects **********************************{{{
" Some user-defined text objects

" Easily define new text objects. Dependency for the many of the following plugins.
Plug 'kana/vim-textobj-user'

" General
Plug 'kana/vim-textobj-entire' " ie and ae
Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC

" For coding
Plug 'glts/vim-textobj-comment', { 'on': ['<Plug>(textobj-comment-a)', '<Plug>(textobj-comment-i)', '<Plug>(textobj-comment-big-a)'] } " comment: ix, ax, aX
Plug 'adriaanzon/vim-textobj-matchit' " matchit pairs: im and am
Plug 'Julian/vim-textobj-variable-segment' " segments of variable names: iv and av
Plug 'whatyouhide/vim-textobj-erb', { 'for': 'eruby' } " erb: iE and aE
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } " ruby: ir and ar
Plug 'bkad/CamelCaseMotion'

"}}}

"******************************** Programming **********************************{{{
" Plugins that are helpful for programming.

" The git wrapper.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " Github
Plug 'shumphrey/fugitive-gitlab.vim' " GitLab
" TODO: compare with jreybert/vimagit

" Git commit browser
Plug 'junegunn/gv.vim', { 'on': 'GV' }

" Comment source code.
Plug 'tpope/vim-commentary'

" Consolidated ftplugins
Plug 'sheerun/vim-polyglot'

" Lint while typing
Plug 'w0rp/ale'

" IntelliSense and LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Grep/Ack
let b:Ack_commands = [
      \ 'Ack', 'Ack!', 'AckAdd',
      \ 'LAck', 'LAckAdd',
      \ 'AckFromSearch', 'AckFile',
      \ 'AckHelp', 'LAckHelp',
      \ 'AckWindow', 'LAckWindow'
      \ ]
Plug 'mileszs/ack.vim', { 'on': b:Ack_commands }

" Granular project configuration
Plug 'tpope/vim-projectionist'

" Outline viewer using ctags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" Automatically manage ctags
Plug 'ludovicchabant/vim-gutentags'

" Toggle between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" Shift argument and list items
Plug 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight', 'SidewaysJumpLeft', 'SidewaysJumpRight', '<Plug>SidewaysArgumentTextobjA', '<Plug>SidewaysArgumentTextobjI'] }

" Delete block structure and decrease indent level
Plug 'AndrewRadev/deleft.vim', { 'on': 'Deleft' }

" Toggle between pre-defined patterns
Plug 'AndrewRadev/switch.vim',  { 'on': 'Switch' }

" Standardize source code formatting.
Plug 'editorconfig/editorconfig-vim'

" Provide indentation guides.
Plug 'nathanaelkane/vim-indent-guides'

" Display git status in sign column.
Plug 'airblade/vim-gitgutter'

" For Rails development
Plug 'tpope/vim-rails'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Automatically complete block structures
Plug 'tpope/vim-endwise'

" Testing
Plug 'janko/vim-test', { 'for': 'ruby' }

let b:filetypes_with_tags = ['html', 'xhtml', 'phtml', 'xml', 'jinja', 'eruby', 'htmldjango', 'django', 'javascript.jsx', 'typescript.tsx', 'javascript', 'typescript']

" Highlight matching HTML and XML tags
Plug 'valloric/matchtagalways', { 'for': b:filetypes_with_tags }

" Auto close HTML and XML tags
Plug 'alvan/vim-closetag', { 'for': b:filetypes_with_tags }

"}}}

"******************************** Enhancements **********************************{{{
" Plugins that improves vim experience in general.

" Heuristically adjust indentation
Plug 'tpope/vim-sleuth'

" Readline-like keybindings in insert and command mode
Plug 'tpope/vim-rsi'

" A pretty and configurable status bar.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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

" Emacs-like yank ring
Plug 'maxbrunsfeld/vim-yankstack'

" Highlight yanked region
Plug 'machakann/vim-highlightedyank'

" Close all buffers but this one
Plug 'schickling/vim-bufonly'

" Unix helpers within Vim
let b:eunuch_commands = ['Delete', 'Unlink', 'Remove', 'Move', 'Rename', 'Chmod', 'Mkdir', 'Cfind', 'Clocate', 'Lfind', 'Llocate', 'Wall', 'SudoWrite', 'SudoEdit']
Plug 'tpope/vim-eunuch', { 'on': b:eunuch_commands }

" Easy alignment
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }

" Visual marks
Plug 'kshenoy/vim-signature'

" Peek registers
Plug 'junegunn/vim-peekaboo'

" Extend f, F, t, and T key mappings
Plug 'rhysd/clever-f.vim'

" Increment/decrement date and time
Plug 'tpope/vim-speeddating', { 'on': ['<Plug>SpeedDatingUp', '<Plug>SpeedDatingDown', '<Plug>SpeedDatingNowUTC', '<Plug>SpeedDatingNowLocal', 'SpeedDatingFormat'] }

" (Fake) Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" File browser
let b:NERDTree_commands = ['NERDTreeToggle', 'NERDTreeFind']
Plug 'scrooloose/nerdtree', { 'on': b:NERDTree_commands }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': b:NERDTree_commands }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': b:NERDTree_commands }

" Undo tree GUI
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

" Colorschemes
Plug 'flazz/vim-colorschemes'

" Vimwiki
Plug 'vimwiki/vimwiki', { 'for': 'markdown', 'on': ['VimwikiIndex', '<Plug>VimwikiIndex'] }

" Synchronised markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'pandoc.markdown', 'rmd', 'vimwiki'], 'on': 'MarkdownPreview' }

" Navigation between vim splits and tmux panes
Plug 'christoomey/vim-tmux-navigator'

" Auto-completion source for words in tmux panes
Plug 'wellle/tmux-complete.vim'
"
"}}}

"******************************** For the Sake of It **********************************{{{
" A fancy startup screen.
Plug 'mhinz/vim-startify'

" Smooth scrolling.
Plug 'yuttie/comfortable-motion.vim'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Calendar
Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }

" Distraction-free writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

"}}}

call plug#end()
