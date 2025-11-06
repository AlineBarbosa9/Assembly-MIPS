.data
    msg_op1: .asciiz "Digite o Primeiro Operando: "         # Mensagem Para Primeiro Operando
    msg_op2: .asciiz "Digite o Segundo Operando: "          # Mensagem Para Segundo Operando
    msg_op:  .asciiz "Escolha a Operação (1=Soma, 2=Subtração, 3=Multiplicação, 4=Divisão): "  # Mensagem Para Escolha Da Operação
    msg_res: .asciiz "Resultado: "                          # Mensagem De Resultado
    msg_erro: .asciiz "Erro: Divisão Por Zero.\n"           # Mensagem De Erro

.text
.globl main

main:
    # Entrada Do Primeiro Operando
    li $v0, 4                           # Carrega Código Da Syscall De Impressão
    la $a0, msg_op1                     # Carrega Endereço Da Mensagem Para Primeiro Operando
    syscall                             # Executa Syscall

    li $v0, 5                           # Carrega Código Da Syscall De Leitura Inteira
    syscall                             # Executa Syscall
    move $t0, $v0                       # Move Operando Para $t0

    # Entrada Do Segundo Operando
    li $v0, 4
    la $a0, msg_op2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0                       # Move Operando Para $t1

    # Escolha Da Operação
    li $v0, 4
    la $a0, msg_op
    syscall

    li $v0, 5
    syscall
    move $t2, $v0                       # Move Código Da Operação Para $t2

    # Verificações De Operação
    li $t4, 1
    beq $t2, $t4, soma                  # Se Escolha For 1, Vai Para Soma

    li $t4, 2
    beq $t2, $t4, subtracao             # Se Escolha For 2, Vai Para Subtração

    li $t4, 3
    beq $t2, $t4, multiplicacao         # Se Escolha For 3, Vai Para Multiplicação

    li $t4, 4
    beq $t2, $t4, divisao               # Se Escolha For 4, Vai Para Divisão

    j fim                               # Se Código Inválido, Finaliza Sem Calcular

soma:
    add $t3, $t0, $t1                   # Soma: $t3 = $t0 + $t1
    j exibe_resultado                   # Vai Para Impressão Do Resultado

subtracao:
    sub $t3, $t0, $t1                   # Subtração: $t3 = $t0 - $t1
    j exibe_resultado

multiplicacao:
    mult $t0, $t1                       # Multiplicação: Resultado Vai Para HI/LO
    mflo $t3                            # Move Resultado (LO) Para $t3
    j exibe_resultado

divisao:
    beq $t1, $zero, erro_div_zero       # Verifica Se Divisor É Zero
    div $t0, $t1                        # Divisão: $t0 ÷ $t1
    mflo $t3                            # Move Quociente (LO) Para $t3
    j exibe_resultado

erro_div_zero:
    li $v0, 4
    la $a0, msg_erro                    # Carrega Mensagem De Erro
    syscall
    j fim                               # Vai Para Fim Sem Mostrar Resultado

exibe_resultado:
    li $v0, 4
    la $a0, msg_res                     # Mostra Texto "Resultado: "
    syscall

    li $v0, 1
    move $a0, $t3                       # Move Resultado Para Impressão
    syscall

fim:
    li $v0, 10                          # Finaliza O Programa
    syscall
