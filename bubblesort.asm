.return:
	ret

.swap:
	ld r9, [r10]
	st r8, [r10]
	st r9, [r7]

.bubblesort:
	cmp r3,r2:			@ r2 is i from 0 to n-1
	beq .return
	mov r5, 0	    	@ r5 is j from 0 to r4 = (n(r3)-i(r2)-1)
	mov r4, r3
	sub r4, r4, r2
	sub r4, r4, 1
	bgt .oloop	
	.oloop:
		cmp r4, r5		
		beq .func			@ if j = n-i-1 increment i and outerloop
		bgt .iloop			@ else j = j + 1 and check for swap
		.func:			
			add r2, r2, 1
			b .bubblesort
		.iloop:
			mul r10, r5, 4
			add r7, r10, 4
			add r7, r7, r0
			add r10, r10, r0
			ld r6, [r10]
			ld r8, [r7]
			cmp r6, r8			@ if swap reqd. swap
			bgt .swap
			
			add r5, r5, 1
			b .oloop
.main:
					@ Loading the values as an array into the registers
	mov r0, 0   
	mov r1, 12		@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7		@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  	@ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   	@ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   	@ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  	@ replace 15 with the number to be sorted
	st r1, 20[r0]
					@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0       @ Starting address of the array
	
					@ Retreive the end address of the array
	mov r3, 6		@ REPLACE 6 WITH N = size of array
	
	@ ADD YOUR CODE HERE
	call .bubblesort

	@ Print statements
	ld r1, 0[r0]
	.print r1
	ld r1, 4[r0]
	.print r1
	ld r1, 8[r0]
	.print r1
	ld r1, 12[r0]
	.print r1
	ld r1, 16[r0]
	.print r1
	ld r1, 20[r0]
	.print r1
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS
