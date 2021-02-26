" Leader keys
" Run these before loading plugins so that any plugin that maps to <Leader> will use the updated leader key
" VimScript seems to have some weird scoping rules - defining these in a
" function (e.g., PluginsWillLoad) has no effect
let mapleader = ' '
let maplocalleader = '  '

function! s:VimRcMain()
    call s:InstallVimPlug()
    call s:PluginsWillLoad()
    call s:LoadPlugins()
    call s:PluginsDidLoad()
endfunction

" Check if vim-plug is installed
" If not, install it.
function! s:InstallVimPlug()
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endfunction

function! s:PluginsWillLoad()
    if has('win64') || has('win32') || has('win16')
        let g:os = 'Windows'
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif

    filetype plugin indent on
    syntax enable
    set nocompatible
endfunction

function! s:LoadPlugins()
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
    call s:AutoPairsConfigPreLoad()

    " Easy-motion
    Plug 'easymotion/vim-easymotion'
    call s:EasyMotionConfigPreLoad()

    " Text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire' " ie and ae
    Plug 'kana/vim-textobj-indent' " ii, ai, iI and aI
    Plug 'coderifous/textobj-word-column.vim' "ic, ac, iC, aC

    " Camel case
    Plug 'bkad/CamelCaseMotion'
    call s:CamelCaseMotionConfigPreLoad()

    " Colorscheme collection
    Plug 'morhetz/gruvbox'
    let g:gruvbox_invert_signs = 1
    let g:gruvbox_contrast_dark = 'hard'

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
    call s:FzfConfigPreLoad()

    " Easy alignment
    Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
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
    call s:AirlineConfigPreLoad()

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
    call s:ComfortableMotionConfigPreLoad()

    " Git
    Plug 'tpope/vim-fugitive' " TODO: compare with jreybert/vimagit
    Plug 'junegunn/gv.vim', { 'on': 'GV' }
    Plug 'airblade/vim-gitgutter'
    call s:GitGutterConfigPreLoad()

    " Editor Config
    Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

    call plug#end()
    " All the plugins have been loaded
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configs to be defined before loading any plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:AutoPairsConfigPreLoad()
    " Disable unused shortcuts
    let g:AutoPairsShortcutToggle     = ''
    let g:AutoPairsShortcutBackInsert = ''
    let g:AutoPairsShortcutJump       = ''
    let g:AutoPairsShortcutFastWrap   = ''

    " Disable multi-line auto-close
    let g:AutoPairsMultilineClose = 0

    autocmd Filetype tex let b:AutoPairs = AutoPairsDefine({
                \ "$$": "$$",
                \ "$": "$"
                \ })
    autocmd Filetype vim let b:AutoPairs = AutoPairsDefine({}, ["\""])
endfunction

function! s:EasyMotionConfigPreLoad()
    " Disable default mappings
    let g:EasyMotion_do_mapping = 0
    " Use uppercase target labels and type as a lower case
    let g:EasyMotion_use_upper = 1
    " type `l` and match `l`&`L`
    let g:EasyMotion_smartcase = 1
    " Smartsign (type `3` and match `3`&`#`)
    let g:EasyMotion_use_smartsign_us = 1
    " Custom keys
    let g:EasyMotion_keys = 'dtnfgcrlbmw,.pyjkxaoeishu'

    map s <Plug>(easymotion-s)
    map <Leader>j <Plug>(easymotion-bd-jk)
    map <Leader>b <Plug>(easymotion-bd-w)
endfunction

function! s:CamelCaseMotionConfigPreLoad()
    map <silent> w <Plug>CamelCaseMotion_w
    map <silent> b <Plug>CamelCaseMotion_b
    map <silent> e <Plug>CamelCaseMotion_e
    map <silent> ge <Plug>CamelCaseMotion_ge

    omap <silent> iw <Plug>CamelCaseMotion_iw
    xmap <silent> iw <Plug>CamelCaseMotion_iw
    omap <silent> ib <Plug>CamelCaseMotion_ib
    xmap <silent> ib <Plug>CamelCaseMotion_ib
    omap <silent> ie <Plug>CamelCaseMotion_ie
    xmap <silent> ie <Plug>CamelCaseMotion_ie
endfunction

