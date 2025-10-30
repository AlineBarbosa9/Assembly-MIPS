#Nome: Aline Barbosa Vidal RA: 10721348
#Nome: Beatriz Ferreira Vianna RA: 10729512
#Nome: Kau� Lima Rodrigues Meneses RA: 10410594
#Nome: Theo Esposito Simoes Resende RA: 10721356


# sess�o em que os dados s�o declarados
.data
	# Mensagens que ser�o Exibidas Para o Usu�rio
	msg_digita: .asciiz "\nDigite o Elemento do Vetor: "
	msg_ordenado: .asciiz "\nVetor Ordenado: "
	esp: .asciiz " "
	comp: .asciiz "\nN�mero de Compara��es: "
	troc: .asciiz "\nN�mero de Trocas: "
	qtd_N_msg: .asciiz "Digite a quantidade de n�meros (max 15): "
	valido_msg: .asciiz "N�mero V�lido."
	invalido_msg: .asciiz "N�mero inv�lido (<= 0)."
	erro_excede: .asciiz "\nTamanho do vetor excedido."
	
# Sess�o em que as instru��es s�o declaradas
.text

# Fun��o Principal
main:
	# Registradores Utilizados:
	
	# Registrador $t0 = Tamanho do Vetor
	# Registrador $t1 = N�mero Atual
	# Registrador $t2 = Pr�ximo N�mero
	# Registrador $t3 = Tempor�rio Para Realizar Trocas
	# Registrador $t4 = Endere�o do Pr�ximo Elemento
	# Registrador $t5 = Tamanho - 1 (Limite Do La�o Inferior)
	# Registrador $t6 = Auxiliar Para Calculo de Endere�o nos Loops
	# Registrador $t7 = Endere�o do numero atual do vetor
	# Registrador $s0 = Contador de Compara��es
	# Registrador $s1 = Endere�o Inicial do Vetor
	# Registrador $s2 = preenchimento do vetor
	# Registrador $s3 = Indice j
	# Registrador $s4 = Contador Troca
	# Registrador $s5 = indice i
	
	move $s0, $zero # Inicializa com 0
	move $s2, $zero # Inicializa com 0
	move $s3, $zero # Inicializa com 0
	move $s4, $zero # Inicializa com 0
	move $s5, $zero # Inicializa com 0

#fun�ao para validar o n�mero de elementos	
validar:
	li $v0, 4 #c�digo para imprimir mensagemm
	la $a0, qtd_N_msg #chamada da mensagem qtd_N_msg
	syscall

	li $v0, 5 #c�digo para ler um inteiro
	syscall
	move $t0, $v0 #move o valor para t0
	bgt $t0, 15, excedido #se igual a 15, vai para label erro_excede (excede valor m�ximo)
	blez $t0, erro_valor #se menor ou igual a zero, vai para label erro_valor (valor invalido)
	
	j alocacao_dinamica #pula para label alocacao_dinamica, continuando o c�digo

#fun��o para alocar de forma dinamica
alocacao_dinamica:
	move $t7, $t0 #move o valor de t0 para t7
	mul $a0, $t0, 4 #calcula o n�mero de bytes (n * 4)
	li $v0, 9 #c�digo sbrk de aloca��o dinamica em mem�ria (malloc)
	syscall
	move $s1, $v0 #move valor de v0 para s1

	addi $t5, $t7, -1 #defini��o para o loop tamanho - 1
	
preenche_vetor:
	beq $s2, $t0, bubble_sort #se s2 for igual a t0, vai para o lable bubble_sort
	li $v0, 4 #c�digo de carregar string
	la $a0, msg_digita #imprime a mensagem msg_digita
	syscall
	
	li $v0, 5 #codigo para ler inteiro (preenche o vetor)
	syscall
	move $t1, $v0 #move para t1
	
	sll $t6, $s2, 2 #desloca o indice em 4 bytes (int = 4 bytes)
	add $t4, $s1, $t6 #soma endere�o do vetor com o deslocamento e salva no endere�o do proximo
	sw $t1, 0($t4) #armazena o valor na memoria 
	
	addi $s2, $s2, 1 #incrementa o indice do loop e para quando indice = tamanho
	j preenche_vetor #pula para o label preenche_vetor (loop)

erro_valor:
	li $v0, 4 #codigo para imprimir string
	la $a0, invalido_msg #imprime a mensagem invalido_msg
	syscall
	j fim #pula para o fim do programa e encerra
	
excedido:
	li $v0, 4 #codigo para imprimir string
	la $a0, erro_excede #imprime a mensagem erro_excede
	syscall
	j  fim #pula para o fim do programa e encerra
	
