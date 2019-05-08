" Disable ALE if on battery (depends on acpi and cut)
let s:ac_status = trim(system("acpi -a | cut -d' ' -f3 | cut -d- -f1"))
if s:ac_status == "off"
  autocmd VimEnter * ALEDisable
endif

" Always show sign column
set signcolumn=yes

" Key bindings for navigating to next/previous errors
nmap <leader>J :ALENext<CR>
nmap <leader>K :ALEPrevious<CR>
