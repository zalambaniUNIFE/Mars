.data
i: .word 3
j: .word 6

.text
lw $s0, i
lw $s1, j
slt $t0, $s0, $s1
bne $t0, $zero, then
li $s0, 1

then:
li $s0, 0
j exit

exit:
move $a0, $s0
li $v0, 1
syscall