# Algoritmo de Bubble-Sort
bubble_sort:
	move $s3, $zero   # Reinicia o �ndice j (interno)
	# La�o externo (indice i)
	beq $s5,$t0,fim_bubble # Se i == Tamanho, Finalize o Loop
	bubble:
	# La�o Interno (indice j)
		beq $s3, $t5, fim_it # Se j == Tamanho - 1, Finalize Segundo Loop
		addi $s0, $s0, 1 # Incrementa a Vari�vel de Compara��es

		# Calcula os Endere�os para $s1 e $t4 Baseados Em j
		sll $t6, $s3, 2       # $t6 = j * 4 (Ser� Incrementado no Endere�o)
		add $t7, $s1, $t6     # $t7 = Endere�o Inicial + j*4($t6)
		addi $t6, $t6, 4      # Incrementa o indice (Para Elemento [j+1])
		add $t4, $s1, $t6     # $t4 = Endere�o Inicial + (j+1)*4
		
		# Obte��o de Valores e Compara��o de Elementos do Array
		lw $t1, 0($t7) # Carrega o Elemento Atual ao Registrador $t1
		lw $t2, 0($t4) # Carrega o Pr�ximo Elemento no Registrador
		bgt $t1, $t2, troca # Se Array[j] > Array[j+1], Fa�a a Troca

		addi $s3,$s3,1 # Incrementa o indice 
		j bubble # Retorna ao La�o Interno (indice j)
	
# Reinicia o Loop Interno
fim_it:
	move $s3, $zero # Reinicia o indice j
	addi $s5, $s5, 1 # Incrementa o indice i
	j bubble_sort # Volte ao Bubble_Sort

troca:
	move $t3,$t2 # Armazena o Menor Valor num Registrador Tempor�rio ($t3)
	move $t2,$t1 # Transfere o Maior Valor Para $t2
	move $t1,$t3 # Transfere o Menor Calor Para $t1
	sw $t1, 0($t7)# Salva o Valor Menor na Posi��o Atual do Array
	sw $t2, 0($t4)# Salva o Valor Maior na Pr�xima Posi��o do Array
	addi $s4,$s4,1 # Incrementa o Contador de Trocas
	j bubble # Volte ao La�o Interno (indice j)

# Finaliza o Algoritmo de Bubble Sort
fim_bubble:
	move $s5, $zero # Reinicia o indice i Para 0
	move $s3, $zero  # Reinicia �ndice j
	move $t7, $s1 #reinicia indice do vetor
	j imprime_vetor   # Vai imprimir o vetor ordenado

# Faz a Impressão do Vetor Ordenado
imprime_vetor:
	beq $s5,$t0,final # Se i == Tamanho, Vai Para o Final
	lw $t2, 0($t7) # Carregue o Elemento do Array[i] em $t2
	
	# Impress�o do Elemento do Array
	li $v0,1 # Comando Para Impress�o de Inteiro
	move $a0,$t2 #move o valor do proximo n�mero para ser impresso
	syscall # Imprime o Numero na Tela
	
	# Impress�o do Espa�o Entre Elementos
	li $v0,4 # Comando Para Impress�o de String
	la $a0,esp # Move a String ao Registrador $a0
	syscall # Imprime o Espa�o Entre os Numeros
	
	# Condicionais e Retorno ao Loop
	addi $s5,$s5,1 # Incrementa o indice i
	addi $t7,$t7,4 # Incrementa o Endere�o de Mem�ria 
	j imprime_vetor #pula para label imprime_vetor

# Exibe Compara��es e Trocas e Finaliza o Programa	
final:
	# Impressão da Mensagem do Numero de Compara��es
	li $v0,4 # Comando Para Impress�o de String
	la $a0,comp # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impress�o do Numero de Compara��es
	li $v0,1 # Comando Para Impress�o de Inteiro
	move $a0,$s0 # Move o Numero de Compara��es ao Registrador $a0
	syscall # Imprime o Numero na Tela
	
	# Impress�o da Mensagem do Numero de Trocas
	li $v0,4 # Comando Para Impress�o de String
	la $a0,troc # Move a String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impress�o do Numero de Trocas
	li $v0,1 # Comando Para Impress�oo de Inteiro
	move $a0,$s4 # Move o Numero de Trocas ao Registrador $a0
	syscall # Imprime o Numero na Tela
	
fim:
	# Encerra o Programa
	li $v0,10 # Comando Para Encerrar o Programa
	syscall # Encerrra o Programa
	