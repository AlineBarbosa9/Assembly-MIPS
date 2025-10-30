# Programa em Assembly MIPS que Faz a Leitura de um Inteiro N
# Digitado Pelo Usuário, Faz a Alocação Dinâmica de Memória
# e Imprime a Sequência de 0 a N - 1 Para o Usuário.

# Sessão em que os Dados são Declarados
.data
	# Mensagens Que Serão Exibidas Para o Usuário
	input: .asciiz "\nDigite o Tamanho da Sequência: "
	erro: .asciiz "\nNúmero Inválido. Tente Novamente "
	output: .asciiz "\n Sequência de N Números: "
	esp: .asciiz " "

# Sessão em que as Instruções São Declaradas
.text

# Função Principal
.main:
	# Impressão de Mensagem Inicial
	li $v0,4 # Comando para Impressão de String
	la $a0,input # Carrega o Endereço de Memória da String ao Registrador $a0
	syscall # Imprime a Mensagem Inicial na Tela do Usuário
	
	# Leitura do Tamanho da Sequência
	li $v0,5 # Comando par Leitura de Inteiro
	syscall # Obtém o Inteiro Via Teclado
	move $t0,$v0 # Move o Inteiro Lido ao Registrador $t0
	blez $t0,valida # Se $t0 <= 0, Faça a Validação da Entrada
	
	# Cálculo para Alocação Dinâmica
	sll $t1,$t0,2 # Multiplica o Tamanho da Sequência por 4 e Salva em $t1
	
	# Alocação Dinâmica
	li $v0,9 # Código Para Alocação de Memória
	move $a0,$t1 # Move a Quantidade de Bytes ao Registrador $a0
	syscall # Aloca a Memória e Salva em $v0
	
	# Preparação de Chamada de Função Para Criação de Sequência
	move $a0, $v0 # Transfere o Endereço Inicial do Vetor ao Registrador $a0
	move $s0, $a0 # Move o Endereço Inicial Para o Registrador $s0
	move $s1,$s0 # Cópia do Endereço Inicial
	move $s2, $s0 # Cópia do Endereço Inicial
	move $t1, $zero # Registrador $t1 Vale 0 (Número da Sequência)
	jal criar_sequencia # Vá Para a Criação de Sequência
	
	# Impressão de Mensagem
	li $v0,4 # Comando para Impressão de String
	la $a0, output # Move o Endereço da String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Preparação Para Chamada de Função de Impressão
	move $t1,$zero # Reinicia o Registrador $t1
	jal funcao_imprime # Vá para a Impressão dos Valores
	
	# Encerra o Programa
	li $v0, 10 # Código Para Encerrar o Programa
	syscall # Encerra o Programa
	
	
# Função para Validar o Tamanho da Sequência
valida:
	# Impressão de Mensagem de Erro
	li $v0,4 # Comando para Impressão de String
	la $a0,erro # Carrega o Endereço de Memória da String ao Registrador $a0
	syscall # Imprime a Mensagem de Erro na Tela
	j .main # Volte ao Main

# Função para Criar Sequência de 0 a N-1
criar_sequencia:
	beq $t1,$t0,encerra_sequencia # Se Valor Atual == Tamanho do Vetor, Saia da Função
	# Caso Contrário
	sw $t1,0($s1) # Salva o Número da Sequência no Endereço Atual do Array
	addi $s1,$s1, 4 # Incrementa o Endereço de Memória (Índice++)
	addi $t1,$t1, 1 # Incremnta o Valor Atual da Sequência
	j criar_sequencia # Volte ao Loop

# Controle Para Retorno ao Main
encerra_sequencia:
	move $v0,$s2 # Retorna o Endereço Inicial do Array
	jr $ra # Retorna Para Quem Chamou

# Função Para Impressão dos Elementos do Array
funcao_imprime:
	beq $t1, $t0, encerra_imprime # Se $t1 == Tamanho do Vetor, Saia da Função
	# Caso Contrário
	lw $t2, 0($s0) # Armazena o Elemento Vetor[i] no Registrador $t2
	addi $s0,$s0,4 # Incrementa o Endereço de Memória Para Próximo Elemento(+4)
	addi $t1, $t1, 1 # Incrementa a Quantidade de Loops
	
	# Impressão de Inteiro
	li $v0,1 # Comando para Impressão de Inteiro
	move $a0, $t2 # Move o Elemento do Array ao Registrador $a0
	syscall # Faz a Impressão do Elemento do Array
	
	# Impressão de Espaço
	li $v0,4 # Comando para Impressão de String
	la $a0,esp # Move a o Endereço da String ao Registrador $a0
	syscall # Imprime o Espaço Entre os Elementos
	j funcao_imprime # Volte ao Loop

# Controle Para Retorno ao Main
encerra_imprime:
	jr $ra # Retorna Para Quem Chamou


	
	
	