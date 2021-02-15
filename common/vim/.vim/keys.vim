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

" Remappings to retain sanity
" Make Y's behavior consistent with other commands.
nnoremap Y y$

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
"

" Remap some text objects
" Blocks
nnoremap J }
xnoremap J }
onoremap J }
nnoremap K {
xnoremap K {
onoremap K {

" On the same line
nnoremap H g^
xnoremap H g^
onoremap H g^
nnoremap L g$
xnoremap L g$
onoremap L g$

" Use gG to join lines instead of J
nnoremap gG J

" Save and exit
nnoremap <leader>w :update<CR>
nnoremap <silent> <leader>bk :bd<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :quitall!<CR>

" Open terminal
nnoremap <silent> <leader>t :terminal fish<CR>

" Disable ex mode. Use Q for replaying macros
nnoremap Q @

" Disable <F1>
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>
inoremap <F1> <Nop>

" Map <C-J> and <C-K> to go to next/previous line in insert mode
inoremap <C-J> <Down>
inoremap <C-K> <Up>

" Type jk or kj in insert mode to enter normal mode
inoremap jk <ESC>
inoremap kj <ESC>
