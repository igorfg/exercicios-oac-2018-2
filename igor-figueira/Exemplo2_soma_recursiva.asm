.data
	inputMessage:   .string "Digite n: "
	outputMessage1: .string "Soma("
	outputMessage2: .string ")="
	newLine:        .string "\n"

.text

main:
	addi a7, zero, 4      # chamada de print string
	la   a0, inputMessage # printa mensagem de input no console
	ecall
	
	addi a7, zero, 5 # le um int e o grava em a0
	ecall
	
	addi s0, a0, 0   # salva o valor de n
	
	addi a7, zero, 4
	la   a0, outputMessage1 # printa primeira parte da mensagem de output
	ecall
	
	addi a7, zero, 1 # printa n na tela
	addi a0, s0, 0
	ecall
	
	addi a7, zero, 4
	la   a0, outputMessage2 # printa segunda parte da mensagem de output na tela
	ecall	
	
	addi a0, s0, 0   # restaura o valor de n antes da chamada da funcao 
	jal  ra, soma    # chama o metodo soma
	addi a7, zero, 1 # printa o resultado da soma na tela
	ecall
	
	addi a7, zero, 4
	la   a0, newLine # printa \n na tela
	ecall	
	
	jal zero, exit
	
# Procedimento que realiza soma recursiva
soma:
	addi sp, sp, -8 # aloca espaco para 2 words na pilha
	sw   ra, 4(sp)  # guarda o endereco de retorno na pilha
	sw   a0, 0(sp)  # guarda o numero atual na pilha
	
	slti t0, a0, 1           # if a0 < 1
	beq  t0, zero, recursiva # if >= 1 va para recursiva
	add  a0, zero, zero      # valor de retorno eh zero
	addi sp, sp, 8           # free em duas words da pilha
	jalr zero, ra, 0         # retorna para PC+4
	
	recursiva:
		addi a0, a0, -1 # a0 -= 1
		jal  ra, soma
	
		lw   t0, 0(sp)    # recupera o valor de n
		lw   ra, 4(sp)    # recupera o valor de retorno
		addi sp, sp, 8    # 2 itens retirados da pilha
		add  a0, a0, t0   # soma += soma(n-1)
		
		jalr zero, ra, 0  # retorna para PC+4
	
exit:
	addi a7, zero, 10
	ecall