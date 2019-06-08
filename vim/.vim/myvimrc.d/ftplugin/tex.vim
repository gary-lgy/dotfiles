" Compilation
nmap <buffer> <leader>cp :!pandoc -s --mathjax % -o %:r.
nmap <buffer> <leader>cl :!latexmk -pdf % && latexmk -c
