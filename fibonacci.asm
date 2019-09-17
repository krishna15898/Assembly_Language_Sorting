.return:
	mov r10, 1
	mov r9,0
	ret

.continue:
	sub sp, sp, 8
	st r0, [sp]
	st ra, 4[sp]
	sub r0, r0, 1
	call .fib
	add r11, r10, r9
	st r11, [sp]
	mov r9, r10
	mov r10, r11
	.print r10
	add r0, r0, 1
	add sp, sp, 8
	ret

.fib:
	cmp r0, 1
	.print r0
	bgt .continue
	beq .return
	ret

.main:
	mov r0, 5
	mov r1, r0
	call .fib
	.print r10
