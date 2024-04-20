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

jal do_match
add $t7, $v1, $zero
addi $a0, $t0, 28
addi $v0, $zero, 4
syscall

move $a0, $t7

addi $v0, $zero, 1
syscall

li $v0, 10
syscall

do_match:
addi $sp, $sp, -20
sw $s0, 16($sp) 
sw $s1, 12($sp)
sw $s2, 8($sp)
sw $s3, 4($sp)
sw $s4, 0($sp)

#procedura
add $s0, $t1, $t2
sub $s1, $t3, $t4
add $s2, $t5, $t6
sub $s3, $t1, $t3

add $s4, $s0, $s1
add $s4, $s4, $s2
sub $s4, $s4, $s3

#risultato:
add $v1, $s4, $zero

#rispristino
lw $s4, 0($sp) 
lw $s3, 4($sp)
lw $s2, 8($sp)
lw $s1, 12($sp)
lw $s0, 16($sp)
addi $sp, $sp, 20

jr $ra
