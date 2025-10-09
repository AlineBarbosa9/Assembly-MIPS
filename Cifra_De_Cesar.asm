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
	# Exibe o Prompt
	li $v0, 4 # Comando para Impressão de String
	la $a0, prompt_msg # Carrega o Prompt ao Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	li $v0, 8
	la $a0, buffer_entrada # Carrega a Entrada ao Registrador a0
	li $a1, 128
	syscall
		
	# Prepara Ponteiros para os Buffers
	la $t0, buffer_entrada  # Ponteiro para a string original
	la $t1, buffer_saida    # Ponteiro para a string de saida
		
loop_principal:
	# Carrega o caractere atual da entrada
	lb $a0, 0($t0)
		
	# [ Bloco 1 ] 
	beqz $a0, fim_loop # Vá para o Fim do Loop se Encontrar '\0'
	
	# Caso Contrário:		
	# [ Bloco 2 ]
	jal cifrar_char # Vai Para a Função cifrar_char
		
	# Armazena o caractere retornado ($v0) no buffer de saida
	sb $v0, 0($t1)
		
	# Avanca os ponteiros para o proximo caractere
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	j loop_principal

# Seção que Marca a Impressão de Resultados e Finaliza o Programa		
fim_loop:
	sb $zero, 0($t1) # Garante o terminador nulo na string de saida
	
	# Exibe a mensagem final
	li $v0, 4 # Comando para Impressão de String
	la $a0, result_msg # Carrega a String ao Registrador a0
	syscall # Imprime a Mensagem
	
	li $v0, 4
	la $a0, buffer_saida
	syscall
		
	# Finaliza o programa
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
		
# --------------------------------------------------------------------
# Funcao: cifrar_char
# Descricao: Criptografa um unico caractere.
# Argumentos: $a0 = O caractere original.
# Retorno: $v0 = O caractere criptografado.
# --------------------------------------------------------------------
cifrar_char:
	# [ Bloco 3 ]	
	move $v0,$a0 # Move o Conteúdo de $a0 para $t0
	
	# Registradores Para Comparação de Caracteres
	li $t2, 'A' # Carrega em $t2 o Valor 'A'
	li $t3, 'Z' # Carrega em $t3 o Valor 'Z'
	
	blt $a0, $t2, verifica_minuscula # Se char < a, 
	bgt $a0, $t3, verifica_minuscula # Se char > Z, 
	# Caso Contrário:
	addi $v0,$a0,3 # Adicione +3 ao Valor do Char Atual
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
	# [ Bloco 4 ]
	jr $ra # Retorna Para Quem Chamou	
	# :)
	
