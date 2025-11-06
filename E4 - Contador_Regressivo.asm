.data
	msg: .asciiz "\nDigite um Número Positivo Qualquer: "
	valid: .asciiz "\n Número Inválido. Tente Novamente :( "
	pula: .asciiz "\n"
.text
	# Impressão da Mensagem Inicial
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg # Transfere a Mensagem ao Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Número Inteiro
	li $v0, 5 # Comando para Impressão de Inteiro
	syscall # Lê o Número Inteiro e Armazena no Registrador v0
	move $s0, $v0 # Transfere o Valor de v0 Para o Registrador s0
	
	blez $s0, valida # Caso Inteiro Seja Menor ou Igual a Zero, Vá Para Valida
	# Branch if Less Than or Equal to Zero
	# Caso Contrário
	j cont # Vá Para o Contador
	
valida:
	# Impressão da Mensagem de Validação
	li $v0, 4 # Comando para Impressão de String
	la $a0, valid # Transfere a Mensagem ao Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Número Inteiro
	li $v0, 5 # Comando para Impressão de Inteiro
	syscall # Lê o Número Inteiro e Armazena no Registrador v0
	move $s0, $v0 # Transfere o Valor de v0 Para o Registrador s0
	blez $s0, valida # Se Valor Lido Menor ou Igual a 0, Retorne ao Valida

cont:
	bltz $s0, final # Se o Número For Menor que Zero, Vá para o Final
	# Caso Contrário
	
	# Impressão do Contador
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0,$s0 # Move a Variável para o Registrador a0
	syscall # Imprime o Contador
	
	# Impressão do "\n":
	li $v0, 4 # Comando para Impressão de String
	la $a0, pula # Transfere a String para o Registrador a0
	syscall # Imprime a String na Tela
	
	# Decremento do Contador
	subi $s0,$s0, 1 # Subtrai um do Contador
	j cont # Volte para o Início da Função cont

# Função que Encerra o Programa
final:
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
	
	
	
