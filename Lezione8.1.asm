.data
strin: .asciiz "enter a value to check divisibility with 6: "
strout1: .asciiz "the number is divisible by 6"
strout2: .asciiz "the number is not divisible by 6"

.text
main:
	li $v0, 4
	la $a0, strin
	syscall

	li $v0, 5
	syscall
	move $a0, $v0
	
	j div_6
	li $v0, 10
	syscall
	
div_6:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	div $a2, $a0, 3
	mfhi $t0
	bne $t0, 0, return2
	jal div_2
	bne $a1, 1, return2
	li $v0, 4
	la $a0, strout1
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
		
return1:
	li $a1, 0
	jr $ra
	
return2:
	li $v0, 4
	la $a0, strout2
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
div_2:
	div $a1, $a0, 2
	mfhi $t0
	bne $t0, 0, return1
	li $a1, 1
	jr $ra