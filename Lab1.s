.syntax unified
	.cpu cortex-m4
	.thumb
.data
	X: .word 5
	Y: .word 10
	Z: .word 0
.text
	.global main
	.equ ten, 0xA
main:
	ldr r0, =X
	ldr r3, [r0]
	ldr r1, =Y
	ldr r4, [r1]
	movs r6, #ten
	muls r3, r3, r6
	adds r3, r3, r4
	str r3, [r0]
	ldr r2, =Z
	subs r5, r4, r3
	str r5, [r2]
L: B L