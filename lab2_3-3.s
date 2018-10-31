.data
	arr1: .byte 0x19, 0x34, 0x14, 0x32, 0x52, 0x23, 0x61, 0x29
	arr2: .byte 0x18, 0x17, 0x33, 0x16, 0xFA, 0x20, 0x55, 0xAC
.text
	.global main
do_sort:

	movs r1, r0
	add  r2, r1, #1
	movs r3, #7
	movs r5, #7
	movs r4, #0
L1:
L2:
	ldrb r6, [r1]
	ldrb r7, [r2]
	cmp r6, r7
	bgt no
	strb r7, [r1]
	strb r6, [r2]

	no:
	mov r1, r2
	add r2, r2, #1
	sub r3, r3, #1
	cmp r3, #0
bne L2
	sub r5, r5, #1
	movs r3, r5
	movs r1, r0
	add r2, r1, #1
	cmp r5, #0
bne L1

	bx lr
main:
	ldrb r0, =arr1
	bl do_sort
	ldrb r0, =arr2
	bl do_sort
L: b L
