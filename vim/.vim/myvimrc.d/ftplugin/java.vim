" Abbreviations
iab <buffer> sop System.out.println
iab <buffer> sof System.out.printf
iab <buffer> sep System.err.println
iab <buffer> sef System.err.printf
iab <buffer> psvm public static void main(String[] args) {}<LEFT><CR>

" Compilation and running
nnoremap <buffer> <leader>cc :!javac %:h/*.java<CR>
nnoremap <buffer> <leader>rr :!java -classpath %:h<space>
