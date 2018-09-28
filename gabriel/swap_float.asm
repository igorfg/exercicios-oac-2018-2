.data
	vetor_float: .float 2.5,3.5

.text

	la s0, vetor_float
	flw ft0, 0(s0)
	addi s1,s0,4
	flw ft1, 0(s1)
	
	swap:
	fcvt.s.w ft3, zero
	fadd.s ft2, ft0, ft3
	fadd.s ft0, ft1, ft3
	fadd.s ft1, ft2, ft3