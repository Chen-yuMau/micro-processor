.syntax unified
	.cpu cortex-m4
	.thumb
.data
.text
	.global main
	.equ N, 20
fib:
	//
L1:
	add R3, R1, R2
	mov R1, R2
	mov R2, R3

	subs R0, R0, #1

	cmp R0, #0
	bgt L1

	mov R4, R1
	bx lr
main:
	movs R0, #N
	movs R1, #1
	movs R2, #0

	cmp R0, 1
	blt outarange
	cmp R0, 100
	bgt outarange
	bl fib
	b end
outarange:
	movs R0, #-1
	b end
	cmp R4, #0
	bgt end
	movs R4, #-2
end:
L: B L
