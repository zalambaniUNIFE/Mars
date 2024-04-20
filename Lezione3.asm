.data
.align 0 # rimuove il padding (per macchine che supportano accessi non allineati)
c: .byte 'c' #codice ascii 0x63
.align 1 #allinea a multipli di 2^1 = 2, con questo ripristiniamo il padding
s: .half 4 #allocazione in memoria di 0x0004
#dim = 4 byte -> 1 char + 1 padding + 2 half

.text