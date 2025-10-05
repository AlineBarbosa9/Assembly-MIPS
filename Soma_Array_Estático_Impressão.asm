# Seção Em que Os Dados São Declarados
.data
	array: .word 20,30,55,51,64,95 # Declaração do Array Fixo

# Seção Em que As Instruções Serão Declaradas
.text
	la $s0,array # Carrega o Endereço Do Array Declarado no Registrador $s0
	li $s1,6 # Carrega o Tamanho do Vetor ao Registrador $a0
	li $t0,0 # Carrega o Valor 0 ao Registrador $t0 (Acumulador de Soma)
	li $t1,0 # Carrega o Valor 0 ao Registrador $t1 (Índice)

# Seção que Vai Somar Todos os Elementos do Array Declarado
somatorio:
	beq $t1,6,fim # Se Índice do Vetor ($t1) for Igual a 5, Vá Para 'fim'
	# Caso Contrário
	move $t2,$t1 # Mova o Conteúdo de $t1 para $t2
	sll $t2,$t2,2 # Multiplica o Índice Por 4 (Tamanho de um Inteiro)
	add $t2, $s0, $t2 # Obtém o Endereço de Memória do Índice Correspondente
	lw $t3,0($t2) # Carregue o Elemento do Índice no Registrador $t3
	add $t0,$t0,$t3 # Soma o Elemento ao Acumulador de Soma (Registrador $t0)
	addi $t1,$t1,1 # Incrementa o Índice(de 0 a 4)
	j somatorio # Volte ao 'somatorio'
	
# Seção que Imprime o Resultado e Finaliza o Programa
fim:
	# Impressão do Resultado Obtido
	li $v0,1 # Comando para Impressão de Inteiro
	move $a0,$t0 # Move o Conteúdo do Acumulador ao Registrador $a0
	syscall # Imprime o Resultado na Tela
	
	# Encerra o Programa
	li $v0, 10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa
	
	