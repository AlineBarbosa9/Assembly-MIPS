# Seção Onde os Dados São Declarados
.data
	# Mensagens que Serão Exibidas para o Usuário
	prompt_msg:      .asciiz "Digite a mensagem: "
	result_msg:      .asciiz "\nMensagem criptografada: "
	buffer_entrada:  .space 128
	buffer_saida:    .space 128

# Seção Onde as Instruções São Declaradas		
.text
main:
	# Exibe a Mensagem
	li $v0, 4 # Comando para Impressão de String
	la $a0, prompt_msg # Carrega o Prompt ao Registrador a0
	syscall # Imprime a Mensagem na Tela

	# Leitura de String
	li $v0, 8 # Comando Para Leitura de String
	la $a0, buffer_entrada # Carrega o Endereço de Entrada ao Registrador a0
	li $a1, 128 # Número Máximo de Caracteres Lidos 
	syscall # Faz a Leitura de String
		
	# Prepara Ponteiros para os Buffers
	la $t0, buffer_entrada  # Ponteiro para a String Original
	la $t1, buffer_saida    # Ponteiro para a String de Saída

# Controle de Loop e Finalização do Algoritmo
loop_principal:
	# Carrega o Caractere Atual da Entrada
	lb $a0, 0($t0) # Carrega um Único Byte de Memória ao Registrador $a0
		
	# Condicional de Parada:
	beqz $a0, fim_loop # Vá para o Fim do Loop se Encontrar '\0'
	
	# Caso Contrário:		
	jal cifrar_char # Vai Para a Função cifrar_char
		
	# Armazena o Caractere Retornado ($v0) no Buffer de Saida
	sb $v0, 0($t1) # Arnazena o Byte no Registrador $v0
		
	# Avança os Ponteiros Para o Próximo Caractere
	addi $t0, $t0, 1 # 1 Byte = Tamanho de um Char
	addi $t1, $t1, 1
	j loop_principal # Volte ao Loop Principal

# Seção que Marca a Impressão de Resultados e Finaliza o Programa		
fim_loop:
	sb $zero, 0($t1) # Garante o terminador nulo na string de saida
	
	# Exibe a mensagem FInal
	li $v0, 4 # Comando para Impressão de String
	la $a0, result_msg # Carrega a String ao Registrador a0
	syscall # Imprime a Mensagem

	# Impressão da Mensagem Criptografada
	li $v0, 4 # Comando Para Impressão de String
	la $a0, buffer_saida # Carrega o Endereço do Buffer de Saída ao Registrador $a0
	syscall # Imprime a Mensagem Codificada
		
	# Finaliza o Programa
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
		
# --------------------------------------------------------------------
# Funcao: cifrar_char
# Descricao: Criptografa um Único Caractere.
# Argumentos: $a0 = O Caractere Original.
# Retorno: $v0 = O Caractere Criptografado.
# --------------------------------------------------------------------
cifrar_char:
	move $v0,$a0 # Move o Conteúdo de $a0 para $v0
	
	# Registradores Para Comparação de Caracteres
	li $t2, 'A' # Carrega em $t2 o Valor 'A'
	li $t3, 'Z' # Carrega em $t3 o Valor 'Z'
	
	blt $a0, $t2, verifica_minuscula # Se Char < A, 
	bgt $a0, $t3, verifica_minuscula # Se char > Z, 

	# Caso Contrário:
	addi $v0,$a0,3 # Adicione + 3 ao Valor do Char Atual
	li $t4,'Z' # Carrega em $t4 o Valor 'Z'
	ble $v0, $t4,fim_cifra # Se char <= Z Vá para o Fim Cifra
	# Caso Contrário:
	addi $v0, $v0,-26 # Aplica a Circularidade 
	j fim_cifra # Vá Para Fim_Cifra

# Faz o Tratamento Correto de Caracteres Minúsculos
verifica_minuscula:
	li $t2,'a' # Carrega 'a' ao Registrador t2
	li $t3,'z' # Carrega 'z' ao Registrador t3
	blt $a0,$t2,fim_cifra # se caractere < 'a'
	bgt $a0,$t3,fim_cifra # se caractere > 'z'
	
	addi $v0, $a0, 3 # Incrementa
	li $t4, 'z' # Carrega em t4 o valor 'z'
	ble $v0, $t4,fim_cifra # Se char <= 'z' -> Conversão Correta
	# Caso Contrário:
	addi $v0, $v0,-26 # Faz o Processo 'Circular'
	j fim_cifra # Vá para o Fim da Cifra
	
# Fim da Função:			
fim_cifra:
	jr $ra # Retorna Para Quem Chamou	
	# :)
	
