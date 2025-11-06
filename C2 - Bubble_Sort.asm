# Algoritmo do Bubble Sort em um Array Dinâmico

# Sessão em que os dados são declarados
.data
	# Mensagens que serão Exibidas Para o Usuário
	msg_digita: .asciiz "\nDigite o Elemento do Vetor: "
	msg_ordenado: .asciiz "\nVetor Ordenado: "
	esp: .asciiz " "
	comp: .asciiz "\nNúmero de Comparações: "
	troc: .asciiz "\nNúmero de Trocas: "
	qtd_N_msg: .asciiz "Digite a quantidade de números (max 15): "
	valido_msg: .asciiz "Número Válido."
	invalido_msg: .asciiz "Número inválido (<= 0)."
	erro_excede: .asciiz "\nTamanho do vetor excedido."
	
# Sessão em que as instruções são declaradas
.text

# Função Principal
main:
	# Registradores Utilizados:
	
	# Registrador $t0 = Tamanho do Vetor
	# Registrador $t1 = Número Atual
	# Registrador $t2 = Próximo Número
	# Registrador $t3 = Temporário Para Realizar Trocas
	# Registrador $t4 = Endereço do Próximo Elemento
	# Registrador $t5 = Tamanho - 1 (Limite Do Laço Inferior)
	# Registrador $t6 = Auxiliar Para Calculo de Endereço nos Loops
	# Registrador $t7 = Endereço do numero atual do vetor
	# Registrador $s0 = Contador de Comparações
	# Registrador $s1 = Endereço Inicial do Vetor
	# Registrador $s2 = preenchimento do vetor
	# Registrador $s3 = Indice j
	# Registrador $s4 = Contador Troca
	# Registrador $s5 = indice i
	
	move $s0, $zero # Inicializa com 0
	move $s2, $zero # Inicializa com 0
	move $s3, $zero # Inicializa com 0
	move $s4, $zero # Inicializa com 0
	move $s5, $zero # Inicializa com 0

# Função para validar o número de elementos	
validar:
	li $v0, 4 # Código para imprimir mensagemm
	la $a0, qtd_N_msg # Chamada da mensagem qtd_N_msg
	syscall

	li $v0, 5 # Código para ler um inteiro
	syscall
	move $t0, $v0 # Move o valor para t0
	bgt $t0, 15, excedido # Se igual a 15, vai para label erro_excede (excede valor máximo)
	blez $t0, erro_valor # Se menor ou igual a zero, vai para label erro_valor (valor invalido)
	
	j alocacao_dinamica # Pula para label alocacao_dinamica, continuando o código

# Função para Alocar de forma Dinâmica
alocacao_dinamica:
	move $t7, $t0 # Move o valor de t0 para t7
	mul $a0, $t0, 4 # Calcula o número de bytes (n * 4)
	li $v0, 9 # Código sbrk de alocação dinamica em memória (malloc)
	syscall
	move $s1, $v0 # Move valor de v0 para s1

	addi $t5, $t7, -1 # Definição para o loop tamanho - 1
	
preenche_vetor:
	beq $s2, $t0, bubble_sort # Se s2 for igual a t0, vai para o lable bubble_sort
	li $v0, 4 # Código de carregar string
	la $a0, msg_digita # Imprime a mensagem msg_digita
	syscall
	
	li $v0, 5 # Código para ler inteiro (preenche o vetor)
	syscall
	move $t1, $v0 # Move para t1
	
	sll $t6, $s2, 2 # Desloca o indice em 4 bytes (int = 4 bytes)
	add $t4, $s1, $t6 # Soma endereço do vetor com o deslocamento e salva no endereço do proximo
	sw $t1, 0($t4) # Armazena o valor na memoria 
	
	addi $s2, $s2, 1 # Incrementa o indice do loop e para quando indice = tamanho
	j preenche_vetor # Pula para o label preenche_vetor (loop)

erro_valor:
	li $v0, 4 # Código para imprimir string
	la $a0, invalido_msg # Imprime a mensagem invalido_msg
	syscall
	j fim # Pula para o fim do programa e encerra
	
excedido:
	li $v0, 4 # Código para imprimir string
	la $a0, erro_excede # Imprime a mensagem erro_excede
	syscall
	j  fim # Pula para o fim do programa e encerra
	
