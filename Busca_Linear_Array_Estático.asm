# Seção em Que Os Dados São Declarados
.data
	array: .word 47, 12, 88, 3, 59, 76, 25, 91, 34, 68
	msg: .asciiz "\nDigite um Número Para Ser Procurado: "
	ind: .asciiz "\nÍndice: "

# Seção em Que As Instruções São Declaradas
.text
	# Impressão da Mensagem
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	syscall # Faz a Leitura do Número Inteiro Digitado
	
	move $s1,$v0 # Carrega o Conteúdo de $v0 Para $s1 (Valor de Busca)
	la $s0, array # Carregue o Endereço do Array no Registrador $s0
	move $t0, $zero # Carregue o Valor 0 no Registrador $t0 (Índice)

# Seção Que Faz a Busca Linear
loop:
	beq $t0,11,nao_encontrado # Se Índice Igual a 11, Vá Para 'nao_encontrado'
	# Caso Contrário
	sll $t1, $t0, 2 # Multiplica o Índice por 4 e Armazene em $t1
	add $t1,$t1,$s0 # Soma o Índice com o Endereço do Array
	lw $t2, 0($t1) # Carrega o Conteúdo do Índice $t1 do Vetor em $t2
	beq $t2,$s1,encontrado # Se Valor Atual For Igual ao Buscado, Vá Para 'encontrado'
	# Caso Contrário
	addi $t0,$t0,1 # Incrementa o Índice do Vetor
	j loop # Volte ao Loop

# Caso o Valor Seja Encontrado
encontrado:
	move $s2, $t0 # Move o Valor do Índice ao Registrador $s2
	j final # Vá Para o Final 

# Caso o Valor Não Seja Encontrado
nao_encontrado:
	li $s2, -1 # Armazena -1 no Registrador $s2
	j final # Vá Para o Final

final:
	# Impressão da Mensagem
	li $v0, 4 # Comando para Impressão de String
	la $a0, ind # Carrega a Mensagem ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão de Inteiro
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0,$s2 # Move o Resultado ao Registrador $a0
	syscall # Imprime o Inteiro na Tela
	
	# Encerra o Programa
	li $v0, 10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa
	


	
	
	