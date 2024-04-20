.data
#.eqv op1, $t0
#.eqv op2, $t1
#.eqv risultato, $t2

#.text
#addi op1, op1, 1
#addi op2, op2, 2
#add risultato, op1, op2

.data
a: .byte 8
stringa: .asciiz "AB"
b: .byte 9
c: .byte 10,11,12,13

#.text
#addi $s0, $zero, 0x10010000
#lb $t0, 0($s0) #viene memorizzato 00 00 00 08, quindi è little endian. se fosse stato 3 sarebbe stato big endian
.text 
#addi $v0, $zero, 10
#syscall #non più "(dropped off bottom)"

#addi $v0, $zero, 1
#addi $a0, $zero, 9
#syscall #stampa 9

li $a0, 42 # Carichiamo il valore da stampare in $a0
li $v0, 1 # Carichiamo il codice della syscall in $v0 
syscall # Invochiamo la syscall con codice 1
# risultato: stampa 42

addi $v0, $zero, 1
li $s0, 0x10010000
lw $a0, 0($s0)
li $v0, 1
syscall
li $v0, 10
syscall
