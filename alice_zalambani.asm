.data
i: .word 0 #alloco i nel segmento dati
count: .word 0 #alloco count nel segmento dati
arr: .space 40 #alloco arr nel segmento dati (dim. = 10 word * 4 byte)
strin: .asciiz "Enter the Number: " #prima stringa di testo
strout: .asciiz "\nReverse = " #seconda stringa di testo

.text
lw $s0, i #inserisco il valore di i in $s0
lw $s1, count #inserisco il valore di count in $s1
la $s3, arr #inserisco l'indirizzo del primo elemento di arr in $s3

#istruzioni per stampare la prima stringa:
li $v0, 4
la $a0, strin
syscall

#istruzioni per chiedere in input il valore di num
li $v0, 5
syscall

move $s4, $v0 #sposto il valore di num in un registro preservato

while:
	beq $s4, $zero, esciwhile #esci se num = 0
	li $t0, 10 #inserisco temporaneamente 10 in $t0 per calcolare il modulo
	div $s4, $t0 #il resto della divisione viene scritto il hi
	mfhi $s5 #sposto il resto da hi a un registro preservato $s5
	
	#calcolo dell'indirizzo per arr:
	sll $t0, $s0, 2 #calcolo l'offset con uno shift left del valore i: i*4
	add $t0, $t0, $s3 #riutilizzo $t0 per calcolare l'indirizzo di a[i] = indirizzo di a[0] + offset
	
	sw $s5, 0($t0)#a[i] = rem
	
	div $s4, $s4, 10 #divido il numero per 10
	
	addi $s0, $s0, 1 #i+=1
	addi $s1, $s1, 1 #count+=1
	j while #ripeto il ciclo
	
esciwhile:
	#istruzioni per stampare la seconda stringa:
	li $v0, 4
	la $a0, strout
	syscall
	
	la $a1, 0($s3) #$a1 contiene il primo argomento della chiamata a funzione: vec[]
	move $a2, $s1 #$a2 contiene il secondo argomento della chiamata a funzione: cnt
	jal stampa #jump alla funzione stampa e salva l'indirizzo del chiamante in $ra
	
	#return 0:
	li $v0, 10
	syscall
	
stampa: 
	addi $sp, $sp, -4 #tolgo 4 byte dall' indirizzo dello stackpointer
	sw $s0, 0($sp) #preservo il valore di $s0 (i) così che non venga cambiato dopo l'esecuzione della funzione
	li $s0, 0 #i = 0
	for:
		bge $s0, $a2, escifor #se i >= a cnt esci dal for
		
		#calcolo dell'indice per a[i]
		sll $t0, $s0, 2 #offset: i*4
		add $t0, $t0, $a1 #indirizzo di a[i] = indirizzo di a[0] + offset
		
		lw $a0, 0($t0) #salvo il valore di a[i] direttamente in $a0 per la syscall
		li $v0, 1
		syscall #stampa a[i]
		addi $s0, $s0, 1 #i+=1
		j for #ripeto il ciclo
	escifor:
		lw $s0, 0($sp) #ricarico in $s0 il valore precedente alla chiamata a funzione
		addi $sp, $sp, 4 #aggiorno lo stackpointer al valore precedente
		jr $ra #esco dalla funzione