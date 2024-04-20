.data
strinput: .asciiz "Input a number larger than 1: "
strnoprimo: .asciiz " is not a prime number"
strprimo: .asciiz " is a prime number"

.text
li $s0, 0 
li $v0, 4 
la $a0, strinput 
syscall

li $v0, 5
syscall

move $t0, $v0
li $t1, 2

for:
	bge $t1, $t0, exit
	div $t2, $t0, $t1
	mfhi $t3
	beq $t3, $zero, noprimo
	addi $t1, $t1, 1
	j for

exit:
	beq $s0, 1, noprimo
	
primo:
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4 
	la $a0, strprimo
	syscall
	li $v0, 10
	syscall

noprimo:
	li $s0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4 
	la $a0, strnoprimo
	syscall
	li $v0, 10
	syscall