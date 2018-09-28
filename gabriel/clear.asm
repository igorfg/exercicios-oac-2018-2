.data

	array: .byte 1,2,3,4

.text

main:

	la t2, array
	
	clear1: mv t0, zero
	
	loop1:  slli t1, t0, 2
		add t2, a0, t1
		sw zero, 0(t2)
		addi t0, t0, 1
		blt t0, a1, loop1
		ret