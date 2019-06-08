" Key bindings to run tests
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>

" Test strategy
let test#strategy = {
  \ 'suite':   'basic',
\}
if has('nvim')
  let test#strategy['nearest'] = 'neovim'
  let test#strategy['file'] = 'neovim'
  let test#neovim#term_position = "belowright"
else
  let test#strategy['nearest'] = 'vimterminal'
  let test#strategy['file'] = 'vimterminal'
  let test#vim#term_position = "belowright"
endif
