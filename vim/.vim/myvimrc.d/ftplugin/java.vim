" Abbreviations
iab sop System.out.println
iab sof System.out.printf
iab sep System.err.println
iab sef System.err.printf
iab psvm public static void main(String[] args) {<CR>}<UP><END>

" Compilation and running
nmap <leader>cc :!javac %:h/*.java<CR>
nmap <leader>rr :!java -classpath %:h<space>
