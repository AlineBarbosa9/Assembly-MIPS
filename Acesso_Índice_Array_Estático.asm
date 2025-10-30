# Este Programa em Assembly-MIPS obtém o Índice de 0 a 4
# do Usuário e Determina qual Elemento do Array Estático
# É Correspondente ao Índice Informado. Se o Valor Lido
# For Maior que 4 ou Menor que 0, a Validação é Realizada

# Seção em que os Dados São Declarados
.data
	array: .word 10,20,30,40,50 # Declaração de um Vetor Estático
	msg: .asciiz "\nDigite um Índice Entre 0 e 4: "
	erro: .asciiz "\nÍndice Inválido. Tente Novamente :( " 
	
# Seção em que as Instruções são Declaradas
.text
main:
	# Impressão da Mensagem Inicial
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg # Carrega a Mensagem ao Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Número Inteiro
	li $v0, 5 # Comando para Leitura de Número Inteiro
	syscall # Faz a Leitura do Número Digitado e Armazena em $v0
	
	move $a0, $v0 # Move o Número Lido para o Registrador $a0
	li $s0, 5 # Carrega o Número 5 em $s0 (Será Usado em Comparações Futuras)

# Seção para Validação da Entrada
valida_entrada:
	# Seção que Verifica se os Limites do Vetor Foram Ultrapassados
	bltz $a0, invalido # Se Número Lido < 0, Vá Para a Seção 'Inválido'
	# Caso Contrário
	bge $a0, $s0, invalido # Se Número Lido >= 5, Vá Para a Seção 'Inválido'
	# Caso Contrário
	j vetor

# Invalida a Entrada e Solicita Outro Número Inteiro
invalido:
	# Impressão de Mensagem de Erro
	li $v0, 4 # Comando Para Impressão de String
	la $a0, erro # Carrega a Mensagem de Erro ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão de Mensagem Inicial
	li $v0, 4 # Comando Para Impressão de String
	la $a0, msg # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de um Número Inteiro
	li $v0, 5 # Comando Para Leitura de Inteiro
	syscall # Lê o Número Digitado e Armazena no Registrador $v0
	
	move $a0, $v0 # Move o Número Lido ao Registrador $a0
	j valida_entrada # Volta para Validar Entrada

# Obtém o Número do Índice Correspondente	
vetor:
	la $t0, array # Carrega o Endereço do Vetor ao Registrador $t0
	move $t1, $a0 # Move o Número Lido Para o Registrador $t1
	sll $t1, $t1, 2# Multiplica o Valor de $t1 por 4 e Armazena em $t1
	add $t1, $t0, $t1 # Soma o Endereço Base e o Índice Digitado
	lw $t2, 0($t1) # Armazena o Valor Correspondente do Índice em $t2
	
# Imprime o Resultado e Encerra o Programa
encerra:
	# Imprime o Elemento do Vetor
	li $v0, 1 # Comando para Impressão de Inteiro
	la $a0,($t2) # Carrega o Valor de $t2 para o Registrador $a0
	syscall # Imprime o Número na Tela
	
	# Encerra o Programa
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
	# :)
	
	
