" Use space as <leader>
let mapleader = ' '

" Stop highlighting search items
nnoremap <silent> <leader>/ :noh<CR>

" Indent entire buffer
nnoremap <leader>ii gg=G``

" New buffer
nnoremap <leader>e :edit<space>

" Escape in terminal
tnoremap <Esc> <C-\><C-n>

" Remappings to retain sanity{{{
" Make Y's behavior consistent with other commands.
noremap Y y$

" Swap j and gj, k and gk
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Remap %
nmap <Tab> %
vmap <Tab> %
"}}}

" Remap some text objects{{{
" Blocks{{{
nnoremap J }
vnoremap J }
onoremap J }
nnoremap K {
vnoremap K {
onoremap K {
"}}}

" On the same line{{{
nnoremap H g^
vnoremap H g^
onoremap H g^
nnoremap L g$
vnoremap L g$
onoremap L g$
"}}}
"}}}

" Windows{{{
" Navigation{{{
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"}}}

" Split{{{
nnoremap <leader>s :split<space>
nnoremap <leader>v :vsplit<space>
"}}}

" Resize{{{
if has('nvim')
  nnoremap <M-=> <C-w>+
  nnoremap <M--> <C-w>-
  nnoremap <M-,> <C-w><
  nnoremap <M-.> <C-w>>
endif
"}}}
"}}}

" Save and exit{{{
nnoremap <silent> <leader>d :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
"}}}

" Commands{{{
" Open terminal
nnoremap <silent> <leader>t :terminal fish<CR>

" Execute external command
nnoremap <leader>, :!

" Re-execute last command
nnoremap <leader>; :<UP><CR>

" Disable <F1>{{{
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>
inoremap <F1> <Nop>
"}}}
