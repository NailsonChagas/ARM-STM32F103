/*
	.cpu cortex-m3, .arch armv7-m: Estas diretivas indicam que o 
	código será executado em um processador ARM Cortex-M3 com a 
	arquitetura ARMv7-M

	.eabi_attribute: Essas diretivas são atributos do EABI que 
	fornecem informações sobre o ambiente, como a versão e as 
	características do compilador.

	EABI (Embedded Application Binary Interface) é um padrão que 
	define a interface binária entre o código compilado e o sistema
	operacional ou ambiente de execução em sistemas embarcados. 
	O objetivo principal do EABI é garantir a compatibilidade entre
	diferentes partes de um sistema, como o compilador, o linker e
	o código de execução, permitindo que eles se comuniquem de 
	maneira eficiente.
*/
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
	.file	"0_test.c"
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


/*
_exit: Essa função é uma função de saída, utilizada para finalizar 
o programa em ambientes bare-metal (sem sistema operacional). Aqui
a instrução b .L2 faz um loop infinito, indicando que o programa 
não "termina" de forma convencional.
Isso ocorre porque, em sistemas embarcados, o fluxo do programa 
geralmente não é controlado por um sistema operacional (não há 
retorno para o shell ou terminal).
*/
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

// Função main do arquivo 0_test.c
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	
	/*
		movs	r0, #0
		Coloca o valor 0 no registrador r0, que é o registrador 
		usado para retornar valores em funções em ARM

		bx	lr
		Retorno da função.O valor de lr (link register) é o 
		endereço de retorno, e bx lr significa voltar para o 
		endereço de onde a função main foi chamada, finalizando 
		o programa.
	
		Essas duas linhas é o equivalente a return 0
	*/
	movs	r0, #0
	bx	lr
	.size	main, .-main
	.ident	"GCC: (15:10.3-2021.07-4) 10.3.1 20210621 (release)"
