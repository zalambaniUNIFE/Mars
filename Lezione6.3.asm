#esercizio 10

.text
li $t0, 0
li $t1, 0
li $t2, 0

for1:
	bgt $t0, 3, exit
	addi $t0, $t0, 1
	j for2
	for2:
		bgt $t1, 2, for3
		addi $t1, $t1, 1
		j for3
		for3:
			bgt $t2, 2, for1
			addi $t2, $t2, 1
			li $v0, 1
			move $a0, $t2
			syscall
			j for3
			
exit:
	li $v0, 10
	syscall
			