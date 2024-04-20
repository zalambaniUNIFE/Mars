.data
A: .word 15
B: .word 10
C: .word 7
D: .word 2
E: .word 18
F: .word -3
Z: .word 0 #z = (a+b) + (c-d) + (e+f) - (a-c);
S.: .asciiz "Il risultato vale "

.text
lui $t0, 0x1001
lw $t1, A
lw $t2, B
lw $t3, C
lw $t4, D
lw $t5, E
lw $t6, F
lw $t7, Z

add $s0, $t1, $t2
sub $s1, $t3, $t4
add $s2, $t5, $t6
sub $s3, $t1, $t3

add $t7, $s0, $s1
add $t7, $t7, $s2
sub $t7, $t7, $s3

addi $a0, $t0, 28
addi $v0, $zero, 4
syscall

move $a0, $t7

addi $v0, $zero, 1
syscall
