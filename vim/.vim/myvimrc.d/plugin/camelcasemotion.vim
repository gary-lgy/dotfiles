if !HasPlugin('CamelCaseMotion')
  finish
endif

" In normal and visual mode, w, b, e will have camel case motions
" Operator-pending mode is not affected
nmap <silent> w  <Plug>CamelCaseMotion_w
xmap <silent> w  <Plug>CamelCaseMotion_w
nmap <silent> b  <Plug>CamelCaseMotion_b
xmap <silent> b  <Plug>CamelCaseMotion_b
nmap <silent> e  <Plug>CamelCaseMotion_e
xmap <silent> e  <Plug>CamelCaseMotion_e
nmap <silent> ge <Plug>CamelCaseMotion_ge
xmap <silent> ge <Plug>CamelCaseMotion_ge

" Insert mode mappings
imap <silent> <S-Left>  <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w
