" FZF is be the best shit I've ever seen!

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
nnoremap <leader>f. :Files ./<CR>
nnoremap <leader>fa :Files ~<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>a  :Ag<space>
nnoremap <leader>ff :History<CR>
nnoremap <leader>f; :History:<CR>
nnoremap <leader>fs :History/<CR>
nnoremap <leader>fc :Commits<CR>
" BCommits
