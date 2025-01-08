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
	.file	"4_set_clean_bits.c"
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
	@ link register save eliminated.

    /*
        volatile short int a = 0xF7E8;           (2 byte) // dec: 63464
        volatile short int set_mask = 0x5;       (2 byte) // dec: 5 
        volatile short int clean_mask = 0xFE3F;  (2 byte) // dec: 65087 
    */
	movw	r1, #63464 // a
	movs	r2, #5 // set_mask
	movw	r3, #65087 // clean_mask

    // param 0 a ser retornado na main
	movs	r0, #0
	
    /*
        O total de memória usado pelas variaveis é de 10bytes mas devido 
        ao problema de alinhamento o compilador aloca 16 bytes 
    */
    sub	sp, sp, #16

    /*
        armazena 'a', 'set_mask' e 'clean_mask' na stack
    */
	strh	r1, [sp, #6]	@ movhi // a
	strh	r2, [sp, #8]	@ movhi // set_mask
	strh	r3, [sp, #10]	@ movhi // clean_mask
	
    /*
        volatile short int set = a | set_mask;
    */
    ldrh	r2, [sp, #6] // carrega 'a' da stack
	ldrh	r3, [sp, #8] // carrega 'set_mask' da stack
	orrs	r3, r3, r2 // r3 = r3 | r2 ou r3 |= r2 
	sxth	r3, r3 // Signed extend halfword: estende o valor de 16 bits para 32 bits
	strh	r3, [sp, #12]	@ movhi // armazena o resultado de `a | set_mask` na stack
	
    /*
        volatile short int clean = a & clean_mask;
    */
    ldrh	r2, [sp, #6] // carrega 'a' da stack
	ldrh	r3, [sp, #10] // carrega 'clean_mask' da stack
	ands	r3, r3, r2 // r3 = r3 & r2 ou r3 &= r2
	sxth	r3, r3  // Signed extend halfword: estende o valor de 16 bits para 32 bits
	strh	r3, [sp, #14]	@ movhi // armazena o resultado de `a & clean_mask` na stack

	add	sp, sp, #16 // desaloca os 16 bytes da stack
	@ sp needed
	bx	lr
	.size	main, .-main
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"
