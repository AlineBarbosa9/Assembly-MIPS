# Este Programa em Assembly-Mips Adiciona Elementos de Um
# Array Estático em ua Lista Ligada, Respeitando a Ordem de
# Cada Elemento. Head e Tail São Utilizados.

# Seção em que os dados são declarados
.data
    	# Números que Serão Adicionados na Lista Ligada
    	array: .word 55,20,51,68,40
    	newline: .asciiz "\n"
    	space: .asciiz " "

# Seção em que as instruções são declaradas
.text
.globl main

main:
    	# Registradores de Controle:
    	move $s0,$zero          # $s0 -> Contador (índice do array)
    	move $s4,$zero          # $s4 -> Head da Lista, Inicialmente NULL
   	move $s5,$zero          # $s5 -> Tail da Lista, Inicialmente NULL
    
    	la $s1,array            # Carrega o Endereço Inicial do Array em $s1
    	li $s2,5                # $s2 -> Quantidade De Números Que Serão Inseridos
    
    	# Inserir Elementos na Lista
    	move $a0,$s0            # Argumento para inserir: Contador (0)
    	jal inserir             # Vá Para a Função Inserir
    
    	# Imprimir a Lista
    	move $a0,$s4            # Argumento para printar: Head da lista
    	jal print_lista         # Vá Para a Função de Impressão

    	# Encerrar o Programa
    	li $v0,10               # Comando Para Encerrar o Programa
    	syscall                 # Encerra o Programa

# Função Para Inserir Elementos na Lista Ligada
inserir:
    	move $s0,$a0            # $s0 -> Contador (índice atual)
    
# Controle de Função
loop_inserir:
    	beq $s0,$s2,retorna_inserir   # Se Contador == Tamanho Array, Encerre a Função

    	# --- 1. Alocação Dinâmica de Memória para o Novo Nó (8 Bytes) ---
    	li $v0,9                # Código Para Alocação de Memória (sbrk)
    	li $a0,8                # Tamanho de um Nó
    	syscall                 
    	move $t1,$v0            # $t1 -> Endereço do Novo Nó
    
    	# --- 2. Obter e Armazenar o Dado ---
    	sll $t2,$s0,2           # $t2 = Deslocamento (Índice x 4)
    	add $t2,$t2,$s1         # $t2 = Endereço do Elemento no array estático
    	lw $t3,0($t2)           # $t3 = Valor do Elemento (array[i])
    	sw $t3,0($t1)           # Armazena o Dado (valor) no Novo Nó (offset 0)
    	sw $zero,4($t1)         # Armazena NULL (0) no ponteiro 'next' (offset 4)

    	# --- 3. Conectar o Nó à Lista ---
    	beqz $s4,primeiro_no    # Se Head é NULL, este é o primeiro nó
    
    	# É um nó subsequente: Conecte o Tail anterior ao novo nó
    	sw $t1,4($s5)           # Tail.next = Novo Nó ($t1)
    	move $s5,$t1            # Atualiza o Tail para o Novo Nó
    	j proximo_elemento	# Vá para a Seção proximo_elemento
    
# Cria o Head e o Tail (apenas na primeira iteração)
primeiro_no:
    	move $s4,$t1            # Head Aponta Para o Novo Nó
    	move $s5,$t1            # Tail Aponta Para o Novo Nó
    
proximo_elemento:
    	addi $s0,$s0,1          # Incrementa o Contador (próximo índice do array)
    	j loop_inserir          # Retorne ao Loop

retorna_inserir:
    	jr $ra                  # Volta Para Quem Chamou


# Função Para Impressão de Lista Ligada
print_lista:
    	move $t0,$a0            # $t0 = Ponteiro de Travessia (Começa no Head)

loop_print:
    	beqz $t0,fim_print      # Se o ponteiro ($t0) for NULL, a lista terminou
    
    	# --- 1. Imprimir o Valor do Nó ---
    	lw $a0,0($t0)           # Carrega o **dado** (valor) para $a0
    	li $v0,1                # Código de syscall para imprimir inteiro
    	syscall                 # Imprime o valor
    
    	# --- 2. Imprimir um Espaço ---
    	li $v0,4                # Código de syscall para imprimir string
    	la $a0,space            # Carrega o endereço da string " "
    	syscall                 # Imprime o espaço
    
    	# --- 3. Mover para o Próximo Nó ---
    	lw $t0,4($t0)           # $t0 = $t0.next (Carrega o endereço 'next' para $t0)
    	j loop_print
    
fim_print:
    	# Imprimir Nova Linha no final
    	li $v0,4
    	la $a0,newline
    	syscall
    
    	jr $ra                  # Volta Para Quem Chamou
