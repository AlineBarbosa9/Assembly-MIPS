# Este Programa em Assembly- Mips Utiliza o Método
# de Brian Kernighan Para Calcular a Quantidade de Bits
# '1' na Representação Binária de um Inteiro e Imprimir
# o Resultado Obtido na Tela.

# Seção em os dados são declarados:
.data
	in: .asciiz "\nDigite um Número Inteiro: "
	out: .asciiz "\nQuantidade Total de Bits 1 É Igual a: "


# Seção em que as instruções são declaradas
.text
	li $v0,4 		# Comando Para Impressão de String
	la $a0,in		# Carrega o Endereço da String ao Registrador $a0
	syscall			# Imprime a Mensagem na Tela
	
	li $v0,5		# Comando Para Leitura de Inteiro
	syscall			# Faz a Leitura e Armazena em $v0
	move $s0,$v0		# Move o Inteiro Lido ao Registrador $s0
	
	move $t1,$zero		# Inicializa o Contador $t1 em 0

# Método Kernighan Para Contar Bits '1'
kernighan:
	beqz $s0,end		# Se Número Igual a 0, Finalize o Método
	addi $s1,$s0,-1		# $s1 = $s0 - 1
	and $s2, $s0,$s1	# $s0 = $s0 && ($s0 - 1)
	move $s0, $s2		# Atualiza o Valor de $s0
	addi $t1,$t1,1		# Incrementa o Contador $t1
	j kernighan		# Volta ao Método

# Imprime o Resultado e Finaliza o Programa
end:
	li $v0,4 		# Comando Para Impressão de String
	la $a0,out		# Carrega o Endereço da String ao Registrador $a0
	syscall			# Imprime a Mensagem na Tela
	
	li $v0,1		# Comando Para Impressão de Inteiro
	move $a0, $t1		# Carrega o Contador ao Registrador $a0
	syscall			# Imprime a Quantidade de Bits na Tela
	
	li $v0,10		# Comando Para Encerrar o Programa
	syscall			# Encerra o Programa
	
	