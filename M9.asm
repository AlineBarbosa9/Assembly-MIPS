# Este Programa Cria uma Lista Ligada e Insere Novos Elementos pelo Cabeça
# Pergunta ao Usuário se Deseja Adicionar Novo Elemento
# Também Imprime a Soma dos Elementos da Lista Ligada

# Seção em que os dados são declarados
.data
	# Mensagens que Serão Exibidas ao Usuário
	in: .asciiz "\nDeseja Adicionar um Novo Nó? \n 1 - Sim 0, - Não: "
	num: .asciiz "\nDigite o Número Para Adicionar Na Lista Ligada: "
	esp: .asciiz " "
	list: .asciiz "\nLista Ligada: " 
	sum: .asciiz "\nSoma Total: "
	
# Seção em que as instruções são declaradas
.text

	move $s0,$zero 	# Ponteiro Para Cabeça da Lista Ligada, Inicialmente Nulo
	move $s1,$zero	# Quantidade de Nós, Inicialmente Nulo
	move $s5,$zero	# Soma Total, Inicialmente Nula
	li $t2, 8 	# Tamanho de um Nó

# Loop Principal Para o Usuário	
loop_in:
	li $v0, 4 	# Comando Para Impressão de String
	la $a0, in 	# Move o Endereço da String no Registrador $a0
	syscall 	# Imprime a Mensagem na Tela
	
	li $v0, 5	# Comando Para Leitura de Inteiro
	syscall 	# Faz a Leitura do Inteiro e Armazena em $v0
	move $t1, $v0	# Move o Inteiro Lido Para o Registrador $t1

	beqz $t1,prepara	# Se $t1 == 0, Finalize o Loop	
	j criar_no	# Caso Contrário, Crie Novo Nó

# Criação de Nó Na Lista Ligada
criar_no:
	li $v0, 4 	# Comando Para Impressão de String
	la $a0, num	# Move o Endereço da String no Registrador $a0
	syscall 	# Imprime a Mensagem na Tela

	li $v0, 5	# Comando Para Leitura de Inteiro
	syscall 	# Faz a Leitura do Inteiro e Armazena em $v0
	move $t1, $v0	# Move o Inteiro Lido Para o Registrador $t1
	add $s5,$s5,$t1 # Adiciona o Valor a Soma Total
	
	li $v0,9 	# Comando Para Alocação de Memória
	move $a0,$t2	# Move o Tamanho da Memória ao Registrador $a0
	syscall 	# Faz a Alocação Dinâmica
	move $t0,$v0	# Move o Endereço do Nó Ao Registrador $t0
	
	sw $t1, 0($t0)	# Armazena o Valor Lido no Campo Data do Nó
	sw $s0, 4($t0)	# Campo Prox do Nó Aponta Para o Cabeça
	move $s0,$t0 	# Atualiza a Cabeça Para Ser o Novo Nó
	addi $s1,$s1,1	# Incrementa a Quantidade de Nós 
	j loop_in	# Volte ao Loop Inicial


# Prepara Registradores Para Impressão de Lista Ligada
prepara:
	move $s2,$s0 	# Copia o Endereço do Cabeça ao Registrador $s2
	move $t3,$zero	# Contador, Inicialmente Nulo
	
	li $v0, 4 	# Comando Para Impressão de String
	la $a0,list	# Carrega o Endereço da String ao Registrador $a0
	syscall 	# Imprime a String na Tela
	
# Exibe a Lista Criada
f_loop:
	beq $t3,$s1,end # Se Contador == Tamanho, Finalize o Programa
	lw $t4, 0($s2) 	# Carrega o Elemento da Lista ao Registrador $t4
	
	li $v0, 1 	# Comando Para Impressão de Inteiro
	move $a0,$t4	# Carrega o Elemento da Lista ao Registrador $a0
	syscall 	# Imprime o Elemento da Lista na Tela
	
	li $v0, 4 	# Comando Para Impressão de String
	la $a0,esp	# Carrega o Endereço da String ao Registrador $a0
	syscall 	# Imprime a String na Tela
	
	addi $t3,$t3,1	# Incrementa o Contador
	lw $s2, 4($s2)	# Obtém o Endereço do Próximo Nó
	j f_loop 	# Volte ao Loop

# Imprime a Soma e Finaliza o Programa	
end:
	li $v0, 4 	# Comando Para Impressão de String
	la $a0,sum	# Carrega o Endereço da String ao Registrador $a0
	syscall 	# Imprime a String na Tela	
	
	li $v0, 1 	# Comando Para Impressão de Inteiro
	move $a0,$s5	# Move a Soma Total ao Registrador $a0
	syscall 	# Imprime o Inteiro na Tela
		
	li $v0,10 	# Comando Para Encerrar o Programa
	syscall		# Encerra o Programa
	
	
