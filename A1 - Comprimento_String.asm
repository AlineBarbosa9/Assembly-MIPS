# -----------------------------------------------------------
# Este Programa em Assembly-MIPS Faz a Leitura de uma String
# de Até 128 Caracteres e Imprime seu Tamanho na Tela
# -----------------------------------------------------------

# Seção onde os Dados são Declarados
.data
	# Mensagens que Serão Exibidas ao Usuário
	input: .asciiz "\nDigite uma String Qualquer: "
	output: .asciiz "\nTamanho da String: "
	buffer: .space 128 # Lê Até 128 Caracteres

# Seção onde as Instruções são Declaradas
.text
funcao_principal:
	# Impressão de Mensagem Inicial
	li $v0,4 # Comando para Impressão de String
	la $a0,input # Carrega o Endereço da String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de String
	li $v0,8 # Comando Para Leitura de String
	la $a0,buffer # Carrega o Endereço do Buffer ao Registrador $a0
	li $a1, 128 # Carrega o Tamanho Máximo de Caracteres
	syscall # Faz a Leitura da String
	
	# Ajuste de Ponteiro
	la $t0, buffer # Carrega o Endereço Inicial do Buffer ao Registrador $t0
	
	# Inicialização do Contador
	move $s0,$zero # Inicia Registrador $s0 em 0

# Percorre a String
loop:
	# Caractere Atual
	lb $a0,0($t0) # Carrega um Byte ao Registrador $a0
	# Condicional de Parada
	beqz $a0,fim_loop # Se Caractere Igual a '\0', Vá para o Fim do Loop
	# Caso Contrário
	addi $s0,$s0,1 # Incremente o Contador
	addi $t0,$t0,1 # Vá Para o Próximo Caractere
	j loop # Volte ao Loop

# Imprime o Resultado e Finaliza o Programa
fim_loop:
	# Impressão de Mensagem Final
	li $v0,4 # Comando para Impressão de String
	la $a0,output # Carrega o Endereço da String ao Registrador $a0
	syscall # Imprime a Mensagem na Tela
	
	# Impressão do Tamanho da String
	li $v0,1 # Comando para Impressão de Inteiro
	addi $s0,$s0,-1 # Exclue o '\n' da Contagem
	move $a0,$s0 # Move o Tamanho da String ao Registrador $a0
	syscall # Imprime o Tamanho na Tela
	
	# Encerra o Programa
	li $v0,10 # Comando Para Encerrar o Programa
	syscall # Encerra o Programa
	# :)
