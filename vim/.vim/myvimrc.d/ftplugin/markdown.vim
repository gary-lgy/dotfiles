" Enable spell check
set spell

" Map shortcut for compiling document with pandoc
nmap <buffer> <leader>cc :!pandoc -s % -o %:r.

" Enable fenced code block syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'css', 'js=javascript', 'java', 'c', 'cpp']

" Disable markdown syntax concealing
let g:markdown_syntax_conceal = 0
