# Organização de Computadores:
# Laboratório 01 - Exercício 02: Comparação Entre 3 Inteiros Distintos:
# Integrantes:
# Aline Barbosa Vidal RA: 10721348
# Beatriz Ferreira Vianna RA: 10729512
# Kauê Lima Rodrigues Meneses RA: 10410594
# Theo Espósito Simões Resende RA: 10721356

# Variáveis Usadas no Programa:
.data
	# Mensagens que Serão Exibidas ao Usuário:
	
	# Durante a Leitura das Variáveis
	msg0: .asciiz "Digite Três Números Distintos!\n"
	msg1: .asciiz "Digite o 1º número: "
	msg2: .asciiz "Digite o 2º número: "
	msg3: .asciiz "Digite o 3º número: "
	
	# Após as Operações Realizadas
	menor: .asciiz "\n Menor valor: "
	meio: .asciiz "\n Valor intermediário: "
	maior: .asciiz "\n Maior valor: "

# Contém as Instruções do Programa:
.text

	# Impressão da Mensagem Inicial:
	li $v0, 4 # Comando para Impressão da Mensagem0
	la $a0, msg0 # Carrega a Mensagem0 ao Registrador a0
	syscall # Imprime a Mensagem do Registrador a0
	
	
	# Impressão da Mensagem Para o Primeiro Inteiro:
	li $v0, 4 # Comando para Impressão da Mensagem1
	la $a0, msg1 # Carrega a Mensagem1 ao Registrador a0
	syscall # Imprima a Mensagem do Registrador a0
	
	# Leitura do Primeiro Inteiro:
	li $v0, 5 # Comando para Leitura de um Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena no Registrador v0
	move $t0, $v0 # Move o Inteiro de v0 para o Registrador t0
	
	
	# Impressão da Mensagem Para o Segundo Inteiro:
	li $v0, 4 # Comando para Impressão da Mensagem1
	la $a0, msg2 # Carrega a Mensagem1 ao Registrador a0
	syscall # Imprima a Mensagem do Registrador a0
	
	# Leitura do Segundo Inteiro:
	li $v0, 5 # Comando para Leitura de um Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena no Registrador v0
	move $t1, $v0 # Move o Inteiro de v0 para o Registrador t1
	
	
	# Impressão da Mensagem Para o Terceiro Inteiro:
	li $v0, 4 # Comando para Impressão da Mensagem1
	la $a0, msg3 # Carrega a Mensagem1 ao Registrador a0
	syscall # Imprima a Mensagem do Registrador a0
	
	# Leitura do Terceiro Inteiro:
	li $v0, 5 # Comando para Leitura de um Inteiro
	syscall # Faz a Leitura do Inteiro e Armazena no Registrador v0
	move $t2, $v0 # Move o Inteiro de v0 para o Registrador t2
	
	# Após as Comparações:
	# Registrador t0 - Menor Valor:
	# Registrador t1 - Valor Intermediário
	# Registrador t2 - Maior Valor:
	
	# Primeira Comparação - Registrador t0 e Registrador t1:
	
	bgt $t0, $t1, troca1 # Se t0 > t1, Vá para troca1
	j depois1 # Caso contrário, Vá para depois1
	
	# Função que Troca o Valor de t0 e t1
	# Inicialmente, Supõe que t0 é o Maior Valor
	# Registrador t3 Será uma Variável Temporária e Auxiliar
	troca1:
		move $t3, $t0 # Move o Valor de t0 para Valor t3
		move $t0, $t1 # Move o Valor de t1 para t0
		move $t1, $t3 # Move o Valor de t3 para t1
	
	
	# Segunda Comparação - Registrador t1 e Registrador t2:	
	depois1:
		bgt $t1, $t2, troca2 # Se t1 > t2, Vá para troca2
		j depois2 # Caso Contrário, Vá para depois2
		
	# Função que Troca o Valor de t1 e t2:
	# Registrador t3 Armazenará uma Variável Temporária
	troca2:
		move $t3, $t1 # Move o Valor de t1 para t3
		move $t1, $t2 # Move o Valor de t2 para t1
		move $t2, $t3 # Move o Valor de t3 para t2
		
	# Terceira Comparação - Registrador t0 e Registrador t1:
	depois2:
		# Mais uma Comparação é Realizada:
		# Isso Garante que a Ordenação Estará Correta
		bgt $t0, $t1, troca3 # Se t0 > t1, Vá Para troca3
		j impressao # Caso Contrário, Vá Para impressao
	
	# Realiza a Troca dos Valores dos Registradores t0 e t1
	# Registrador t3 Atua Como Variável Intermediária para Troca
	troca3:
		move $t3, $t0 # Move o Valor de t0 para t3
		move $t0, $t1 # Move o Valor de t1 para t0
		move $t1, $t3 # Move o Valpr de t3 para t1
	
			
	# Função que Imprimirá Inteiros e Strings na Tela do Usuário:
	# Também Encerrará o Programa
	impressao:
	# Impressão da Mensagem " Menor Valor: "
	li $v0, 4 # Comando para Impresão de String
	la $a0, menor # Transfere a Mensagem Menor ao Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão do Menor Inteiro:
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0, $t0 # Move o Menor Valor ao Registrador a0
	syscall # Imprime o Menor Número na Tela
	

	# Imprime Mensagem " Valor Intermediário: "
	li $v0, 4 # Comando para Impressão de String
	la $a0, meio # Transfere a Mensagem Intermediário para o Registrador a0
	syscall # Imprime a Mensagem Intermediário na Tela
	
	# Impressão do Valor Intermediário:
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0, $t1 # Transfere o Valor Intermediário para o Registrador a0
	syscall # Imprime o Valor Intermediário na Tela


	# Imprime a Mensagem " Maior Valor: "
	li $v0, 4 # Comando para Impressão de String
	la $a0, maior # Transfere a String ao Registradore a0
	syscall # Imprime a Mensagem de Maior Valor na Tela
	
	# Impressão do Maior Valor Inteiro:
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0, $t2 # Transfere o Maior Valor ao Registrador a0
	syscall # Imprime o Maior Valor na Tela


	# Finaliza o Programa:
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa


