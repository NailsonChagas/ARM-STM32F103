// Time Delay
/*

Para criar um delay usando ARM Assembly, é preciso saber dois fatos:
- frequencia de clock da CPU
- a maioria das instruções ARM são executadas em apenas um intruction cycle

intruction cycle = 1 / frequencia de clock da CPU

Ex: CPU de 8 MHz 
instruction cycle é 1/8 MHz = 0.125 ms (microsecond) = 125 ns (nanosecond)

Devido a "Branch penalty" (ler página 126) algumas instruções levam mais de um
cliclo para serem executadas. Essas instruções são B e todas suas derivadas (BNE,
BLO, ...), quando a condição não é cumprida leva apenas um ciclo, mas quando é 
cumprida levara 3 ciclos

Ex: Execução de BLO em uma CPU de 8MHz levará 375ns (125ns * 3)

*/


.equ CYCLES_TO_SECOND, 8000 // -> 8000 cycles = 1s / 0.125ms
.global _start
_start:
	// Delay feito considerando uma CPU de 8MHz
	MOV r0, #2 // quantos segundos quero o delay
	
	BL delay
	
	MOV r2, #1
	B exit

delay:
	LDR r1, =CYCLES_TO_SECOND // r1 = 8000
	MUL r1, r1, r0 // r1 *= r0
loop: 
	/*
		A cada execução não final do loop serão passados 4 ciclos
		então ou eu devo subtrair de 4 em 4 de r1, ou dividir r1
		por 4.
		
		A execução final também leva 4 ciclos
	*/

	// SUBS r1, r1, #1 // r1 -= 1 e ativa flag
	SUBS r1, r1, #4 // r1 -= 4 e ativa flag     --> 1 cycle
	BNE loop // se flag não for Z ir para loop  --> 3 cycle / 1 cycle
	BX lr // vai para lr se flag  Z --------------> 3 cycle 
	
exit:
	B exit