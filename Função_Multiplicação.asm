# Seção Em que Os Dados São Declarados
.data
	# Mensagens Que Serão Exibidas Para o Usuário
	primeiro: .asciiz "\nDigite o Primeiro Número: "
	segundo: .asciiz "\nDigite o Segundo Número: "
	result: .asciiz "\nO Resultado é Igual a: "

# Seção Em que As Instruções São Declaradas
.text

.main:
	# Impressão de Mensagem
	li $v0, 4 # Comando Para Impressão de String
	la $a0,primeiro # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura do Primeiro Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena no Registrador $v0
	move $t0, $v0 # Move o Inteiro Lido para o Registrador $a0
	
	# Impressão de Mensagem
	li $v0, 4 # Comando Para Impressão de String
	la $a0,segundo # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura do Segundo Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena no Registrador $v0
	move $t1, $v0 # Move o Inteiro Lido para o Registrador $a1
	
	move $a0, $t0 # Move o Conteúdo de $a0 para $t0
	move $a1, $t1 # Move o Contaúdo de $a1 para $t1
	jal multiplica # Chama a Função de Multiplicação

	
	# Impressão da Mensagem de Resultado
	li $v0, 4 # Comando Para Impressão de String
	la $a0, result # Move a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão de Inteiro
	li $v0, 1 # Comando Para Impressão de Inteiro
	move $a0, $s1 # Move o Resultado de $s1 para o Registrador $a0
	syscall # Imprime o Inteiro na Tela
	
	# Encerra o Programa
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
	
# Função Que Realiza a Multiplicação de Dois Números Inteiros
multiplica:
	mul $v0, $a0, $a1 # Multiplica o Valor de $t0 por $t1 e Armazena em $v0
	move $s1, $v0
	jr $ra # Retorna Para Quem Chamou
