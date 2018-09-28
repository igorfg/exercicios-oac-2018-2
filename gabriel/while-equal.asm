
.data

	save: .byte 2, 2, 3, 2, 2

.text
#save = s6
#k = s5
#i = s3
	la s6, save
	li s5, 2
Loop:
	slli t1,s3,2
	add t1,t1,s6
	lw t0,0(t1)
	bne t0,s5, Exit
	addi s3,s3,1
	j Loop
Exit:

	li a7, 10
	ecall
