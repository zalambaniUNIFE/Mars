.data
i: .word 3
j: .word 6

.text
lw $s0, i
lw $s1, j
#slt $t0, $s0, $s1 #i<j ->$t0 = 1
#beq $t0, $zero, false # se i>j ->salta a false
#blt $s1, $s0, false #vai a false se i>j
bge $s0, $s1, false #meglio così perchè non devi fare il complementare a mano
li $s2, 1

false:

move $a0, $s2
li $v0, 1
syscall