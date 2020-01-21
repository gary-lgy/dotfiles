if !HasPlugin('rainbow_parentheses.vim')
  finish
endif

" Automatically activate raianbox parentheses for certain filetypes
augroup rainbow_parentheses
  autocmd!
  autocmd FileType lisp,clojure,scheme,javascript,javascript.tsx,javascriptreact,typescript,typescript.tsx,typescriptreact,vim RainbowParentheses
augroup END

" Pairs to enable rainbow colors
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
