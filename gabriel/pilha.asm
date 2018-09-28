.data

.text

	addi sp,sp,-12  # espaço p 3 words na pilha
	sw t1,8(sp)	# empilha t1
	sw t0,4(sp)     # empilha t2
	sw s0,0(sp)	# empilha t3