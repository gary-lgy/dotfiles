" Leader keys
let mapleader = ' '
let maplocalleader = '  '

" Stop highlighting search items
nnoremap <silent> <leader>/ :noh<CR>

" Jump to previous file
nnoremap <BS> <C-^>

" New buffer
nnoremap <leader>e :edit<space>

" Escape in terminal
tnoremap <Esc> <C-\><C-n>

" Remappings to retain sanity{{{
" Make Y's behavior consistent with other commands.
" Use yankstack if it exists
if HasPlugin('vim-yankstack')
  call yankstack#setup()
  nmap Y y$
else
  nnoremap Y y$
endif

" Swap j and gj, k and gk
nnoremap j gj
xnoremap j gj
onoremap j gj
nnoremap k gk
xnoremap k gk
onoremap k gk
nnoremap gj j
xnoremap gj j
onoremap gj j
nnoremap gk k
xnoremap gk k
onoremap gk k

" Remap %
nmap gm %
xmap gm %
omap gm %
"}}}

" Remap some text objects{{{
" Blocks{{{
nnoremap J }
xnoremap J }
onoremap J }
nnoremap K {
xnoremap K {
onoremap K {
"}}}

" On the same line{{{
nnoremap H g^
xnoremap H g^
onoremap H g^
nnoremap L g$
xnoremap L g$
onoremap L g$
"}}}
"}}}

" Use gG to join lines instead of J
nnoremap gG J

" Split{{{
nnoremap <leader>ws :split<space>
nnoremap <leader>wv :vsplit<space>
"}}}

" Resize{{{
if has('nvim')
  nnoremap <M-+> <C-w>+
  nnoremap <M-_> <C-w>-
  nnoremap <M-<> <C-w><
  nnoremap <M->> <C-w>>
endif
"}}}
"}}}

" Save and exit{{{
nnoremap <leader>j :update<CR>
nnoremap <silent> <leader>bk :bd<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :quitall!<CR>
"}}}

" Commands{{{
" Open terminal
nnoremap <silent> <leader>t :terminal fish<CR>

" Disable ex mode. Use Q for replaying macros
if HasPlugin('vim-peekaboo')
  " Use peekaboo if possible
  nmap <buffer> <expr> Q peekaboo#peek(v:count1, '@', 0)
else
  nnoremap Q @
endif

" Disable <F1>
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>
inoremap <F1> <Nop>
"

" Map <C-J> and <C-K> to go to next/previous line in insert mode
inoremap <C-J> <Down>
inoremap <C-K> <Up>

" Type jk or kj in insert mode to enter normal mode
inoremap jk <ESC>
inoremap kj <ESC>