" Disable ALE if on battery (depends on acpi and cut)
let s:ac_status = trim(system("acpi -a | awk '{print $3}'"))
if s:ac_status == "off-line"
  autocmd VimEnter * ALEDisable
endif

" Always show sign column
set signcolumn=yes

" Key bindings for navigating to next/previous errors
nmap <leader>J :ALENext<CR>
nmap <leader>K :ALEPrevious<CR>

" Define fixers
if !exists('g:ale_fixers')
  let g:ale_fixers = {}
endif
let g:ale_fixers.ruby = ['rubocop']
