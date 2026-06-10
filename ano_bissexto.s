.data
    ano1:    .asciiz "Digite o primeiro ano: "
    ano2:    .asciiz "Digite o segundo ano: "
    erro:    .asciiz "Erro: O intervalo nao pode ser maior que 1000 anos!\n"
    ano_bis: .asciiz "O(s) ano(s) nao bissexto(s) entre o primeiro e o segundo ano eh/sao:\n"
    espaco:  .asciiz " "

.text
main:
    # Ler o primeiro ano
    li $v0, 4
    la $a0, ano1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = ano atual (começa em ano1)

    # Ler o segundo ano
    li $v0, 4
    la $a0, ano2
    syscall
    li $v0, 5
    syscall
    move $t1, $v0       # $t1 = ano limite (ano2)


    sub $t2, $t1, $t0   # $t2 = ano2 - ano1 (calcula a diferença)
    li $t3, 1000        # $t3 = limite de 1000 anos
    bgt $t2, $t3, exib_erro # Se a diferença for MAIOR que 1000, vai para o erro
    
    # Exibir a mensagem inicial do resultado
    li $v0, 4
    la $a0, ano_bis
    syscall

filtragem:
    # Se o ano atual ($t0) for maior que o ano limite ($t1), encerra o programa
    bgt $t0, $t1, encerrar

    # Regra 1: Se divisível por 400 -> É bissexto
    rem $t3, $t0, 400
    beq $t3, $zero, eh_bissexto

    # Regra 2: Se divisível por 100 -> Não é bissexto
    rem $t3, $t0, 100
    beq $t3, $zero, imprimir_nao_bissexto

    # Regra 3: Se divisível por 4 -> É bissexto
    rem $t3, $t0, 4
    beq $t3, $zero, eh_bissexto

imprimir_nao_bissexto:
    # Imprime o ano que não é bissexto
    li $v0, 1
    move $a0, $t0
    syscall

    # Imprime um espaço em branco para separar os anos
    li $v0, 4
    la $a0, espaco
    syscall

eh_bissexto:
    # Incrementa o ano atual e volta para o laço
    addi $t0, $t0, 1
    j filtragem
    
exib_erro:
	li $v0, 4
	la $a0, erro
	syscall
	j main

encerrar:
    # Encerrar programa de forma limpa
    li $v0, 10
    syscall

	
