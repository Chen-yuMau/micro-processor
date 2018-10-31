.syntax unified
.cpu cortex-m4
.thumb

.data
	leds: .byte 1
.text
.global main
	.equ RCC_AHB2ENR, 0x4002104C
	.equ GPIOB_MODER, 0x48000400
	.equ GPIOB_OTYPER, 0x48000404
	.equ GPIOB_OSPEEDR, 0x48000408
	.equ GPIOB_PUPDR, 0x4800040C
	.equ GPIOB_ODR, 0x48000414
main:
	BL GPIO_init
	MOVS R5, #0
Loop:
	//TODO: Write the display pattern into leds variable
	ldr r0, =leds
	ldr r1, [r0]
	cmp r1, #24
	bne nn1
	movs r1, #8
nn1:
	add  R5, #1
	cmp R5, #9
	bne no0
	movs R5,#1
no0:
	cmp R5, #5
	bge no1
	lsl R1,R1, #1
	b no2
no1:
	lsr R1,R1, #1
no2:
	cmp R5, #1
	bne no3
	add R1, #1
no3:
	cmp R5, #5
	bne no4
	add R1, #8
no4:
	cmp R5, #8
	bne no5
	movs R5, #0
no5:

	STRB R1, [R0]

	BL DisplayLED
	BL Delay
	B Loop
GPIO_init:
	//TODO: Initial LED GPIO pins as output

	//Enable AHB2 clock
	movs r0, #0x2
	ldr  r1, =RCC_AHB2ENR
	str  r0, [r1]

	//Set PA5 as output mode
	movs r0, #0x1540
	ldr  r1, =GPIOB_MODER
	ldr  r2, [r1]
	and  r2, #0xFFFFC03F
	orrs r2, r2, r0
	str  r2, [r1]

	//Default PA5 is Pull-up output, no need to set

	//Set PA5 as high speed mode
	movs r0, #0x800
	ldr  r1, =GPIOB_OSPEEDR
	strh r0, [r1]

	BX LR
DisplayLED :
	//TODO: Display LED by leds
	ldr r0, =leds
	ldr r1, [r0]
	eor r1, r1, 0xf
	ldr r2, =GPIOB_ODR
	lsl r1,r1, #3
	strh r1, [r2]

	BX LR
Delay:
	//TODO: Write a delay 1 sec function
	mov R4, #0
LL:
	add R4, #1
	cmp R4, #131072
	bne LL
	BX LR
