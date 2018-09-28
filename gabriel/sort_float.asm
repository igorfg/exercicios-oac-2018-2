.data
	vetor: .float 5.1, 4.2, 3.3, 2.2, 1.1
	newl:  .string "\n"
	tab:   .string " "
.text

main:
	jal ra, show
	jal ra, sort
	jal ra, newline
	jal ra, show
	jal zero, exit

show:
	la s0, vetor # s0 = endereco do vetor
	li s1, 5     # s1 = tamanho do vetor
	slli t1, s1, 2 # t1 = (tamanho do vetor x 4) 
	add t2, s0, t1 # t2 = valor usado como criterio de parada do loop
	loop_show:
		flw fa0, 0(s0) # a0 = elemento do vetor
		addi s0,s0,4 # incrementando para o próximo elemento do vetor
		
		fcvt.s.w ft5, zero #registrador que vai conter zero em ponto flutuante
		#salvando o valor de a0 pra poder printar dps
		fadd.s ft3, fa0,ft5
		
		# printando tab
		la a0, tab
		li a7, 4
		ecall
		
		# printando um valor inteiro
		fadd.s fa0, ft3, ft5
		li a7, 2
		ecall
		
		# verificando se o tamanho do proximo elemento eh maior que o tamanho total do vetor
		bltu s0, t2, loop_show
	ret
	
sort:
	la s0, vetor # s0 = endereco do vetor
	addi t3,s0,0 # endereco inicial do vetor
	li s1, 5     # s1 = tamanho do vetor
	slli t1, s1, 2 # t1 = (tamanho do vetor x 4) 
	add t2, s0, t1 # t2 = valor usado como criterio de parada do loop
	loop_sort:
		flw fa0, 0(s0) # a0 = elemento do vetor
		
		addi s2, s0, -4 # s2 = endereco do vetor - 1
		sub_loop: # loop para simular insertion sort
		blt s2, t3, fora_do_range # conferindo se o endereco do primeiro elemento nao eh menor que o endereco incial do vetor(fora do range)
		#addi s3, zero, 0 # zerando s3
		flw fa1, 0(s2)
		
		#verificando se o elemento+1 eh maior q o elemento atual de a1
		addi t4, s2, 4 # k+1
		flw ft5, 0(t4)
		
		addi t6,zero,0
		flt.s t6, fa1, ft5
		blt zero,t6, continua_sem_swap
		#faz swap
		fsw ft5, 0(s2)
		fsw fa1, 0(t4)		
		
	continua_sem_swap:	
		addi s2, s2, -4 
		bge s2, t3, sub_loop
		#li s1, 5     # s1 = tamanho do vetor
		
	fora_do_range:
		addi s0,s0,4 # incrementando para o próximo elemento do vetor
		# verificando se o tamanho do proximo elemento eh maior que o tamanho total do vetor
		bltu s0, t2, loop_sort
	ret
	
newline:
	li a7, 4
	la a0, newl
	ecall
	
	ret
	
exit:
	li a7, 10
	ecall
