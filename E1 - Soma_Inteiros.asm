.data
	msg1: .asciiz "Digite o Primeiro Número: "
	msg2: .asciiz "\nDigite o Segundo Número: "
	msg3: .asciiz "\nA Soma dos Números é Igual a = "
.text
	# Impressão da Mensagem 1:
	li $v0,4 # Comando para Impressão de String
	la $a0, msg1 # Move a Mensagem ao Registrador a0
	syscall # Faça! Imprima a Mensagem
	
	# Leitura do Primeiro Número:
	li $v0,5 # Comando para Leitura de um Inteiro
	syscall # Faça! Leia o Inteiro do Teclado
	move $s0,$v0 # Move o Inteiro para s0
	
	# Impressão da Mensagem 2:
	li $v0,4 # Comando para Impressão de String
	la $a0, msg2 # Move a Mensagem ao Registrador a0
	syscall # Faça! Imprima a Mensagem!
	
	# Leitura do Segundo Número:
	li $v0,5 # Comando Para Leitura do Número Inteiro
	syscall # Faça! Leia o Número Inteiro!
	move $s1,$v0 # Mova o Inteiro para o Registrador s1
	
	# Impressão da Mensagem 3:
	li $v0,4 # Comando para Impressão de String
	la $a0,msg3 # Move a Mensagem para a0
	syscall # Faça! Imprima a Mensagem!
	
	# Soma dos Dois Números:
	add $s2,$s0,$s1 # Soma e Armazena no Registrador s2
	move $a0,$s2 # Move o Resultado para o a0
	li $v0,1 # Impressão de Inteiro
	syscall # Faça! Imprima o Resultado da Soma
	