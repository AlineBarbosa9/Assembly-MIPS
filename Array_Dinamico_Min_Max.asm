# Seção em que os Dados São Declarados
.data
	# Mensagens que Serão Exibidas Para o Usuário
	msg:    .asciiz "\nDigite a Quantidade de Pessoas: "
	input:  .asciiz "\nDigite as Idades: "
	menor:  .asciiz "\nMenor: "
	maior:  .asciiz "\nMaior: "

# Seção em que as Instruções São Declaradas
.text

# Função Principal
.main:
	# Exibe Mensagem Para Inserir Quantidade de Pessoas
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg # Carrega a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela

	# Leitura do Número de Pessoas
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Número Inteiro
	move $s0, $v0 # Move o Número Lido ao Registrador $s0
	
	# $s0 = Quantidade de Pessoas

	# Calcula Espaço Necessário: n * 4 Bytes
	li $t1, 4 # Carrega o Valor 4 ao Registrador $t1
	mul $a0, $s0, $t1 # Calcula a Memória Necessária
	# O Argumento Será Armazenado no Registrador $a0

	# Aloca Memória Dinâmica
	li $v0, 9 # Comando Para Alocação de Memória
	syscall # Aloca a Memória Necessária
	move $s1, $v0        # $s1 = Ponteiro para Endereço Inicial
	move $t2, $s1        # $t2 = Ponteiro Atual Para Escrita

	# Mensagem para Digitar Idades
	li $v0, 4 # Comando para Impressão de String
	la $a0, input # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela

	# Loop de Leitura das Idades
	li $t0, 0 # $t0 -> Índice i = 0

# Loop Para Leitura das Idades
leitura_loop:
	
	beq $t0, $s0, fim_leitura # Se i == Tamanho, Encerre o Loop

	# Leitura Da Idade
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena em $v0
	move $t3, $v0 # $t3 = Idade Lida

	# Armazena Idade Na Memória
	sw $t3, 0($t2) # Armazena Idade em Array[i]
	addi $t2, $t2, 4 # Avança Ponteiro (Int Ocupa 4 Bytes)

	# Se For a Primeira Idade, Define Minímo e Máximo
	beq $t0, $zero, init_minmax # Desvio

	# Compara com Mínimo
	blt $t3, $s2, atualiza_min # Desvio Para Atualização do Menor

	# Compara com Máximo
	bgt $t3, $s3, atualiza_max # Desvio Para Atualização do Maior

# Controle do Loop
next:
	addi $t0, $t0, 1 # Incrementa o Índice i++
	j leitura_loop # Retorna ao Loop

# Inicializa Maior e Menor Inicial (Primeiro Elemento do Vetor)
init_minmax:
	move $s2, $t3    # Menor
	move $s3, $t3    # Maior
	j next # Vá Para Controle do Loop

# Atualiza o Valor Mínimo
atualiza_min:
	move $s2, $t3 # Troca 
	j next # Vá Para Controle do Loop

# Atualiza o Valor Máximo
atualiza_max:
	move $s3, $t3 # Troca
	j next # Vá Para Controle do Loop

# Exibição de Valores e Encerra o Programa
fim_leitura:
	# Exibe Mensagem Menor Idade
	li $v0, 4 # Comando Para Impressão de String
	la $a0, menor # Carrega a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Exibe a Menor Idade
	li $v0, 1 # Comando Para Impressão de Inteiro
	move $a0, $s2 # Move a Idade ao Registrador $a0
	syscall # Imprime a Menor Idade

	# Exibe Mensagem Maior Idade
	li $v0, 4 # Comando Para Impressão de String
	la $a0, maior # Move a Mensagem no Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Exibe a Maior Idade
	li $v0, 1 # Comando Para Impressão de Inteiro
	move $a0, $s3 # Move a Idade ao Registrador $a0
	syscall # Imprime a Maior Idade

	# Encerrar o Programa
	li $v0, 10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa
	
	#:)
