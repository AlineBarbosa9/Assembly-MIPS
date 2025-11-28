# Este Programa em Assembly-MIPS Simula Uma Estrutura de Dados
# Pilha de Números Inteiros, Com as Operações de Push e Pop.
# São Adicionados os Elementos: 10,20,30,40,50. Imprime-se na Tela
# Depois, Remove-se dois Valores, Imprimindo o Resultado na Tela.

# Seção em que os dados são declarados
.data
	stack: .space 40	# Pilha de Capacidade 5
	pilha: .asciiz "\nP = " # Formatação de Saída
	esp: .asciiz " "	# Espaço
	
# Seção em que as instruções são declaradas
.text
# Função Principal
main:
	la $s0,stack		# Recebe o Endereço Inicial de Memória da Pilha
	li $s4,4		# Constante Para Tamanho de Inteiro
	move $s1,$zero		# $s1 - Índice Atual da Pilha (Topo)
	
	# ------------------------------------------------------------------
	# -------------------- INSERÇÃO DE VALORES -------------------------
	# ------------------------------------------------------------------
	
	li $t5,10 		# Carrega o Valor 10 ao Registrador $t5
	move $a0,$t5		# Carrega 10 ao Registrador $a0
	jal push		# Chama a Função Push
	
	li $t5,20 		# Carrega o Valor 20 ao Registrador $t5
	move $a0,$t5		# Carrega 20 ao Registrador $a0
	jal push		# Chama a Função Push
	
	li $t5,30 		# Carrega o Valor 30 ao Registrador $t5
	move $a0,$t5		# Carrega 30 ao Registrador $a0
	jal push		# Chama a Função Push
	
	li $t5,40 		# Carrega o Valor 40 ao Registrador $t5
	move $a0,$t5		# Carrega 40 ao Registrador $a0
	jal push		# Chama a Função Push
	
	li $t5,50 		# Carrega o Valor 50 ao Registrador $t5
	move $a0,$t5		# Carrega 50 ao Registrador $a0
	jal push		# Chama a Função Push
	
	jal prepara_print	# Imprime os Valores da Pilha na Tela
	
	# ------------------------------------------------------------------
	# -------------------- REMOÇÃO DE VALORES --------------------------
	# ------------------------------------------------------------------
	
	jal pop 		# Chama a Função Pop
	jal pop			# Chama a Função Pop
	
	jal prepara_print	# Imprime os Valores da Pilha na Tela
	
	# Encerra o Programa
	li $v0, 10		# Comando Para Encerrar o Programa
	syscall			# Encerra o Programa
	
	
	

# Função que Adiciona um Elemento Em Uma Pilha	
push:
	move $s2,$a0		# Move o Argumento Para o Registrador $s2
	mul $t1, $s1,$s4	# Calcula o Endereço Atual do Inteiro (4Bytes)
	add $t1, $t1, $s0	# Soma Ao Endereço Inicial
	sw $s2, 0($t1)		# Carrega o Número do Argumento no Índice $t1
	addi $s1, $s1,1		# Incrementa o Índice Atual da Pilha (Topo)
	jr $ra			# Retorna Para Quem Chamou

# Função Que Remove um Elemento Em Uma Pilha
pop:
	addi $s1,$s1,-1	# Subtrai o Índice Atual (Topo)
	jr $ra			# Retorna Para Quem Chamou

# Função Que Imprime o Conteúdo da Pilha
prepara_print:

	# Formatação de Saída
	li $v0, 4 		# Comando Para Impressão de String
	la $a0, pilha 		# Carrega o Endereço da String ao Registrador $a0
	syscall 		# Imprime a Mensagem na Tela
	move $t2,$zero		# Contador, Inicialmente Nulo

print:	
	beq $t2,$s1,end_print	# Se Contador == Índice Atual, Finalize o Print
	move $t3,$t2		# Move o Contador ao Registrador $t3
	mul $t3,$t3,$s4		# Multiplica Contador por 4
	add $t3,$t3,$s0		# Soma o Resultado ao Endereço Inicial
	lw $t4,0($t3)		# Carrega o Elemento no Registrador $t4
	
	li $v0,1		# Comando Para Impressão de Inteiro
	move $a0,$t4		# Carrega o Elemento ao Registrador $a0
	syscall 		# Imprime o Elemento na Tela
	
	li $v0, 4 		# Comando Para Impressão de String
	la $a0, esp		# Carrega a String Espaço Ao Registrador $a0
	syscall			# Imprime a String na Tela
	
	addi $t2,$t2,1		# Incrementa o Contador
	j print			# Volte ao Print

# Retorno de Função
end_print:
	jr $ra			# Retorna Para Quem Chamou
	
	
	
	
	
	