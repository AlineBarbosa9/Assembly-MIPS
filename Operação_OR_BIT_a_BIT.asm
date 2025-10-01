.data
	msg1: .asciiz "\nDigite o Primeiro Número: "
	msg2: .asciiz "\nDigite o Segundo Número:  "
	result: .asciiz "\n Resultado: "
	
.text
	# Impressão de String
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg1 # Carrega a Mensagem ao Registrador a0
	syscall # Faça! Imprima a Mensagem
	
	# Leitura do Primeiro Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faça! Leia o Número Inteiro
	# o Número Inteiro Lido é Guardado no Registrador v0
	move $t0,$v0 # Transfere o Inteiro Lido para o Registrador t0
	
	# Impressão de String
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg2 # Carrega a Mensagem ao Registrador a0
	syscall # Faça! Imprima a Mensagem
	
	# Leitura do Segundo Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faça! Leia o Número Inteiro!
	# o Número Lido é Guardado no Registrador v0
	move $t1,$v0 # Move o Inteiro Lido para o Registrador t1
	
	# Operação OR bit a bit
	or $t2, $t1,$t0 # Realiza a Operação OR entre os Inteiros Lidos Anteriormente
	# O Resultado da Operação é Armazenado em t2
	
	# Impressão de String
	li $v0, 4 # Comando para Impressão de String
	la $a0,result # Move a Mensagem ao Registrador a0
	syscall # Faça! Imprima a String
	
	# Impressão do Resultado
	li $v0,1 # Comando para Impressão de Inteiro
	move $a0,$t2 # Move o Resultado ao Regitrador a0
	syscall # Faça! Imprima o Resultado
	
	# Encerrar Programa
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Faça! Encerre o Programa 
	
	
	