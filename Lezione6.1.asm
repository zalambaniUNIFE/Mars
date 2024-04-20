.data
in: .asciiz "Enter a positive number: "
p: .asciiz "Sum = "

.text
	li $s0, 0 #(sum)
	li $v0, 4
	la $a0, in
	syscall

	li $v0, 5
	syscall

	move $t0, $v0 #setto la fine (num)
	li $t1, 1 #setto il contatore (count)
for:
	bgt $t1, $t0, exit
	add $s0, $s0, $t1
	addi $t1, $t1, 1
	j for
exit:
	li $v0, 4
	la $a0, p
	syscall
	
	li $v0, 1
	move $a0, $s0 
	syscall