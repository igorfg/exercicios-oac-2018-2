.data

.text

	#mv t0, t1          t0 = t1
	#not t0,t1          t0 = !t1
	#j Label            PC=Label
	#li t0,0x123        t0=0x00000123
	#li t0,0xDEADBEEF   t0=0xDEADBEEF obs.: DEADC EEF
	#la t0,Label        t0=Label
	#call Label	    ra=PC+4 PC=Label
	#ret                PC=ra
	
	#t0=t1
	addi t0, t1, 0  
	
	# not t0
	addi t0, zero, 255 
	xori t1, t0, -1
	addi t1, t1, 1
	
	#j Label
	jal zero, continue

continue:

	#li t0,0x123 
	addi t0, zero, 0x123
	
	
	#li t0,0xDEADBEEF
	lui t2, 0xFFFDEADC
	addi t2, t2, 0xFFFFFEEF
	
	#call Label
	jal ra, continue2
	
continue2:
	
	#ret
	jalr zero, ra, 0
	

	
	
	

	
	
	