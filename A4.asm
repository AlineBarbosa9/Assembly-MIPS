# Este Programa em Assembly-MIPS calcula o MDC entre Dois
# Números Inteiros Positivos Usando o Algoritmo de Euclides

# Local em que os Dados são Declarados
.data
	# Mensagens que serão exibidas ao usuário
	num1: .asciiz "\nDigite um Número Inteiro Qualquer: "
	num2: .asciiz "\nDigite outro Número Inteiro Qualquer: "
	result: .asciiz "\nO MDC entre os dois números é de: "

# Local em que as Instruções são Declaradas
.text
	# Impressão da Mensagem de Input do Primeiro Número
	li $v0,4 # Comando para Impressão de String
	la $a0,num1 # Carrega o Endereço da String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura do Primeiro Número Inteiro
	li $v0,5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Inteiro
	move $t0,$v0 # Transfere o Inteiro Lido ao Registrador $t0

	# Impressão da Mensagem de Input do Segundo Número
	li $v0,4 # Comando para Impressão de String
	la $a0,num2 # Carrega o Endereço da String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura do Segundo Número Inteiro
	li $v0,5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Inteiro
	move $t1,$v0 # Transfere o Inteiro Lido ao Registrador $t1

	# Algoritmo de Euclides - MDC
	euclides:
		beqz $t1,final # Se B == 0, Encerre o Algoritmo
		div $t0,$t1 # Faz a Divisão de A e B
		mfhi $t2 # Move o Resto da Divisão Para o Registrador $t2
		move $t0,$t1 # Valor de A Recebe o Valor Atual de B
		move $t1, $t2 # Resto da Divisão é o Novo Valor de B
		j euclides # Volte ao Ciclo
	
	# Impressão de Resultados e Encerramento do Programa
	final:
		# Impressão de Mensagem de Resultado
		li $v0,4 # Comando para Impressão de String
		la $a0,result # Move o Endereço da String ao Registrador $a0
		syscall # Imprime a Mensagem na Tela
		
		# Impressão do MDC entre A e B
		li $v0,1 # Comando Para Impressão de Inteiro
		move $a0,$t0 # Move o Resultado ao Registrador $a0
		syscall # Imprime o Resultado na Tela
		
		# Encerra o programa
		li $v0, 10 # Comando Para Encerrar o Programa
		syscall # Encerra o Programa
	

		

