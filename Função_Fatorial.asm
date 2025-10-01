# Laboratório 02 - Funções e Estruturas de Repetição
# Exercício 01 - Cálculo de um Número Fatorial

# Integrantes:
# Aline Barbosa Vidal RA: 10721348
# Beatriz Ferreira Vianna RA: 10729512
# Kauê Lima Rodrigues Meneses RA: 10410594
# Theo Esposito Resende RA: 10721356

# Seção em que os Dados São Declarados
.data
	# Mensagens que Serão Exibidas ao Usuário
	msg1: .asciiz "\nDigite um Número Não Negativo: "
	inv: .asciiz "\nNúmero Inválido. Digite Outro Número: "
	result: .asciiz "\n O Fatorial é Igual a: "
	overflow_msg: .asciiz "\n[Estouro de Bits - Resultado Incorreto]"
	
# Seção em que as Instruções São Declaradas
.text
# Função Principal:
.main:
	# Impressão da Mensagem para Leitura de Inteiro
	li $v0, 4 # Comando para Impressão de String
	la $a0, msg1 # Carrega a Mensagem para o Registrador a0
	syscall # Imprime a Mensagem na Tela
	
	# Leitura de Inteiro
	li $v0, 5 # Comando para Leitura de Inteiro
	# O Valor lido Será Armazenado no Registrador v0
	syscall # Lê o Inteiro Digitado pelo Usuário
	move $a0, $v0 # Move o Inteiro Lido Para o Registrador a0

# Faz a Validação do Número Lido	
valida_entrada:
	bltz $a0, invalido # Se Inteiro Menor que  Zero, Vá para a Função invalido

	# Verifica se o número é maior que 12 para detectar possível OverFlow
	li $t1, 0 # $t1 será a Flag de Overflow: 0 = Não, 1 = Sim
	li $t2, 12 # $t2 Guardará o Valor 12 para Ser Comparado com o Número Lido 
	bgt $a0, $t2, set_overflow # Se número > 12, Vá Para Overflow
	jal fatorial # Chama a Função Fatorial
	move $s1, $v0 # Move o Resultado do Fatorial Para $s1
	jal imprime # Vai Para Impressão

# Indica que Houve Estouro de Bits
set_overflow:
	li $t1, 1 # Indica Flag de Overflow
	jal fatorial # Chama a Função Fatorial
	move $s1, $v0 # Move o Resultado do Fatorial Para $s1
	jal imprime # Vai Para a Função de Impressão 

# Invalida a Entrada do Usuário e Lê Outro Número Inteiro	
invalido:
	li $v0,4 # Comando para Impressão de String
	la $a0, inv # Carrega a Mensagem ao Registrador a0
	syscall # Imprime a Mensagem na Tela
		
	li $v0, 5 # Comando para Leitura de Inteiro
	# O Valor Lido Será Armazenado no Registrador v0
	syscall # Lê o Inteiro Fornecido pelo Usuário
	move $a0, $v0 # Transfere o Valor para o Registrador a0
	j valida_entrada # Volta para a Função de Validação
	
# Função que Faz a Operação de Fatorial
# Registradores Importantes:
# $t0 - Contador - Iniciado com Valor Lido e é Decrementado a Cada Ciclo
# $a0 - Argumento da Função (Número Lido)
# $v0 - Inicia em 1 e Guarda o Resultado de Cada Multiplicação
fatorial:
	li $v0, 1 # Inicializa Resultado com 1 (Fatorial de 0! = 1)
	ble $a0, 1, fim_fat # Se N <= 1, Retorna 1 e Vai Para o Fim da Operação
	move $t0, $a0  # $t0 = Contador (Com Valor Inicial do Número Lido)

# Faz o Loop Para Cálculo de Fatorial
loop_fat:
	mul $v0, $v0, $t0   # Multiplica Valor de $v0 e $t0 e Guarda em $v0
	subi $t0, $t0, 1    # Decrementa o Contador (Armazenado em $t0)
	bgtz $t0, loop_fat  # Continua Enquanto $t0(Contador) For Maior que 0

# Retorna Para o Programa
fim_fat:
	jr $ra # Retorna para quem Chamou
	
# Impressão de Resultados e Possíveis Mensagens
# $s1 - Guarda o Resultado Final da Operação de Fatorial
# $t1 - Indica Flag de OverFlow
imprime:
	# Impressão de String
	li $v0, 4 # Comando para Impressão de String
	la $a0, result # Carrega a String Result Para o Registrador a0
	syscall # Exibe a Mensagem na Tela
	
	# Impressão de Inteiro
	li $v0, 1 # Comando para Impressão de Inteiro
	move $a0, $s1 # Move o Resultado ao Registrador a0
	syscall # Imprime o Resultado na Tela

	# Se houver Overflow - Imprime a Mensagem de Aviso
	beq $t1, $zero, fim_programa # Se $t1 == 0, Vá para o Fim do Programa
	# Caso Contrário: Imprima a Mensagem de OverFlow na Tela
	li $v0, 4 # Comando para Impressão de String
	la $a0, overflow_msg # Carrega a Mensagem ao Registrador a0
	syscall # Imprime a Mensagem na Tela

# Encerra o Programa
fim_programa:
	li $v0, 10 # Comando para Encerrar o Programa
	syscall # Encerra o Programa
	#:)
	
