" Use space as <leader>
let mapleader = ' '

" Stop highlighting search items
nnoremap <leader>/ :noh<CR>

" Indent entire buffer
nnoremap <leader>i gg=G<C-O>

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

" Navigation within the same buffer{{{
" Around blocks{{{
nnoremap J }
vnoremap J }
nnoremap K {
vnoremap K {
"}}}

" On the same line{{{
nnoremap H g^
vnoremap H g^
nnoremap L g$
vnoremap L g$
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
nnoremap <leader>d :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
"}}}

" Commands{{{
" Open terminal
nnoremap <leader>t :terminal<CR>

" Execute external command
nnoremap <leader>, :!

" Re-execute last command
nnoremap <leader>; :<UP><CR>

" Grep with rg
nmap <leader>g :Grep<space>
"}}}

" Emacs style keybindings for command and insert mode{{{
" Ctrl-W, Ctlr-U, and Ctrl-h are available by default
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-b> <Left>
noremap! <C-f> <Right>
noremap! <C-d> <Del>

if has('nvim')
  noremap! <M-b> <S-Left>
  noremap! <M-f> <S-Right>
else
  noremap! <Esc>b <S-Left>
  noremap! <Esc>f <S-Right>
endif

inoremap <C-k> <Esc>lDA
"}}}

" Disable <F1>{{{
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>
inoremap <F1> <Nop>
"}}}
