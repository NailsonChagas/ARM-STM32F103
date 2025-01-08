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
	.file	"2_stdint.c"
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}

    /*
        volatile int8_t a = 1;  //  8 bits (1 bytes)
        volatile int16_t b = 2; // 16 bits (2 bytes)
        volatile int32_t c = 3; // 32 bits (4 bytes)
        volatile int64_t d = 4; // 64 bits (8 bytes)
    */
	mov	ip, #2
	mov	lr, #1
	movs	r1, #3
	movs	r2, #4
	
    /*
        Não tenho certeza do por que foi utilizado
        `ip` e `lr` pelo compilador enquanto `r3` 
        recebe 0.
    */
    movs	r3, #0

    /*
        r0 recebe o retorno da função, que é 0, isto
        faz sentido, mas como não tem `bx lr` no fim 
        da função não sei o que esta acontendo. Segundo
        o ChatGPT `LDR PC, [SP], #4` esta pegando o `lr`
        da stack e passando para o `pc` diretamente. Isso
        seria o equivalente a fazer `bx lr`
    */
	movs	r0, #0

    /*
        Variaveis usam 15 bytes, mas devido ao problema de
        alinhamento 20 bytes são reservados na stack

    */
	sub	sp, sp, #20

    /*
        Guarda `a` (1 byte), `b` (2 bytes), 
        `c` (4 bytes) e `d` (8 bytes) na stack
    */
	strb	lr, [sp, #1]
	strh	ip, [sp, #2]	@ movhi
	str	r1, [sp, #4]
	strd	r2, [sp, #8]

    /*
        20 bytes são liberados da stack
    */
	add	sp, sp, #20
    
    /*
        `LDR PC, [SP], #4` esta pegando o `lr`
        da stack e passando para o `pc` diretamente
        Isso seria o equivalente a fazer `bx lr`
    */
    @ sp needed
	ldr	pc, [sp], #4
	.size	main, .-main
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"
