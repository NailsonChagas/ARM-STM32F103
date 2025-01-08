	.cpu cortex-m3
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"3_bitwise_ops.c"
	.text
	.align	1
	.p2align 2,,3
	.global	_exit
	.arch armv7-m
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	_exit, %function
_exit:
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.L2:
	b	.L2
	.size	_exit, .-_exit
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu softvfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	
	// volatile char a = 0x35; // bin: 110101 | dec: 53
	movs	r2, #53
	// volatile char b = 0x0F; // bin: 001111 | dec: 15
	movs	r3, #15
	
	sub	sp, sp, #8	// aloca 8 bytes na stack para as variaveis
	strb	r2, [sp, #2] // armazena 'a' na stack
	strb	r3, [sp, #3] // armazena 'b' na stack
	
	// volatile char c = a & b; // AND 000101 | dec:  5 | hex: 0x05
	ldrb	r3, [sp, #2] // Carrega 'a' da stack
	ldrb	r2, [sp, #3] // Carrega 'b' da stack
	ands	r3, r3, r2 // bitwise AND
	strb	r3, [sp, #4] // guarda resultado 'c' na stack
	
	// volatile char d = a | b; // OR  111111 | dec: 63 | hex: 0x3F
	ldrb	r3, [sp, #2] // Carrega 'a' da stack
	ldrb	r2, [sp, #3] // Carrega 'b' da stack
	orrs	r3, r3, r2 //  bitwise OR
	strb	r3, [sp, #5] // guarda resultado 'd' na stack
	
	// volatile char e = a ^ b; // XOR 111010 | dec: 58 | hex: 0x3A
	ldrb	r3, [sp, #2] // Carrega 'a' da stack
	ldrb	r2, [sp, #3] // Carrega 'b' da stack
	eors	r3, r3, r2 // bitwise XOR
	strb	r3, [sp, #6] // guarda resultado 'e' na stack
	
	// volatile char f = ~a;    // NOT 001010 | dec: 10 | hex: 0x0A
	ldrb	r3, [sp, #2] // Carrega 'a' da stack
	mvns	r3, r3 // bitwise NOT
	uxtb	r3, r3 // Zero extend the result
	strb	r3, [sp, #7] // guarda resultado 'f' na stack
	
	add	sp, sp, #8 // desaloca os 8 bytes da stack
	
	@ sp needed
	bx	lr
	.size	main, .-main
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"