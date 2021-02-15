" Check if vim-plug is installed
" If not, install it.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('win64') || has('win32') || has('win16')
  let g:os = 'Windows'
else
  let g:os = substitute(system('uname'), '\n', '', '')
endif

" Arguments to plug#begin specifies the directory to install the plugins
call plug#begin('~/.vim/plugged')

" vim-surround
Plug 'tpope/vim-surround'

" Additional text objects(pair, quote, separator, argument, and tag) with support for seeking
Plug 'wellle/targets.vim'

" Repeat actions by plugins
Plug 'tpope/vim-repeat'

" Heuristically adjust indentation
Plug 'tpope/vim-sleuth'

" Pairs of shortcuts.
Plug 'tpope/vim-unimpaired'

" * or # search from a visual block
Plug 'nelstrom/vim-visual-star-search'

" Add/remove comments
Plug 'tpope/vim-commentary'

" All-in-one filetype plugins
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex']

" Auto pairs
Plug 'jiangmiao/auto-pairs'
source ~/.vim/plugin_config/auto_pairs.vim

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire' " ie and ae
Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC

" Camel case
Plug 'bkad/CamelCaseMotion'
source ~/.vim/plugin_config/camelcasemotion.vim

" Colorscheme collection
Plug 'flazz/vim-colorschemes'

" FZF
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

Plug 'junegunn/fzf.vim'
source ~/.vim/plugin_config/fzf.vim

" Easy alignment
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Undo tree GUI
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
nnoremap <F5> :MundoToggle<CR>

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
source ~/.vim/plugin_config/airline.vim

" Highlight yanked region
Plug 'machakann/vim-highlightedyank'

" Fancy startup screen
Plug 'mhinz/vim-startify'
" Do not cd into the file's directory when opening a file
let g:startify_change_to_dir = 0
" Use Unicode character for fortune header
let g:startify_fortune_use_unicode = 1

" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'
source ~/.vim/plugin_config/comfortable_motion.vim

" Git
Plug 'tpope/vim-fugitive' " TODO: compare with jreybert/vimagit
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'airblade/vim-gitgutter'
source ~/.vim/plugin_config/gitgutter.vim

" Editor Config
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

call plug#end()
" All the plugins have been loaded
