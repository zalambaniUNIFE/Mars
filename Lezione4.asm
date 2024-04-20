.data
strinput: .asciiz "inserisci un numero "
stroutpari: .asciiz "il numero è pari."
stroutdispari: .asciiz "il numero è dispari."

.text
li $v0, 4
la $a0, strinput
syscall

li $v0, 5
syscall

move $a0, $v0
jal paridispari

beq $v0, $zero, stampapari
la $a0, stroutdispari
li $v0, 4
syscall
j exitmain

stampapari:
la $a0, stroutpari
li $v0, 4
syscall

exitmain:
li $v0, 10
syscall

paridispari:
div $a1, $a0, 2
mfhi $t0
bnez $t0, false
li $v0, 0
j exit

false:
li $v0, 1

exit:
jr $ra