function! s:FzfConfigPreLoad()
    " Do not show statusline for fzf pane
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    " Customize fzf colors to match color scheme
    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }

    " Shortcuts to invoke fzf
    nnoremap <Leader>.  <Cmd>Files ./<CR>
    nnoremap <Leader>`  <Cmd>Files ~<CR>
    nnoremap <Leader>fg <Cmd>GFiles?<CR>
    nnoremap <Leader>ft <Cmd>BTags<CR>
    nnoremap <Leader>fT <Cmd>Tags<CR>
    nnoremap <Leader>,  <Cmd>Buffers<CR>
    nnoremap <Leader>r  <Cmd>History<CR>
    nnoremap <Leader>;  <Cmd>History:<CR>
    nnoremap <Leader>?  <Cmd>History/<CR>
    nnoremap <Leader>fc <Cmd>Commits<CR>
    nnoremap <Leader>fb <Cmd>BCommits<CR>
    nnoremap <Leader>l  <Cmd>BLines<CR>
    nnoremap <Leader>L  <Cmd>Lines<CR>

    " Preview
    " :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
    " :Ag! - Start fzf in fullscreen and display the preview window above
    command! -bang -nargs=* Ag
                \ call fzf#vim#ag(<q-args>,
                \                 <bang>0 ? fzf#vim#with_preview('up:60%')
                \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
                \                 <bang>0)

    " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    " Commands to enquere mappings
    command! -nargs=0 IMaps call fzf#vim#maps('i', 0)
    cabbrev IMap IMaps
    cabbrev Imap IMaps
    command! -nargs=0 VMaps call fzf#vim#maps('v', 0)
    cabbrev VMap VMaps
    cabbrev Vmap VMaps
    command! -nargs=0 OMaps call fzf#vim#maps('o', 0)
    cabbrev OMap OMaps
    cabbrev Omap OMaps
endfunction

function! s:AirlineConfigPreLoad()
    " Use powerline font
    let g:airline_powerline_fonts = 1

    " Use powerline and unicode symbols
    let g:airline_left_sep                     = ''
    let g:airline_left_alt_sep                 = ''
    let g:airline_right_sep                    = ''
    let g:airline_right_alt_sep                = ''
    let g:airline#extensions#tabline#left_sep  = ''
    let g:airline#extensions#tabline#right_sep = ''
    if !exists("g:airline_symbols")
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.branch               = ''
    let g:airline_symbols.readonly             = ''
    let g:airline_symbols.linenr               = '' " '☰'
    let g:airline_symbols.maxlinenr            = '' " ''
    let g:airline_symbols.dirty                = '⚡'
    let g:airline_symbols.crypt                = '🔒'
    let g:airline_symbols.paste                = 'ρ'
    let g:airline_symbols.spell                = 'Ꞩ'
    let g:airline_symbols.notexists            = 'Ɇ'
    let g:airline_symbols.whitespace           = 'Ξ'

    " Theme
    let g:airline_theme='deus'

    " Use shortform for mode names
    let g:airline_mode_map = {
                \ '__'     : '-',
                \ 'c'      : 'C',
                \ 'i'      : 'I',
                \ 'ic'     : 'I',
                \ 'ix'     : 'I',
                \ 'n'      : 'N',
                \ 'multi'  : 'M',
                \ 'ni'     : 'N',
                \ 'no'     : 'N',
                \ 'R'      : 'R',
                \ 'Rv'     : 'R',
                \ 's'      : 'S',
                \ 'S'      : 'SL',
                \ ''     : 'SB',
                \ 't'      : 'T',
                \ 'v'      : 'V',
                \ 'V'      : 'VL',
                \ ''     : 'VB',
                \ }

    " Branch plugin
    let g:airline#extensions#branch#displayed_head_limit = 15

    " Tabline plugin
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1

    " Configure tabline filename formatter
    let g:airline#extensions#tabline#formatter = 'unique_tail'

    " Disable whitespace checking for certain filetypes
    let g:airline#extensions#whitespace#skip_indent_check_ft = {
                \ 'go':       ['mixed-indent-file'],
                \ 'markdown': ['trailing']
                \}

    " Override what to display for sections A and B for certain filetypes
    if !exists("g:airline_filetype_overrides")
        let g:airline_filetype_overrides = {}
    endif
    let g:airline_filetype_overrides.Mundo = [ 'Mundo', '' ]
    let g:airline_filetype_overrides.MundoDiff = [ 'MundoDiff', '' ]
    let g:airline_filetype_overrides.vista = [ 'Vista', '' ]
    let g:airline_filetype_overrides.vista_kind = g:airline_filetype_overrides.vista

    " Do not display encoding if file is utf-8 encoded with unix line breaks
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

    " Display filename with path name if possible
    let g:airline_section_c = '%{AirlineFilename()}'
    function! AirlineFilename()
        let l:filename = substitute(expand('%'), $HOME, '~', '')
        if winwidth(0) < 90 || len(l:filename) > 50
            let l:filename = pathshorten(l:filename)
        endif
        return l:filename
    endfunction
endfunction

function! s:ComfortableMotionConfigPreLoad()
    " Scroll parameters
    let g:comfortable_motion_friction = 0.0
    let g:comfortable_motion_air_drag = 5.0

    " Scroll proportionally to the window height
    let g:comfortable_motion_no_default_key_mappings = 1
    let g:comfortable_motion_impulse_multiplier = 1
    nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
    nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
    nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
    nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

    " Make mouse scroll smooth too
    noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
    noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
endfunction

function! s:GitGutterConfigPreLoad()
    " Set gitgutter refresh rate
    set updatetime=100

    " Turn off default key mappings
    let g:gitgutter_map_keys = 0

    " Define custom key mappings
    nmap ]h         <Plug>(GitGutterNextHunk)
    nmap [h         <Plug>(GitGutterPrevHunk)
    nmap <Leader>ha <Plug>(GitGutterStageHunk)
    nmap <Leader>hr <Plug>(GitGutterUndoHunk)
    nmap <Leader>hv <Plug>(GitGutterPreviewHunk)
    omap ih         <Plug>(GitGutterTextObjectInnerPending)
    omap ah         <Plug>(GitGutterTextObjectOuterPending)
    xmap ih         <Plug>(GitGutterTextObjectInnerVisual)
    xmap ah         <Plug>(GitGutterTextObjectOuterVisual)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" After loading plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load more config, potentially overwriting config from plugins
" These config can also use anything defined by the plugins
function! s:PluginsDidLoad()
    call s:PluginConfigsPostLoad()
    call s:SetOptions()
    call s:BindKeys()
    call s:MiscConfig()
endfunction

" Config for plugins after all plugins have loaded
function! s:PluginConfigsPostLoad()
    colorscheme gruvbox
endfunction

function! s:SetOptions()
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
    set termguicolors
    set ruler
    set showcmd
    set number
    set relativenumber
    set mouse=a
    set cursorline

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
endfunction

function! s:BindKeys()
    " Stop highlighting search items
    nnoremap <silent> <Leader>/ :noh<CR>

    " Jump to previous file
    nnoremap <BS> <C-^>

    " New buffer
    nnoremap <Leader>e :edit<space>

    " Escape in terminal
    tnoremap <Esc> <C-\><C-n>

    " Remappings to retain sanity
    " Make Y's behavior consistent with other commands.
    nnoremap Y y$

    " Swap j and gj, k and gk
    noremap j gj
    noremap k gk
    noremap gj j
    noremap gk k

    " Remap % to gm
    map gm %

    " Remap some text objects
    noremap J }
    noremap K {
    noremap H g^
    noremap L g$

    " Use gG to join lines instead of J
    nnoremap gG J

    " Save and exit
    nnoremap <Leader>w :update<CR>
    nnoremap <silent> <Leader>k :bd<CR>
    nnoremap <Leader>q :quit<CR>
    nnoremap <Leader>Q :quitall!<CR>

    " Open terminal
    nnoremap <silent> <Leader>t :terminal fish<CR>

    " Disable ex mode. Use Q for replaying macros
    nnoremap Q @

    " Use <F1> to find :help for word under cursor
    nnoremap <F1> K
    vnoremap <F1> K
    inoremap <F1> <Nop>

    " Map <C-J> and <C-K> to go to next/previous line in insert mode
    inoremap <C-J> <Down>
    inoremap <C-K> <Up>

    " Type jk or kj in insert mode to enter normal mode
    inoremap jk <ESC>
    inoremap kj <ESC>
endfunction

function! s:MiscConfig()
    call s:QMKConfig()
endfunction

function! s:QMKConfig()
	au BufRead,BufNewFile */qmk_firmware/*/keymap.c	call <SID>SetupQMK()
endfunction

function! s:SetupQMK()
    " Keybinding to align key definitions for QMK
    " Relies on vim-easy-align
    " <C-i>: use the shallowest indentation
    " <C-l>3<CR>: use 3+1 spaces margin between entries
    " * : Use all spaces as delimiters
    nmap <Tab> gaip<C-i><C-l>3<CR>* <CR>=ap

    " Placeholder for better alignment
    iabbrev /n /*none*/
    " Alias for KC_TRANSPARENT
    iabbrev __ _______
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All config has been defined as functions
" Call the driver function
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call s:VimRcMain()
