if !HasPlugin('vista.vim')
  finish
endif

nmap <silent> <F8> :Vista!!<CR>

let g:vista_cursor_delay = 300
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_floating_delay = 0

if HasPlugin('coc.nvim')
  let g:vista_executive_for = {
      \ 'javascript':     'coc',
      \ 'javascript.jsx': 'coc',
      \ 'typescript':     'coc',
      \ 'typescript.tsx': 'coc',
      \ 'yaml':           'coc',
      \ 'ruby':           'coc',
      \ 'python':         'coc',
      \ 'html':           'coc',
      \ 'css':            'coc',
      \ 'scss':           'coc',
      \ 'json':           'coc'
      \ }
endif

if HasPlugin('fzf.vim')
  let g:vista_fzf_preview = ['right:50%']
endif
