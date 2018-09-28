.data
	msg: .string "digite um nro: "
	msg2: .string "soma =  "
.text

main:
	li a7, 4
	la a0, msg
	ecall

	li a7, 5
	ecall
	
	jal ra, soma
	
	addi s0, a0, 0
	
	li a7, 4
	la a0, msg2
	ecall
	
	addi a0, s0, 0
	li a7, 1
	ecall
	
	jal zero, exit
	
soma:
	addi t0,zero,1  	# s0 = 1
	
	blt a0, t0, fim_soma
	
	addi sp, sp, -8
	
	sw a0, 4(sp)
	sw ra, 0(sp)
	
	addi a0, a0, -1

	jal ra, soma
	
	lw a1, 4(sp)
	lw ra, 0(sp)
	
	addi, sp, sp, 8
	add a0,a0,a1
	
	ret
	
fim_soma:
	addi a0,zero,0
	ret
	
exit:
	li a7,10
	ecall