.data
	my_label: .word 2147483647, 1 #obs.: maior valor inteiro representavel por 1 registrador.
	
.text

	la s0, my_label
	lw a0, 0(s0)
	li a7, 1
	ecall
	
	li t1, -2147483647
	
	