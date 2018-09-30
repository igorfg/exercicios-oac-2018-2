.data
floats:	.float 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17
			   18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 31


.text
MAIN:

	# Carrega 32 floats nos registradores f0-f31
	la t0, floats
	flw f0, 0(t0)
	flw f1, 4(t0)
	flw f2, 8(t0)
	flw f3, 12(t0)
	flw f4, 16(t0)
	flw f5, 20(t0)
	flw f6, 24(t0)
	flw f7, 28(t0)
	flw f8, 32(t0)
	flw f9, 36(t0)
	flw f10, 40(t0)
	flw f11, 44(t0)
	flw f12, 48(t0)
	flw f13, 52(t0)
	flw f14, 56(t0)
	flw f15, 60(t0)
	flw f16, 64(t0)
	flw f17, 68(t0)
	flw f18, 72(t0)
	flw f19, 76(t0)
	flw f20, 80(t0)
	flw f21, 84(t0)
	flw f22, 88(t0)
	flw f23, 92(t0)
	flw f24, 96(t0)
	flw f25, 100(t0)
	flw f26, 104(t0)
	flw f27, 108(t0)
	flw f28, 116(t0)
	flw f29, 120(t0)
	flw f30, 124(t0)
	flw f31, 128(t0) 

	jal ra, STMFD  # Chama o metodo que carrega todos os registradores para a memoria
	jal zero, EXIT


STMFD:
	addi sp, sp, -128   # aloca espaco para 32 words na pilha	
	li   t2, 0x00100200 # valor que deve ser somado a instrucao para modificar o offset do sp e o registrador cujo valor esta sendo guardado na memoria
	addi t3, zero, 25   # a partir do valor do registrador f7, se continuarmos com a mesma soma modificamos o funct3, o que causa uma instrucao invalida
	addi t4, zero, 32   # n = 32
	li   t0, 0x00000E00 # quantidade a ser removida da instrucao antes de passar para a segunda parte  
	
	loop:
		beq zero, t4, fim_loop    # n vai sendo decrementado ate chegar em 0
		bne t3, t4, continua_loop # caso ainda nao tenhamos chegado ao f7, mantemos o valor a ser somado na instrucao
		li t2, 0x02100000         # novo valor a ser somado na instrucao
	
	continua_loop:	
		fsw   ft0, 0(sp)  # instrucao que guarda o valor de um registrador float na pilha
		auipc t5, 0       # grava o endereco de pc
		addi  t5, t5, -4  # pc = pc-4 (auipc nao estava decrementando o offset corretamente)
		lw    t6, 0(t5)   # le o codigo guardado da instrucao	
		add   t6, t6, t2  # modifica o codigo da instrucao
		sw    t6, 0(t5)   # carrega a nova instrucao no endereco
		
		addi t4, t4, -1 # n--
		jal zero, loop
		
	
	fim_loop:   
    jalr zero, ra, 0 # retorna para main
	
	
EXIT:
	addi a7, zero, 10
	ecall
