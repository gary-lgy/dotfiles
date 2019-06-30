" Disable ALE if on battery (depends on acpi and cut)
let s:ac_status = trim(system("acpi -a | awk '{print $3}'"))
if s:ac_status == "off-line"
  autocmd VimEnter * ALEDisable
endif

" Always show sign column
set signcolumn=yes

" Key bindings
nmap ]d         <Plug>(ale_next_wrap)
nmap [d         <Plug>(ale_previous_wrap)
nmap <leader>af <Plug>(ale_fix)
nmap <leader>ad <Plug>(ale_detail)

" Define fixers
if !exists('g:ale_fixers')
  let g:ale_fixers = {}
endif
let g:ale_fixers.ruby = ['rubocop']
let g:ale_fixers.typescript = ['eslint', 'prettier']
let g:ale_fixers.javascript = ['eslint', 'prettier']
let g:ale_fixers.json = ['prettier']

" Use virtual text to display diagnostics
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '▶ '

" Syntax highlight
highlight ALEVirtualTextError   cterm=bold,italic gui=bold,italic ctermfg=Red guifg=#fb4934
highlight ALEVirtualTextWarning cterm=italic      gui=italic      ctermfg=224 guifg=Orange
