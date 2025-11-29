# Seção em que os dados são declarados
.data
    str: .space 100       # Reserva 100 bytes para a String de Entrada
    
    # Mensagens Que Serão Exibidas ao Usuário
    prompt:  .asciiz "Digite uma String Qualquer: "
    yes:     .asciiz "A String É um Palíndromo.\n"
    no:      .asciiz "A String Não É um Palíndromo.\n"
    newline_char: .byte 0xa       # Caractere de Nova Linha ('\n')

# Seção em que as instruções são declaradas
.text
main:
        # Exibe a Mensagem Solicitando a String
        li $v0, 4                 # Código Para Impressão de String
        la $a0, prompt            # Carrega o Endereço da String ao Registrador $a0
        syscall                   # Imprime a Mensagem na Tela

        # Lê a String do Usuário
        li $v0, 8                 # Código Para Leitura de String
        la $a0, str               # Carrega o Endereço da String Lida ao Registrador $a0
        li $a1, 100               # Tamanho Máximo da String (Argumento de Função)
        syscall                   # Faz a Leitura da String do Usuário

        # Inicia a remoção do \n
        la $t0, str               # $t0 = Ponteiro para a String
        
        # Chama a Função de Correção
        j remove_newline 

# --- Função de Remoção do Caractere de Quebra de Linha ---
# Percorre a string lida e substitui o primeiro '\n' pelo '\0'
remove_newline:
        lb $t1, 0($t0)            # Carrega o Caractere Atual ($t1)
        beq $t1, $zero, start_check # Se for \0, terminamos (string vazia ou \n removido)
        
        # Compara com o caractere \n (ASCII 10, ou 0xA)
        li $t2, 0xa               # Carrega o valor ASCII de '\n' em $t2
        bne $t1, $t2, next_char   # Se não for '\n', vá para o próximo caractere
        
        # Se for '\n', substitui por '\0' (terminador nulo)
        sb $zero, 0($t0)          # Coloca \0 no local do \n
        j start_check             # Pula para a verificação do palíndromo

next_char:
        addi $t0, $t0, 1          # Move o ponteiro para o próximo byte
        j remove_newline          # Repete o loop

# --- Inicia a Verificação do Palíndromo ---
start_check:
        la $t0, str               # $t0 = Ponteiro de Início
        li $t1, 0                 # $t1 = Índice/Contador de Comprimento

# 1. Função Que Percorre a String e Conta o Comprimento
find_end:
        lb $t2, 0($t0)            # Carrega o Caractere da String em $t2
        beq $t2, $zero, check     # Se for \0 (agora no lugar correto), vá para Check
        addi $t0, $t0, 1          # Move Para o Próximo Caractere
        addi $t1, $t1, 1          # Incrementa o Comprimento Real
        j find_end                # Volte a Função find_end

# 2. Verifica se a String É um Palíndromo
check:
        # $t1 -> Contém o Comprimento REAL da String
        
        move $t2, $t1             # Copia o Comprimento Real para $t2
        div $t2, $t2, 2           # Divide por 2 (Metade da String)
        mflo $t2                  # $t2 Contém a Metade do Comprimento (Número de Comparações)

        la $t0, str               # $t0 = Endereço de Começo da String (Ponteiro Esquerdo)
        
        la $t3, str               # $t3 = Endereço de Início
        add $t3, $t3, $t1         # $t3 = Endereço de Início + Comprimento Real
        add $t3, $t3, -1          # $t3 = Endereço do Último Caractere Útil (Ponteiro Direito)

# 3. Percorre as Partes da String
palindrome_loop:
        bgtz $t2, compare_chars   # Se $t2 > 0 (Ainda Restam Comparações), Continua
        j is_palindrome           # Se $t2 <= 0, É um Palíndromo

compare_chars:
        lb $t4, 0($t0)            # Carrega o Caractere Atual do Começo
        lb $t5, 0($t3)            # Carrega o Caractere Atual do Final
        bne $t4, $t5, not_p       # Se os caracteres !=, Não é um Palíndromo

        addi $t0, $t0, 1          # Avança Para o Próximo Caractere no Começo
        addi $t3, $t3, -1         # Retrocede Para o Próximo Caractere no Final
        subi $t2, $t2, 1          # Decrementa o Contador
        j palindrome_loop         # Repete o Loop

# 4. Exibe o Resultado
is_palindrome:
        li $v0, 4                 
        la $a0, yes               
        syscall                   
        j end_program             

not_p:
        li $v0, 4                 
        la $a0, no                
        syscall                   

# 5. Finaliza o Programa
end_program:
        li $v0, 10                
        syscall
