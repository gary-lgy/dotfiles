" Key bindings to run tests
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

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
