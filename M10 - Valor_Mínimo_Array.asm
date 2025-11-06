# Seção em Que Os Dados São Declarados
.data
	array: .word 68,70,75,83,78,15,25,38,45,10 # Declaração de Array Estático


# Seção em Que as Instruções São Declaradas
.text
	
	la $t0,array # Carrega o Endereço de Memória do Array Para o Registrador $t0
	li $t1,10 # Carrega o Tamanho do Vetor ao Registrador $t1
	
	# Prepara Os Registradores Para A Chamada de Função
	move $a0, $t0 # Carrega o Endereço do Array Para o Registrador $a0
	move $a1, $t1 # Carrega o Tamanho do Array Para o Registrador $a1
	jal encontrar_min # Chama a Função 'encontrar_min'
	
	# Impressão de Resultado
	move $s1,$v0 # Move o Resultado ao Registrador $s1
	li $v0, 1 # Comando Para Impressão de Inteiro
	move $a0, $s1 # Move o Resultado ao Registrador $a0
	syscall # Imprime o Resultado na Tela
	
	# Encerra o Programa
	li $v0, 10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa

# Função que Encontra o Menor Valor do Array
encontrar_min:
	# Inicialmente, Assume-se Que o Primeiro Valor É o Menor
	li $t2, 0 # Carrega o Valor 0 Ao Registrador $t2 (Índice)
	lw $t4,0($a0) # Carrega o Valor do Índice 0 no Registrador $t4
	addi $t2,$t2,1 # Incrementa o Índice
compara:
	# Condicional Para Parada de Função
	beq $t2,10,final_encontra # Se Índice For Maior que 11, Vá Para 'final_encontra'
	# Caso Contrário
	move $t5,$t2 # Mova o Valor do Índice ao Registrador $t5
	move $t3,$zero # Mova o Valor 0 para o Registrador $t3
	
	# Manipulação de Endereço de Elemento do Array
	sll $t5,$t5,2 # Multiplica o Índice por 4
	add $t3, $t5,$a0 # Soma o Endereço Atual com o Índice
	lw $t5,0($t3) # Carrega o Valor Correspondente ao Índice no Registrador $t5
	addi $t2,$t2,1 # Incrementa o Índice
	
	blt $t5,$t4, troca # Se $t5 < Menor Valor Atual, Faz a Troca
	# Caso Contrário
	j compara # Volta ao Loop Compara
	
# Faz a Troca do Menor Valor Encontrado e Menor Valor Atual
troca:
	move $t4,$t5 # Faz a Troca
	j compara # Volte para o Compara

# Final da Função e Retorno
final_encontra:
	move $v0,$t4 # Move o Resultado ao Registradpr $v0
	jr $ra # Volta Para Quem Chamou
	
	
	
	

