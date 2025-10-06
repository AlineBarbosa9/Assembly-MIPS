# Seção Em que Os Dados São Declarados
.data

	# Mensagens que Serão Exibidas ao Usuário
	input: .asciiz "\nDigite o Limiar Desejado: "
	output: .asciiz "\nA Quantidade de Elementos Acima do Limiar É Igual a: "
	
	# Declaração de Array Estático
	array: .word 23,61,81,93,19,33
	
# Seção Em Que As Instruções São Declaradas
.text
	# Impressão da Mensagem
	li $v0,4 # Comando Para Impressão de String
	la $a0,input # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem Na Tela
	
	# Leitura de Inteiro
	li $v0,5 # Comando para Leitura de Número Inteiro
	syscall # Faz a Leitura do Número Inteiro Digitado
	
	# Declaração e Manipulação de Registradores
	move $s0,$v0 # Carrega o Conteúdo de $v0 para $s0
	move $t0,$zero # Carrega o Valor 0 ao Registrador $t0 (Contador)
	la $s1,array # Carregue o Endereço do Array no Registrador $s1
	move $s2,$zero # Carrega o Valor 0 ao Registrador $s2 (Índice)
	
loop:
	beq $s2,6,final # Se Índice For Igual a 6, Vá Para o Final
	# Caso Contrário
	sll $t1, $s2,2 # Multiplica o Índice por 4 e Guarda em $t1
	add $t1, $t1,$s1 # Soma ao Endereço Inicial para Obter o Valor do Índice
	lw $t2,0($t1) # Carrega o Valor do Índice Para $t2
	addi $s2,$s2,1 # Incremente o Valor do Índice
	bgt $t2,$s0,soma # Se Valor For Maior que o Limiar, Vá Para 'soma'
	# Caso Contrário
	j loop # Volte para o Loop

soma:
	addi $t0,$t0,1 # Incremente o Valor do Contador
	j loop # Volte Para o 'loop'


final:	
	# Impressão da Mensagem Final
	li $v0,4 # Comando Para Impressão de String
	la $a0,output # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem Na Tela
	
	# Impressão do Resultado
	li $v0,1 # Comando para Impressão de Inteiro
	move $a0, $t0 # Move o Valor do Contador Para O Registrador $a0
	syscall # Imprime o Número na Tela
	
	# Finaliza o Programa
	li $v0,10 # Comando Para Encerrar Programa
	# Encerra o Programa
	# :)