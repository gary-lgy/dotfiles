" Compilation
nmap <leader>cp :!pandoc -s --mathjax % -o %:r.
nmap <leader>cl :!latexmk -pdf % && latexmk -c
