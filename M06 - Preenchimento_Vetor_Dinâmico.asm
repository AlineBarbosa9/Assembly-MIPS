# Seção em Que os Dados São Declarados
.data
	# Mensagens que Serão Exibidas para o Usuário
	msg: .asciiz "\nDigite o Tamanho do Vetor: "
	erro: .asciiz "\nErro, Número Inválido. Digite Outro Número: "
	input: .asciiz "\nDigite os Elementos do Vetor: "
	esp: .asciiz " "

# Seção em Que as Instruções São Declaradas
.text

# Função Principal
.main:
	# Impressão da Mensagem Inicial
	li $v0,4 # Comando para Impressão de String
	la $a0,msg # Carrega a Mensagem no Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Inteiro
	li $v0,5 # Comando para Leitura de Número Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena em $v0
	move $t0,$v0 # Move o Número Lido Para o Registrador $t0
	blez $t0,valida # Se Tamanho do Vetor < 0, Faça a Validação

aloca:
	
	# Cálculo Para Alocação de Memória
	li $t1,4 # Carrega no Registrador $t1 o Tamanho de um Inteiro
	mul $a0,$t0,$t1 # Multiplica N * 4 e Armazena em $a0
	
	# Alocação de Memória 
	li $v0, 9 # Comando para Alocação de Memória
	syscall # Aloca a Quantidade de Memória Calculada Anteriormente
	move $s0, $v0 # Move o Endereço da Alocação no Registrador $s0
	
	# Impressão de Mensagem
	li $v0, 4 # Comando Para Impressão de String
	la $a0, input # Carrega a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Preparação para Loop
	move $t1, $zero # $t1 Será o Índice
	move $t2, $s0 # Armazena o Endereço Atual do Elemento

# Faz a Leitura dos N Elementos do Vetor 
loop:
	beq $t1,$t0, prepara # Se Índice for Igual ao Tamanho do Vetor, Vá Para 'prepara'
	# Leitura de Um Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Lê o Inteiro e Armazena em $v0
	move $t3, $v0 # Move o Número Lido para o Registrador $t3
	sw $t3,0($t2) # Armazena o Número Lido no Índice $t2
	addi $t1, $t1, 1 # Incrementa o Índice
	addi $t2, $t2, 4 # Incrementa o Endereço de Memória
	j loop # Volte Para o Loop

valida:
	# Impressão de Mensagem de Erro
	li $v0,4 # Comando Para Impressão de String
	la $a0,erro # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Inteiro
	li $v0, 5 # Comando de Leitura de Inteiro
	syscall # Faz a Leitura do Número
	move $t0, $v0 # Move o Tamanho Lido para o Registrador a0
	blez $t0, valida # Se Tamanho < 0 Volte Para Validação
	# Caso Contrário
	j aloca # Vá para Aloca

prepara:
	move $t5,$zero # Índice Inicia em 0
	move $s1,$s0 # Endereço Inicial de Alocação

# Faz a Impressão dos Elementos na Tela
imprime:
	beq $t5, $t0, final # Se Índice == Tamanho do Vetor, Vá Para 'final'
	lw $t4,0($s1) # Carrega o Elemento do Índice no Registrador $t4
	
	# Impressão de Inteiro
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0, $t4 # Move o Elemento a Ser Impresso Para o Registrador $a0
	syscall # Imprime o Elemento do Vetor
	
	# Impressão de Espaço
	li $v0,4 # Comando para Impressão de String
	la $a0, esp # Move a String ao Registrador $a0
	syscall # Imprime a String na Tela
	
	addi $s1, $s1, 4 # Incrementa o Endereço de Memória
	addi $t5, $t5, 1 # Incrementa o Índice
	j imprime # Volte para 'imprime'

# Encerra o Programa
final:
	li $v0, 10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa
	# :)
	
	
	
	
	
	# $t0 - Tamanho do Vetor
	# $t1 - Índice
	# $t2 - Armazena o Endereço Atual do Elemento do Vetor
	# $t3 - Armazena o Número Inteiro Lido
	# $s0 - Endereço Inicial da Alocação de Memória
	# $s1 - Cópia do Registrador $s0
	
	

