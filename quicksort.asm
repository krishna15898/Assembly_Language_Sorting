.next:
	add r7, r7, 4			@ increment element to check next
	b .loop

.do:
	add r5, r5, 4
	ld r9, [r5]				@ r9 = arr[i]
	ld r10, [r7]			@ r10 = arr[j]
	st r9, [r7]
	st r10, [r5]
	b .next

.check:
	ld r8, [r7]  			@ r8 is arr[j]
	cmp r6, r8				@ r6 is pivot
	bgt .do
	b .next

.swapfinal:
	add r5, r5, 4			@ shift pivot to its correct position
	ld r11, [r5]
	st r11, [r3]
	st r6, [r5]
	b .continue

.loop:
	cmp r3, r7				@ r3 is high
	bgt .check
	b .swapfinal

.partition:
	sub r5, r2, 4			@ r5 is i-1 (index of smaller element)
	ld r6, [r3]				@ r6 is pivot, [r3] = arr[high]
	mov r7, r2				@ r7 is j (loop variable)
	b .loop
	

.continue:
	sub sp, sp, 16			@ fill low, high, pivot and, ra in stack
	st r2, 0[sp]
	st r3, 4[sp]
	st r5, 8[sp]
	st ra, 12[sp]	

	ld r2, 0[sp]
	ld r3, 8[sp]
	sub r3, r3, 4
	call .quicksort			@ quicksort left half

	ld r2, 8[sp]
	ld ra, 12[sp]
	add r2, r2, 4
	ld r3, 4[sp]
	call .quicksort			@ quicksort right half

	ld ra, 12[sp]
	add sp, sp, 16
	ret 					@ return to prev array

.quicksort:
	cmp r3, r2
	bgt .partition			@ if len(arr) >= 1 make partition
	ret

 .main:
						@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12			@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7			@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  		@ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   		@ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3 	  		@ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  		@ replace 15 with the number to be sorted
	st r1, 20[r0]
						@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0          	@ Starting address of the array
	
						@ Retreive the end address of the array
	mov r3, 5			@ REPLACE 5 WITH N-1, where, N is the number of 						numbers being sorted
	mul r3, r3, 4		@ r3 = 20
	add r4, r2, r3		@ r4 = 20
	
	
 	@ ADD YOUR CODE HERE 

	call .quicksort

 	@ ADD YOUR CODE HERE

	@ Print statements for the result
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

