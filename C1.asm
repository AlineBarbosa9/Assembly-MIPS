# Este Programa em Assembly-MIPS calcula o fatorial de
# um Número Inteiro Usando Recursão e Exibe o Resultado

# Seção em que os dados são declarados
.data
	# Mensagens que Serão Exibidas ao Usuário
	in: .asciiz "\nDigite um Número Não-Negativo Qualquer: "
	out: .asciiz "\nO Fatorial de N é Igual a: "

# Seção em que as instruções são declaradas
.text
main:
	li $v0,4 		# Comando Para Impressão de String
	la $a0,in		# Carrega o Endereço da String ao Registrador $a0
	syscall			# Imprime a Mensagem de Input na Tela
	
	li $v0,5		# Comando Para Leitura de Inteiro
	syscall			# Faz a Leitura do Inteiro e Armazena em $v0
	move $s0,$v0		# Move o Inteiro Lido o Registrador $a0
	
	move $a0,$s0		# Move o Inteiro Lido ao Registrador $a0
	jal fatorial		# Chama a Função Fatorial
	
	move $s1,$v0		# Move o Fatorial ao Registrador $a0
	
	li $v0,4 		# Comando Para Impressão de String
	la $a0,out		# Carrega o Endereço da String ao Registrador $a0
	syscall			# Imprime a Mensagem de Input na Tela
	
	li $v0,1		# Comando Para Impressão de Inteiro
	move $a0,$s1		# Carrega o Fatorial ao Registrador $a0
	syscall			# Imprime o Resultado na Tela
	
	li $v0,10		# Comando Para Encerrar o Programa
	syscall			# Encerra o Programa

# Calcula o Fatorial de um Número Utilizando Recursividade
fatorial:
	beqz $a0,fat_base	# Caso Base: Fatorial(0) = 1
	addi $sp,$sp,-8		# Reserva 8 Bytes na Stack
	sw $ra, 0($sp)		# Salva o Endereço de Retorno
	sw $a0, 4($sp)		# Salva o Valor de N (Argumento)
	
	subi $a0,$a0,1		# Decrementa N
	jal fatorial		# Chama a Função de Fatorial
	
        lw $a0, 4($sp)          # Restaura o Valor Original de N
        lw $ra, 0($sp)          # Restaura o Valor de $ra
        addi $sp, $sp, 8        # Desfaz a Reserva de Espaço na Pilha
        
        mul $v0, $v0, $a0       # $v0 = Fatorial(N-1) * N
        jr $ra                  # Retorna Para Quem Chamou
        
# Caso Base da Função Fatorial
fat_base:
	li $v0, 1		# Fatorial(0) = 1
        jr $ra                  # Retorna Para Quem Chamou
	
	


	
	
	