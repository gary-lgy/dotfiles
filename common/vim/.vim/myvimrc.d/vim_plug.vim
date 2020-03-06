"************************* Bootstrapping ****************************{{{
let g:plugins_path = '~/.vim/plugged'
" Checks if a plugin is installed
function! HasPlugin(plugin) abort
  return !empty(glob(g:plugins_path . '/' . a:plugin))
endfunction

" Check if vim-plug is installed in the autoload directory.
" If not, install it.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

if has("win64") || has("win32") || has("win16")
  let g:os = "Windows"
else
  let g:os = substitute(system('uname'), '\n', '', '')
endif

" Arguments to plug#begin specifies the directory to install the plugins
call plug#begin(g:plugins_path)

"******************************** Editing **********************************{{{
" Generic text editing extensions

" vim-surround
Plug 'tpope/vim-surround'

" Additional text objects(pair, quote, separator, argument, and tag) with support for seeking
Plug 'wellle/targets.vim'

" Exchange pieces of text
Plug 'tommcdo/vim-exchange'

" Repeat actions by plugins
Plug 'tpope/vim-repeat'

" Easily abbreviate, substitute variants of a words and switch among different cases
Plug 'tpope/vim-abolish'

" Easy alignment
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire' " ie and ae
Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC
Plug 'glts/vim-textobj-comment' " comment: ix, ax, ax
Plug 'Julian/vim-textobj-variable-segment' " segments of variable names: iv and av
Plug 'whatyouhide/vim-textobj-erb', { 'for': 'eruby' } " erb: iE and aE
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } " ruby: ir and ar
Plug 'bkad/CamelCaseMotion'

" Heuristically adjust indentation
Plug 'tpope/vim-sleuth'

" Increment/decrement date and time
Plug 'tpope/vim-speeddating', { 'on': ['<Plug>SpeedDatingUp', '<Plug>SpeedDatingDown', '<Plug>SpeedDatingNowUTC', '<Plug>SpeedDatingNowLocal', 'SpeedDatingFormat'] }

"}}}

"******************************** Enhancements **********************************{{{
" Plugins that improves vim experience in general

" FZF. The best shit ever.
" Basic vim support
if g:os == 'Darwin'
  Plug '/usr/local/opt/fzf'
elseif g:os == 'Linux'
  if !empty(glob('/usr/share/vim/vimfiles'))
    " if installed system-wide
    Plug '/usr/share/vim/vimfiles'
  elseif !empty(glob('~/.fzf'))
    " if installed for user
    Plug '~/.fzf'
  endif
endif

" Collection of fzf commands
Plug 'junegunn/fzf.vim'

" Pairs of shortcuts.
Plug 'tpope/vim-unimpaired'

" Emacs-like yank ring
Plug 'maxbrunsfeld/vim-yankstack'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" * or # search from a visual block
Plug 'nelstrom/vim-visual-star-search'

" Readline-like keybindings in insert and command mode
Plug 'tpope/vim-rsi'

" Dispatch
Plug 'tpope/vim-dispatch'

" Automatically toggle between relative and absolute line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Close all buffers but this one
Plug 'schickling/vim-bufonly'

" Unix helpers within Vim
let b:eunuch_commands = ['Delete', 'Unlink', 'Remove', 'Move', 'Rename', 'Chmod', 'Mkdir', 'Cfind', 'Clocate', 'Lfind', 'Llocate', 'Wall', 'SudoWrite', 'SudoEdit']
Plug 'tpope/vim-eunuch', { 'on': b:eunuch_commands }

" sudo for Neovim
Plug 'lambdalisue/suda.vim'

" Diff lines
Plug 'AndrewRadev/linediff.vim', { 'on': ['Linediff', 'LinediffReset'] }

"}}}

"******************************** UI **********************************{{{
" Better UI

" Grep/Ack
Plug 'mileszs/ack.vim'

" Display indentation levels
Plug 'nathanaelkane/vim-indent-guides'

" Undo tree GUI
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

" Colorscheme collection
Plug 'flazz/vim-colorschemes'

" Rainbox parentheses
Plug 'junegunn/rainbow_parentheses.vim', { 'on': ['RainbowParentheses', 'RainbowParenthesesColors'] }

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Highlight yanked region
Plug 'machakann/vim-highlightedyank'

" File browser
let b:NERDTree_commands = ['NERDTreeToggle', 'NERDTreeFind']
Plug 'scrooloose/nerdtree', { 'on': b:NERDTree_commands }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': b:NERDTree_commands }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': b:NERDTree_commands }

" Fancy startup screen
Plug 'mhinz/vim-startify'

" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'

" Devicons
Plug 'ryanoasis/vim-devicons'

"}}}

"******************************** Tmux **********************************{{{

" Navigation between vim splits and tmux panes
Plug 'christoomey/vim-tmux-navigator'

" Auto-completion source for words in tmux panes
Plug 'wellle/tmux-complete.vim'

" Interact with tmux within vim
Plug 'benmills/vimux'

"}}}

"******************************** Programming **********************************{{{
" Plugins for programming

" Add/remove comments
Plug 'tpope/vim-commentary'

" All-in-one filetype plugins
Plug 'sheerun/vim-polyglot'

" Lint while you type
Plug 'w0rp/ale'

" Autocompletion and LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Git
Plug 'tpope/vim-fugitive' " TODO: compare with jreybert/vimagit
Plug 'tpope/vim-rhubarb' " Github
Plug 'shumphrey/fugitive-gitlab.vim' " GitLab
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'airblade/vim-gitgutter'

" Granular project configuration
Plug 'tpope/vim-projectionist'

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

"******************************** Documents **********************************{{{
" Plugins for typing documents

" LaTex
Plug 'lervag/vimtex', { 'for': 'tex' }

" Synchronised markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'pandoc.markdown', 'rmd'], 'on': 'MarkdownPreview' }

" Distraction-free writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

"}}}

call plug#end()
