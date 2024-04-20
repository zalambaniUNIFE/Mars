.data
arr: .word 1 2 3 4 5 6
size: .word 5
key: .word 3
string: .asciiz "Element found at position "

.text
la $a0, arr
lw $a1, size
lw $a2, key
jal findElement
li $v0, 10
syscall

findElement:
	addi $sp, $sp, -4 #crea spazio pari a 4byte nello stack per inserire il contatore
	sw $s0, 0($sp)
	li $s0, 0
forloop:
	beq $s0, $a1, esci #se i = size, allora esci dal loop

	sll $t0, $s0, 2 #shift left per calcolare la posizione della word interna all'array
	add $t0, $t0, $a0 #carica in $t0, l'indirizzo della word (arr[i])
	lw $t0, 0($t0) #valore di arr[i]
	bne $t0, $a2, escif #se arr[i] != key, esci da if
	li $v0, 4 #altrimenti stampa la sua posizione
	la $a0, string
	syscall
	li $v0, 1
	addi $a0, $s0, 1
	syscall
	j esci #a fine stampa esci dal loop
escif:
	addi $s0, $s0, 1 # i+=1
	j forloop #torna al loop
esci:
	lw $s0, 0($sp) #salva in $s0 il valore dello stack pointer
	addi $sp, $sp, 4 #aggiungi 4
	jr $ra #torna all'chiamante precedentemente salvato in $ra
	
