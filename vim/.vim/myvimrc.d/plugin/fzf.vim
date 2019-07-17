if !HasPlugin('fzf.vim')
  finish
endif

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
nnoremap <leader>f. <Cmd>Files ./<CR>
nnoremap <leader>fa <Cmd>Files ~<CR>
nnoremap <leader>fg <Cmd>GFiles?<CR>
nnoremap <leader>ft <Cmd>Tags<CR>
nnoremap <leader>fb <Cmd>Buffers<CR>
nnoremap <leader>ff <Cmd>History<CR>
nnoremap <leader>f; <Cmd>History:<CR>
nnoremap <leader>fs <Cmd>History/<CR>
nnoremap <leader>fc <Cmd>Commits<CR>
nnoremap <M-/>      <Cmd>BLines<CR>
" BCommits

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
