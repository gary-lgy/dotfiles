" Use space as <leader>
let mapleader = ' '

" Stop highlighting search items
nnoremap <leader>/ :noh<CR>

" Indent entire buffer
nnoremap <leader>i gg=G<C-O>

" Remappings to retain sanity{{{
" Make Y's behavior consistent with other commands.
noremap Y y$

" Swap j and gj, k and gk
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Remap %
nnoremap <Tab> %
vnoremap <Tab> %
"}}}

" Text manipulation{{{
" Move stuff around{{{
nnoremap <M-j> :m+1<CR>==
nnoremap <M-k> :m-2<CR>==
inoremap <M-j> <Esc>:m+1<CR>==i
inoremap <M-k> <Esc>:m-2<CR>==i
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
"}}}

" Add lines above or below current line.{{{
nnoremap [<space> O<Esc>
nnoremap ]<space> o<Esc>
"}}}

"" Auto format pasted text{{{
" This is enabled in miniyank.vim
"nmap p p=']
"nmap P P=']
""}}}
"}}}

" Navigation within the same buffer{{{
" Around blocks{{{
nnoremap J }
vnoremap J }
nnoremap K {
vnoremap K {
"}}}

" On the same line{{{
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
"}}}
"}}}

" Buffers{{{
" Navigation{{{
if has('nvim')
  nnoremap <leader>p :bprev<CR>
  nnoremap <leader>n :bnext<CR>
  tnoremap <leader>p <C-\><C-n>:bprev<CR>
  tnoremap <leader>n <C-\><C-n>:bnext<CR>
else
  nnoremap <leader>p :bprev<CR>
  nnoremap <leader>n :bnext<CR>
endif
"}}}

" New buffer{{{
nnoremap <leader>e :edit<space>
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
