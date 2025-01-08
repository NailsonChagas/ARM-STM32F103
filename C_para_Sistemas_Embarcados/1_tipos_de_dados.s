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
	.file	"1_tipos_de_dados.c"
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
	/*
		Inicio da main
	*/
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r1, #1 // volatile int e = 1; 
	movs	r2, #2 // volatile long f = 2; 
	movs	r3, #0 // unsigned char i = 0 -> da declaração do for
	sub	sp, sp, #8 // reserva espaço na stack
	str	r1, [sp] // salva e no stack
	str	r2, [sp, #4] // salva f no stack
.L5:
	// f *= i
	ldr	r1, [sp, #4] // carrega f da stack
	mul	r1, r3, r1 // f *= i
	str	r1, [sp, #4] // armazena o novo valor de f na stack
	
	// e *= i * -1
	ldr	r1, [sp] // carrega e da stack
	rsbs	r2, r3, #0 // r2 = -i (inverte o sinal de i)
	adds	r3, r3, #1 // i++ -> da declaração do for
	mul	r2, r1, r2 // e *= -i
	cmp	r3, #255 // i < 255 -> da declaração do for
	str	r2, [sp] // armazena o novo valor de e no stack
	
	bne	.L5 // i < 255, repete o laço
	
	// return 0
	movs	r0, #0 // Define o retorno da função (0)
	add	sp, sp, #8 // libera espaço reservado do stack pointer
	@ sp needed
	bx	lr // retorna da função main
	.size	main, .-main
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"
