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
	.file	"5_set_clean_com_shift.c"
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
	// Função main, ponto de entrada do programa
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.

	// Declaração da variável 'a' como volátil e inicialização com o valor 0x08 (binário: 0000000000001000)
	movs	r3, #8              // r3 = 8
	movw	r2, #28670          // r2 = ~((1 << 15) | (1 << 12) | (1 << 0)) = 0110111111111110
	movs	r0, #0
	sub	sp, sp, #8           // Espaço reservado na pilha
	strh	r3, [sp, #6]        // Armazena o valor inicial de 'a' na pilha
	ldrh	r3, [sp, #6]        // Carrega 'a' da pilha para r3
	sxth	r3, r3              // Sign-extend 'a' para 16 bits

	// Setar os bits 15, 12 e 0 de 'a' (OR bitwise com (1 << 15) | (1 << 12) | (1 << 0))
	orr	r3, r3, #36864       // Setar bits 15 e 12
	orr	r3, r3, #1           // Setar bit 0
	sxth	r3, r3              // Sign-extend para manter coerência
	strh	r3, [sp, #6]        // Atualiza 'a' na pilha com os bits setados

	// Limpar os bits 15, 12 e 0 de 'a' (AND bitwise com ~((1 << 15) | (1 << 12) | (1 << 0)))
	ldrh	r3, [sp, #6]        // Carrega 'a' da pilha para r3
	sxth	r3, r3              // Sign-extend para 16 bits
	ands	r3, r3, r2          // AND bitwise com o valor inverso dos bits
	strh	r3, [sp, #6]        // Atualiza 'a' na pilha com os bits limpos

	// Finalização da função main
	add	sp, sp, #8           // Libera o espaço reservado na pilha
	@ sp needed
	bx	lr                   // Retorna da função
	.size	main, .-main

	// Identificação do compilador usado
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"