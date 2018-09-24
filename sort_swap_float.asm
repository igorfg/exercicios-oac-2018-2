.data
array: .float 100, 99, 98, 97, 96, 95, 94, 93, 92, 91,
     	       90, 89, 88, 87, 86, 85, 84, 83, 82, 81,
               80, 79, 78, 77, 76, 75, 74, 73, 72, 71,
               70, 69, 68, 67, 66, 65, 64, 63, 62, 61,
               60, 59, 58, 57, 56, 55, 54, 53, 52, 51,
           	   50, 49, 48, 47, 46, 45, 44, 43, 42, 41,
               40, 39, 38, 37, 36, 35, 34, 33, 32, 31,
               30, 29, 28, 27, 26, 25, 24, 23, 22, 21,
               20, 19, 18, 17, 16, 15, 14, 13, 12, 11,
               10,  9,  8,  7,  6,  5,  4,  3,  2,  1
newl:  .string "\n"
tab:   .string "\t"

.text
main:
	la    s0, array     # loads *array
	addi  s1, zero, 100 # loads array size
	
	addi a0, s0, 0 # arg1 = *array
	addi a1, s1, 0 # arg2 = array size
	jal  ra, show
	
	addi a0, s0, 0 # arg1 = *array
	addi a1, s1, 0 # arg2 = array size
	jal ra, sort
	
	addi a0, s0, 0 # arg1 = *array
	addi a1, s1, 0 # arg2 = array size
	jal  ra, show
	
	jal zero, exit
	
show:
	addi t0, a0, 0   # saves array address
	addi t1, a1, -1  # saves n-1
	addi t2, zero, 0 # i = 0
	show_loop:
		slt t3, t1, t2              # i > n?
		bne t3, zero, end_show_loop # yes. end loop
		 
		slli t4, t2, 2  # i*4
		add t4, t0, t4  # array address + offset
		 
		addi a7, zero, 2 # print float
		flw  fa0, 0(t4)  # v[i]
		ecall
		 
		addi a7, zero, 4 # print string
		la   a0, tab     # loads tab
		ecall
		 
		addi t2, t2, 1      # i++
		jal zero, show_loop # loops again
	end_show_loop:
		addi a7, zero, 4 # print string
		la   a0, newl    # load \n
		ecall
		
		jalr zero, ra, 0 # return	


sort:
	addi t0, a0, 0   # save array's address
	addi t1, a1, -1  # save n-1
	addi t6, ra, 0   # save return address on t6
	addi t2, zero, 1 # t = 1
	
	while:
		 beq  t2, zero, end_while # while t == 1
		 addi t2, zero, 0         # t = 0
		 addi t3, zero, 0         # i = 0
		 for:
		 	bge  t3, t1, while # i == n-1?
		 	slli t4, t3, 2     # i*4
		 	add  t4, t4, t0    # vector's address + offset
		 	flw  ft0, 0(t4)    # loads v[k]
		 	flw  ft1, 4(t4)    # loads v[k+1]
		 	
		 	fle.s t4, ft0, ft1      # v[i] <= v[i+1]?
		 	bne   t4, zero, nextfor # don't call swap if relative positions are correct
		 	
		 	addi a0, t0, 0   # arg1 = array address
		 	addi a1, t3, 0   # arg2 = i
		 	jal  ra, swap    # swap(v[], i)
		 	addi t2, zero, 1 # t = 1 since a swap occurred
		 	
		 nextfor:
		 	addi t3, t3, 1 # i++
		 	jal  zero, for # goes to begining of loop
	end_while:
	jalr zero, t6, 0 # returns to callee
		 
swap:
	slli a1, a1, 2   # k *= 4
	add  a0, a0, a1  # adds base address
	flw  ft0, 0(a0)  # read v[k]
	flw  ft1, 4(a0)  # read v[k+1]
	fsw  ft0, 4(a0)  # v[k+1] = v[k]
	fsw  ft1, 0(a0)  # v[k] = v[k+1]
	jalr zero, ra, 0 # returns to sort
	
exit:
	addi a7, zero, 10
	ecall
