if !HasPlugin('vimwiki')
  finish
endif

let g:vimwiki_list = [
      \ {
      \   'path': '~/Notes/',
      \   'syntax': 'markdown',
      \   'ext': '.md'
      \ }
      \]

let g:vimwiki_folding = 'list'

" Map the starting keybinding myself to allow lazy-loading
nmap <silent> <leader>ww <Plug>VimwikiIndex

" Start Goyo for vimwiki
autocmd! BufReadPost ~/Notes/index.md silent! Goyo
