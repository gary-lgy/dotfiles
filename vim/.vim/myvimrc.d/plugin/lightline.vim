if !HasPlugin('lightline.vim')
  finish
endif

set laststatus=2
set showtabline=2
set noshowmode

if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.colorscheme = 'one'

" Tabline
let g:lightline.tabline = {
      \   'left': [ ['bufferline'] ],
      \   'right': [ ['bufnum'] ]
      \ }

if !exists('g:lightline.active')
  let g:lightline.active = {}
endif

" Components
let g:lightline.active.left =  [
      \ [ 'mode', 'paste', 'spell', 'modified' ],
      \ [ 'gitbranch', 'readonly', 'filename' ]
      \ ]

let g:lightline.active.right = [
      \ [ 'lineinfo' ],
      \ [ 'percent' ],
      \ [ 'fileformat', 'fileencoding', 'filetype' ]
      \ ]

" Component definitions
let g:lightline.component_expand = {
      \ 'bufferline': 'LightlineBufferline',
      \ }

let g:lightline.component_function= {
      \ 'mode': 'LightlineMode',
      \ 'modified': 'LightlineModified',
      \ 'gitbranch': 'fugitive#head',
      \ 'filename': 'LightlineFilename',
      \ 'readonly': 'LightlineReadonly',
      \ 'fileformat': 'LightlineFileformat',
      \ 'fileencoding': 'LightlineFileencoding',
      \ 'filetype': 'LightlineFiletype'
      \ }

let g:lightline.component_type= {
      \ 'bufferline': 'tabsel',
      \ }

" Separators
let g:lightline.separator = {
      \ 'left': '',
      \ 'right': ''
      \}

let g:lightline.subseparator = {
      \ 'left': '',
      \ 'right': '' 
      \}

let g:lightline.mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'V-L',
      \ "\<C-v>": 'V-B',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'S-L',
      \ "\<C-s>": 'S-B',
      \ 't': 'T',
      \ }

" Functions
function! LightlineFilename()
  let l:filename = pathshorten(substitute(expand('%'), $HOME, '~', ''))
  return l:filename == '__Mundo__' ? '' :
        \ l:filename == '__Mundo_Preview__' ? '' : 
        \ &ft == 'qf' ? '' :
        \ l:filename != '' ? l:filename : '[No Name]'
endfunction

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineModified()
  return &modified ? '+' : ''
endfunction

function! LightlineMode()
  let l:fname = expand('%:t')
  return l:fname == '__Tagbar__' ? 'Tagbar' :
        \ l:fname == '__Mundo__' ? 'Mundo' :
        \ l:fname == '__Mundo_Preview__' ? 'Mundo Preview' :
        \ l:fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'qf' ? 'Quickfix' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
