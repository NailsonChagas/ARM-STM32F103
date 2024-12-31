.global _start
_start:
	MOV r0, #0x5
	MOV r1, #0x2
	
	ADD r2, r1, r0 //r2 = r1 + r0
	ADD r2, r2, r1 //r2 = r2 + r1 ou r2 += r1
	
	LDR r3, =0x00000010
	STR r2, [r3] // armazena os 4bytes em r2 no endereço de memória r3
	
	// STRB armazena o byte menos significante de r2
	// em no endereço de memória após r3 (r3 + 4 bytes)
	// 3 bytes não seram alterados: OLD OLD OLD R2
	STRB r2, [r3, #4]
	
	// STRH armazena o byte menos significante de r2
	// em no endereço de memória (r3 + 8 bytes)
	// 2 bytes não seram alterados: OLD OLD R2 R2
	STRB r2, [r3, #8]
	
	// LDRB ira carregar r0 com o byte menos significante
	// no endereço de memória após r3 (r3 + 4 bytes)
	// os 3 primeiros bytes seram zerados
	LDRB r0, [r3, #4]

	// LDRH ira carregar r1 com os 2 bytes menos significantes
	// no endereço de memória após r3 (r3 + 4 bytes)
	// os 2 primeiros bytes seram zerados
	LDRH r1, [r3, #4]
	

	MOV r7, #1 // Número da syscall 'exit' no ARM Linux
	SVC #0 // Chamada ao sistema (Supervisor Call)