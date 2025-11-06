.data
    msg_input: .asciiz "Digite um Número Inteiro: "   # Mensagem De Entrada
    msg_par:   .asciiz "Par\n"                        # Mensagem Para Número Par
    msg_impar: .asciiz "Impar\n"                      # Mensagem Para Número Ímpar

.text
.globl main

main:
    li $v0, 4                         # Carrega Código Da Syscall De Impressão
    la $a0, msg_input                 # Carrega Endereço Da Mensagem De Entrada
    syscall                           # Executa Syscall Para Exibir Mensagem

    li $v0, 5                         # Carrega Código Da Syscall De Leitura Inteira
    syscall                           # Executa Syscall Para Ler Número
    move $t0, $v0                     # Move Valor Lido Para Registrador $t0

    andi $t1, $t0, 1                  # Faz Operação AND Com 1 Para Verificar Bit Menos Significativo
                                      # Se Resultado For 0 Então É Par, Caso Contrário É Ímpar

    beq $t1, $zero, imprime_par       # Se Resultado For Zero, Salta Para Impressão De Par

    li $v0, 4                         # Carrega Código Da Syscall De Impressão
    la $a0, msg_impar                 # Carrega Endereço Da Mensagem "Impar"
    syscall                           # Executa Syscall Para Exibir Mensagem
    j fim                             # Salta Para O Fim Do Programa

imprime_par:
    li $v0, 4                         # Carrega Código Da Syscall De Impressão
    la $a0, msg_par                   # Carrega Endereço Da Mensagem "Par"
    syscall                           # Executa Syscall Para Exibir Mensagem

fim:
    li $v0, 10                        # Carrega Código Da Syscall Para Encerrar O Programa
    syscall                           # Executa Syscall De Finalização
