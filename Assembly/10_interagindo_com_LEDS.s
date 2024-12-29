// interagindo com periféricos
// https://cpulator.01xz.net/?sys=arm-de1soc
.equ SWITCHS, 0xff200040 // endereço de memória do switch
.equ LEDS,    0xff200000 // endereço de memória do LED

.global _start
_start:
	// r0 terá o endereço de memória de SWITCHS
	LDR r0, =SWITCHS
	
	// r1 tera o valor selecionado no switch
	// r1 = _  _  _  _  _  _  _  _  _  _
	//      2⁹ 2⁸ 2⁷ 2⁶ 2⁵ 2⁴ 2³ 2² 2¹ 2⁰   
	LDR r1, [r0] 
	
	// [9,3,1] selecionados:
	// r1 = 1  0  0  0  0  0  1  0  1  0 -> 0x0000020a
	
	// [3, 1] selecionados
	// r1 = 0  0  0  0  0  0  1  0  1  0 -> 0x0000000a
	
	// r0 terá o endereço de memória de LED
	LDR r0, =LEDS
	
	// salva o valor de r1 no endereço de memória r0
	STR r1, [r0] 
	
	B _start
	