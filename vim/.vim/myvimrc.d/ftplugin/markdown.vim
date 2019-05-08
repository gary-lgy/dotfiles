" Enable spell check
set spell

" Map shortcut for compiling document
nmap <leader>cc :!pandoc -s % -o %:r.
