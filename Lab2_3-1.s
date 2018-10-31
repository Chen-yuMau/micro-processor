.syntax unified
	.cpu cortex-m4
	.thumb
.data
	result: .byte 0
.text
	.global main
	.equ X, 0x55AA
	.equ Y, 0xAA55
hamm:
	//TODO
	mov R4, #0

	eor R3, R0, R1

L1:	lsrs R3, R3, #1
	bcc no
	add R4, #1
no:
	cmp R3, #0
	bne L1

	bx lr
main:
	movw R0, #X
	movw R1, #Y
	ldr R2, =result

	bl hamm

	str R4, [R2]
L: B L
