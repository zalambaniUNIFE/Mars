.data
num: .word 0
i: .word 0
flag: .word 0
strin: .asciiz "Enter a number to check whether prime or not: "
strout: .asciiz "Entered number "
prime: .asciiz " is a prime number"
notprime: .asciiz " is not a prime number"

.text
li $v0, 4
la $a0, strin #stampo la stinga di inizio codice
syscall
li $v0, 5 #legge un integer e lo inserisce in $v0
syscall
add $s2, $s2, $v0 #salvo il numero inserito in un registro preservato che non modificherò
lw $s0, i #salvo nel registro $s0 il valore di i
lw $s1, flag #salvo nel registro $s1 il valore di flag
ble $v0, 1, flagChange #flag = 1 se il numero è 0 o 1 quindi essendo int quando è minore o uguale a 1
addi $s0, $s0, 2 #faccio partire i da 2

forloop:
	div $t0, $v0, 2 #divido num per 2 
	bge $s0, $t0, escifor #se i < num/2 esco dal ciclo
	div $v0, $s0 #divido num per i 
	mfhi $t1 #salvo il resto della divisione da $hi a $t1
	beq $t1, 0, flagChange #se il resto è 0, quindi se num ha un divisore allora flag = 1
	addi $s0, $s0, 1 #aggiorno i: i+=1
	j forloop #riparte il loop
	
flagChange:
	li $s1, 1 #funzione che cambia il flag da 0 a 1
	j escifor #se il flag = 1 allora non è primo ed esco dal for

escifor:
	li $v0, 4
	la $a0, strout #stampo "Entered number" comune a entrambe le strighe
	syscall
	li $v0, 1
	add $a0, $s2, $zero #stampo il numero inserito all'inizio nel registro $s2 mai stato modificato
	syscall
	
	bne $s1, 1, primo #se è primo allora branch taken (ho scelto questo tipo di approccio perchè è più probabile inserire un numero non primo che primo, quindi il branch rimane spesso untaken)
	li $v0, 4
	la $a0, notprime #stampo la stringa nel caso non sia primo
	syscall
	j return0 #esco
	
primo:
	li $v0, 4
	la $a0, prime #stampo la stringa nel caso sia primo
	syscall
	
return0:	
	li $v0, 10 #return 0
	syscall

	
