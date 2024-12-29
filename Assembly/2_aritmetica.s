// opcodes usados:
// - ADD: adição 
// - SUB: subtração
// - MUL: multiplicação
// - ADDS: adicão com flag
// - ADC: soma com carry
// - SUBS: subtração com flag

.global _start 
_start: 
	MOV r0, #5
	MOV r1, #7
	
	ADD r2, r0, r1 // r2 = r0 + r1
	
	SUB r3, r0, r1 // r3 = r0 - r1
	// graças a forma que numeros negativos
	// são armazenados em binario, não é possivel
	// saber se o valor em r3 é um valor muito grande
	// ou se ele é um valor negativo (complemento de 2)
	
	// para dizer que é negativo o registrador cpsr
	// deve ser setado com a flag N (negative - 0x80000000)
	// para isso devemos usar operação aritmetica
	// com flags
	SUBS r4, r0, r1
	
	// o motivo de não se usar SUBS sempre no lugar de SUB
	// é que SUBS executa uma operação a mais
	// o que cria overhead
	// então se o valor nunca resultar em negativo
	// ela não precisa ser usada
	
	MUL r5, r0, r1 // r4 = r0 * r1
	
	MOV r0, #0xFFFFFFFF 
	
	// se somarmos r0 com r1 agora, o valor sera
	// grande demais para caber em um registrador
	// de 32 bits, ou seja, ocorrera um overflow
	// para sabermos se houve um overflow deve ser 
	// checado se cpsr tem a flag C (carry 0x20000000)
	ADDS r2, r0, r1
	
	// em varios casos iremos querer usar o valor do
	// carry, para isso precisamos usar ADC
	ADC r3, r0, r1 // r3 = r0 + r1 + carry (1 ou 0) 
	
	