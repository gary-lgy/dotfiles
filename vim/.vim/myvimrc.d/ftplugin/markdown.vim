" Enable spell check
setlocal spell

" Key bindings
nmap <buffer> <localleader>c :!pandoc -s % -o %:r.
nmap <buffer> <localleader>p <Plug>MarkdownPreviewToggle

" Enable fenced code block syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'css', 'js=javascript', 'ts=typescript', 'java', 'c', 'cpp']

" Enable markdown syntax concealing
let g:markdown_syntax_conceal = 1
