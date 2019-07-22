" Enable spell check
setlocal spell

" Map shortcut for compiling document with pandoc
nmap <buffer> <leader>cc :!pandoc -s % -o %:r.

" Enable fenced code block syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'css', 'js=javascript', 'ts=typescript', 'java', 'c', 'cpp']

" Enable markdown syntax concealing
let g:markdown_syntax_conceal = 1
