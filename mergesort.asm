.return:				@ merge sort over, ra goes to next mergesort
	ld ra, 12[sp]
	add sp, sp, 16
	ret

.fillnext:				
    ld r9, [r10]
    st r9, [r8]
    add r10, r10, 4
    add r8, r8, 4
    b .fill

.fill:					
    cmp r3, r8
    bgt .fillnext
    beq .fillnext
    b .return
    
.putBack:				@ put back elements from temp array to original
	mov r1, 789
    mov r8, r2
    mov r10, 400
    b .fill

.fillright:				@ left array over. fill right array in temp array
    cmp r9, r3
    bgt .putBack
    ld r12, [r9]
    st r12, [r10]
    add r10, r10, 4
    add r9, r9, 4
    b .fillright

.fillleft:				@ right array over. fill left array in temp array
    cmp r8, r7
    bgt .putBack
    ld r11, [r8]
    st r11, [r10]
    add r10, r10, 4
    add r8, r8, 4
    b .fillleft

.merge:
    mov r8, r2              @ r8 is left temp pointer
    add r9, r7, 4           @ r9 is right pointer
    mov r10, 400            @ r100 is temp array
    
    .doleft:
        cmp r8, r7			@ if left array is over
        bgt .fillright
        b .doright
        .doright:
            cmp r9, r3			@ if right array is over 
            bgt .fillleft
            b .compare
            .compare:
                ld r11, [r8]		@ compare left to right
                ld r12, [r9]
                cmp r11, r12
                bgt .putright		@ right > left => right is smaller
                b .putleft			@ else left is smaller
                .putright:
                    st r12, [r10]		@ push right to temp array
                    add r10, r10, 4
                    add r9, r9, 4
                    b .doright			@ increment right and  check right
                .putleft:
                    st r11, [r10]		@ push left element
                    add r10, r10, 4	
                    add r8, r8, 4
                    b .doleft			@ increment and check left pointer

.continue:
	
	div r5, r2, 4
	div r6, r3, 4
	add r7, r5, r6
	div r7, r7, 2		@ r7 is partition

	sub sp, sp, 16
	st r5, 0[sp]
	st r6, 4[sp]
	st r7, 8[sp]
	st ra, 12[sp]

	mul r2, r5, 4
	mul r3, r7, 4
	call .mergesort		@ sorting left half

	ld r6, 4[sp]
	ld r7, 8[sp]

	mul r2, r7, 4		@ sorting right half
	add r2, r2, 4
	mul r3, r6, 4
	call .mergesort

	ld r5, 0[sp]
	ld r6, 4[sp]
	ld r7, 8[sp]
	mul r2, r5, 4
	mul r3, r6, 4
	mul r7, r7, 4

	call .merge 		@ merging left and right arrays
	ret

.mergesort:
	cmp r3, r2 			@ if length of array >= 1
	bgt .continue
	ret 

.makeEmptyArray:
	cmp r6, r10
	bgt .do
	beq .do
	ret
	.do:
		st r0, [r10]	@ r0 = 0
		add r10, r10, 4
		b .makeEmptyArray

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

	mov r2, 0          @ Starting address of the array
    mov r3, 5		   @ r3 = N-1
    mul r3, r3, 4       @ r3 = 20
    add r4, r2, r3      @ r4 = 0 + 20 = 20
	@ ADD YOUR CODE HERE

	mov r10, 400		@ making an extra array r10 starting index 400
	add r6, r10, r4		@ r6 = 400+20 {upper limit}
	call .makeEmptyArray

	call .mergesort 

	@ ADD YOUR CODE HERE 
    mov r0, 0

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

