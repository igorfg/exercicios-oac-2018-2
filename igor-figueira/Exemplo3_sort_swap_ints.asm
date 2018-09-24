.data
vetor: .word   9, 2, 5, 1, 8, 2, 4, 3, 6, 7
newl:  .string "\n"
tab:   .string "\t"

.text
main:
	la    s0, vetor    # carrega o endereço do vetor
	addi  s1, zero, 10 # carrega o tamanho do vetor
	
	addi a0, s0, 0 # arg1 = endereço do vetor
	addi a1, s1, 0 # arg2 = size
	jal  ra, show
	
	addi a0, s0, 0 # arg1 = endereço do vetor
	addi a1, s1, 0 # arg2 = size
	jal ra, sort
	
	addi a0, s0, 0 # arg1 = endereço do vetor
	addi a1, s1, 0 # arg2 = size
	jal ra, show
	
	jal zero, exit
	
show:
	addi t0, a0, 0   # salva o endereço do vetor em t0
	addi t1, a1, -1  # n-1
	addi t2, zero, 0 # i = 0
	show_loop:
		slt t3, t1, t2              # testa se n < i
		bne t3, zero, fim_show_loop # if n < i fim do loop
		 
		slli t4, t2, 2  # i*4
		add t4, t0, t4  # endereço do vetor + offset
		 
		addi a7, zero, 1 # chamada pra printar um int
		lw   a0, 0(t4)   # v[i]
		ecall
		 
		addi a7, zero, 4 # chamada para printar uma string
		la   a0, tab     # carrega tab para ser imprimido na tela
		ecall
		 
		addi t2, t2, 1      # i++
		jal zero, show_loop # recomeça o loop
	fim_show_loop:
		addi a7, zero, 4 # chamada para printar uma string
		la   a0, newl    # carrega \n para ser imprimido na tela
		ecall
		
		jalr zero, ra, 0 # return
	
swap:
	slli t0, a1, 2  # k*4
	add  t0, t0, a0 # endereço do vetor + offset
	lw   t1, 0(t0)  # temp = v[k]
	lw   t2, 4(t0)  # v[k+1]
	sw   t2, 0(t0)  # v[k] = v[k+1]
	sw   t1, 4(t0)  # v[k+1] = temp
	
	jalr zero, ra, 0   # return
	
sort:
	add  t6, ra, zero # salva o endereco de retorno em t0
	addi t1, a1, -1   # salva n-1
	addi t2, zero, 0  # i = 0
	sort_loop:
		slt  t3, t1, t2            # testa se i > tamanho do vetor-1
		bne  t3, zero, fim_sort_loop # if i > tamanho do vetor-1 sai do loop
		addi t3, t2, -1 # j = i-1
		addi t2, t2, 1  # i++
		swap_loop:
			slt t4, t3, zero        # testa se j < 0
			bne t4, zero, sort_loop # if j < 0 termina o loop
			
			slli t4, t3, 2  # j*4
			add  t4, t4, a0 # endereço do vetor + offset j
			lw   t5, 0(t4)  # vetor[j]
			lw   t4, 4(t4)  # vetor[j+1]
			addi a1, t3, 0  # j sera passado para a funcao
			slt  t4, t5, t4 # if vetor[j+1] > vetor[j]
			bne  t4, zero, sort_loop # if vetor[j+1] > vetor[j] volta para o loop maior
			
			addi t4, t1, 0      # salva o valor de n-1 antes da swap ser chamada
			addi t5, t2, 0      # salva o valor de i antes da swap ser chamada
			jal ra, swap        # chama o metodo swap
			addi t1, t4, 0      # restaura o valor de n-1
			addi t2, t5, 0      # restaura o valor de i
			
			addi t3, t3, -1     # j--
			jal zero, swap_loop # recomeca o inner loop
	fim_sort_loop:
		add  ra, zero, t6 # recupera o endereco de retorno
		jalr zero, ra, 0  # retorna para main
		
exit:
	addi a7, zero, 10
	ecall
			
			
			
			
			 
	
