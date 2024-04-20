.data
.align 0 #rimuovo i 3 byte di padding finali
d: .double 0
.align 2 # 2^2 ripristina i 3 di padding precedenti: 4 word + 1 byte + 3 padding
s: .word -1
c: .byte 'c'
#dim.: 8 + 4 + 1 + 3 padding