# Algoritmo de Bubble-Sort
bubble_sort:
	move $s3, $zero   # Reinicia o índice j (interno)
	# Laço externo (indice i)
	beq $s5,$t0,fim_bubble # Se i == Tamanho, Finalize o Loop
	bubble:
	# Laço Interno (indice j)
		beq $s3, $t5, fim_it # Se j == Tamanho - 1, Finalize Segundo Loop
		addi $s0, $s0, 1 # Incrementa a Variável de Comparações

		# Calcula os Endereços para $s1 e $t4 Baseados Em j
		sll $t6, $s3, 2       # $t6 = j * 4 (Será Incrementado no Endereço)
		add $t7, $s1, $t6     # $t7 = Endereço Inicial + j*4($t6)
		addi $t6, $t6, 4      # Incrementa o indice (Para Elemento [j+1])
		add $t4, $s1, $t6     # $t4 = Endereço Inicial + (j+1)*4
		
		# Obteção de Valores e Comparação de Elementos do Array
		lw $t1, 0($t7) # Carrega o Elemento Atual ao Registrador $t1
		lw $t2, 0($t4) # Carrega o Próximo Elemento no Registrador
		bgt $t1, $t2, troca # Se Array[j] > Array[j+1], Faça a Troca

		addi $s3,$s3,1 # Incrementa o indice 
		j bubble # Retorna ao Laço Interno (indice j)
	
# Reinicia o Loop Interno
fim_it:
	move $s3, $zero # Reinicia o indice j
	addi $s5, $s5, 1 # Incrementa o indice i
	j bubble_sort # Volte ao Bubble_Sort

troca:
	move $t3,$t2 # Armazena o Menor Valor num Registrador Temporário ($t3)
	move $t2,$t1 # Transfere o Maior Valor Para $t2
	move $t1,$t3 # Transfere o Menor Calor Para $t1
	sw $t1, 0($t7)# Salva o Valor Menor na Posição Atual do Array
	sw $t2, 0($t4)# Salva o Valor Maior na Próxima Posição do Array
	addi $s4,$s4,1 # Incrementa o Contador de Trocas
	j bubble # Volte ao Laço Interno (indice j)

# Finaliza o Algoritmo de Bubble Sort
fim_bubble:
	move $s5, $zero # Reinicia o indice i Para 0
	move $s3, $zero  # Reinicia índice j
	move $t7, $s1 #reinicia indice do vetor
	j imprime_vetor   # Vai imprimir o vetor ordenado

# Faz a ImpressÃ£o do Vetor Ordenado
imprime_vetor:
	beq $s5,$t0,final # Se i == Tamanho, Vai Para o Final
	lw $t2, 0($t7) # Carregue o Elemento do Array[i] em $t2
	
	# Impressão do Elemento do Array
	li $v0,1 # Comando Para Impressão de Inteiro
	move $a0,$t2 #move o valor do proximo número para ser impresso
	syscall # Imprime o Numero na Tela
	
	# Impressão do Espaço Entre Elementos
	li $v0,4 # Comando Para Impressão de String
	la $a0,esp # Move a String ao Registrador $a0
	syscall # Imprime o Espaço Entre os Numeros
	
	# Condicionais e Retorno ao Loop
	addi $s5,$s5,1 # Incrementa o indice i
	addi $t7,$t7,4 # Incrementa o Endereço de Memória 
	j imprime_vetor #pula para label imprime_vetor

# Exibe Comparações e Trocas e Finaliza o Programa	
final:
	# ImpressÃ£o da Mensagem do Numero de Comparações
	li $v0,4 # Comando Para Impressão de String
	la $a0,comp # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão do Numero de Comparações
	li $v0,1 # Comando Para Impressão de Inteiro
	move $a0,$s0 # Move o Numero de Comparações ao Registrador $a0
	syscall # Imprime o Numero na Tela
	
	# Impressão da Mensagem do Numero de Trocas
	li $v0,4 # Comando Para Impressão de String
	la $a0,troc # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão do Numero de Trocas
	li $v0,1 # Comando Para Impressãoo de Inteiro
	move $a0,$s4 # Move o Numero de Trocas ao Registrador $a0
	syscall # Imprime o Numero na Tela
	
fim:
	# Encerra o Programa
	li $v0,10 # Comando Para Encerrar o Programa
	syscall # Encerrra o Programa
	
