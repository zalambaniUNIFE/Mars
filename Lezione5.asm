.data
num: .word 0
count: .word 0
sum: .word 0
strinput: .asciiz "Enter a positive integer: "
strout: .asciiz "Sum = "

.text
li $v0, 4
la $a0, strinput
syscall

li $v0, 5
syscall

move $s0, $v0
lw $t1, count
lw $s2, sum

lw $t0, ($s0) # Indice "i" in $t1

loop_label:
beq $t1, $t0, esci_label
# Corpo del loop
addi $s2, $s2, 1
move $a0, $t1
syscall
# Aggiornamento
addi $t1, $t1, 1
j loop_label

esci_label:
la $a0, strout
li $v0, 4
syscall
la $a0, sum
li $v0, 5
syscall

li $v0, 10
syscall