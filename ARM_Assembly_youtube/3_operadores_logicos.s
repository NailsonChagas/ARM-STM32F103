// opcodes usados:
// - AND
// - ORR: OR
// - EOR: Exclusive OR (XOR)
// - MVN: move negative

.global _start
_start:
	// #0xFF == #0x000000FF
	MOV r0, #0xFF  // 11111111 = 255
	MOV r1, #22    // 00010110 = 22
	
	AND r2, r0, r1 // 00010110 = 22
	
	ORR r3, r0, r1 // 11111111 = 255
	
	EOR r4, r0, r1 // 11101001 = 233
	
	// para fazer a negação de todo registrador
	//  r5 = negação de r0
	//  r0 = #0x000000FF
	//  r0 = 00000000000000000000000011111111 = 255
	// ~r0 = 11111111111111111111111100000000
	MVN r5, r0 
	
	// para fazer a negação apenas dos bits desejados
	// quero pegar os 8 ultimos bits 
	//   a = #0x000000FF -> 8bits finais = 1 
	//  r0 = 00000000000000000000000011111111
	
	//  r6 = ~r0
	
	//  r6 = 111111111111111111111111|00000000	
	//   a = 000000000000000000000000|11111111
	// AND   ---------------------------------
	//  r6 = 000000000000000000000000|00000000
	
	MVN r6, r0 
	AND r6, r6, #0x000000FF
	
	// AND pode ser usado para selecionar bits especificos
	// colocando 0 nos bits que não queremos selecionar
	