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
	.equ GPIOB_IDR, 0x48000410

	.equ GPIOC_MODER, 0x48000800
	.equ GPIOC_OTYPER, 0x48000804
	.equ GPIOC_OSPEEDR, 0x48000808
	.equ GPIOC_PUPDR, 0x4800080C
	.equ GPIOC_IDR, 0x48000810
main:
	BL GPIO_init


LL:
	ldr r2, =GPIOC_IDR
	ldr r2, [r2]
	lsr r2,r2, #13
	and r2,r2, #1
	cmp r2, #0
	bne LL

	ldr r2, =GPIOB_IDR
	ldr r2, [r2]
	lsr r2,r2, #8
	and r2,r2, #15
	cmp r2, #5

	bne nope
	mov r3, #6
	b yes
nope:
	mov r3, #2
yes:

Loop:
	subs r3,r3,#1
	//TODO: Write the display pattern into leds variable
	ldr r0, =leds
	ldr r1, [r0]
	cmp r1, #15
	bne nn1
	movs r1, #0
	b nny
nn1:
	movs r1, #15
nny:
	STRB R1, [R0]

	BL DisplayLED
	BL Delay
	cmp r3,0
	bne Loop

	B LL
KK: b KK

GPIO_init:
	//TODO: Initial LED GPIO pins as output

	//Enable AHB2 clock
	movs r0, #0x6
	ldr  r1, =RCC_AHB2ENR
	str  r0, [r1]

	//Set PA5 as output mode
	movs r0, #0x1540
	ldr  r1, =GPIOB_MODER
	//ldr  r2, [r1]
	mov  r2, #0
	orrs r2, r2, r0
	str  r2, [r1]


	ldr  r1, =GPIOC_MODER
	ldr  r2, [r1]
	and  r2, #0xF0FFFFFF
	str  r2, [r1]

	//Default PA5 is Pull-up output, no need to set

	//movs r0, #0x4000000
	//ldr  r1, =GPIOC_PUPDR
	//str  r0, [r1]

	//Set PA5 as high speed mode
	//movs r0, #0xAA2A80
	//ldr  r1, =GPIOB_OSPEEDR
	//strh r0, [r1]


	movs r0, #0x800
	ldr  r1, =GPIOC_OSPEEDR
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
LLs:
	add R4, #1
	cmp R4, #131072
	bne LLs
	BX LR
