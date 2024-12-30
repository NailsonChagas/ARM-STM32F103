// usando 8 bits para facilitar visualização

// shift to the left (LSL)
//  original: 00001010 = 10
// 1 shift L: 00010100 = 20
// 2 shift L: 00101000 = 40
// 3 shift L: 01010000 = 80
// como pode ser observado, a cada shift left
// o valor é multiplicado por 2^(N_shifts)
// sendo esta multiplicação um de seus usos

// shift to the right (LSR)
//  original: 00001010 = 10
// 1 shift R: 00000101 = 5
// 2 shift R: 00000010 = 2 --> 2.5
// 3 shift R: 00000001 = 1
// como pode ser observado, a cada shift right
// o valor é dividido por 2^(N_shifts)
// sendo esta divisão um de seus usos

// rotation to the right (ROR)
//     original: 00001011 = 11
// 1 rotation R: 10000101 = 133 / -123
// 2 rotation R: 11000010 = 194 / -62
// 3 rotation R: 01100001 = 97
// seus usos são mais abstratos que shifts
// usado para calculo de hashs e encriptação

// ARM só possui rotação para direita
// para rotacionar N vezes para esquerda deve 
// fazer a RoR 32-N

.global _start
_start:
	MOV r0, #10 // r0 = 00001010 = 10
	LSL r0, #1  // r0 = 00010100 = 20
	
	MOV r1, #10 // r1 = 00001010 = 10
	LSL r1, #2  // r1 = 00101000 = 40
	
	MOV r2, #10 // r2 = 00001010 = 10
	LSL r2, #3  // r2 = 01010000 = 80
	
	MOV r3, #40 // r3 = 00101000 = 40
	LSR r3, #1  // r3 = 00010100 = 20
	
	MOV r4, #40 // r4 = 00101000 = 40
	LSR r4, #2  // r4 = 00001010 = 10
	
	MOV r5, #40 // r5 = 00101000 = 40
	LSR r5, #3  // r5 = 00000101 = 5
	
	MOV r6, r0, LSL #1 // r6 = r0 << 1 = 40
	MOV r6, r6, LSR #1 // r6 = r6 >> 1 = 20
	
	MOV r7, #11 // r7 = 00000000000000000000000000001011 = 11
	ROR r7, #1  // r7 = 10000000000000000000000000000101 = 2147483653 / -2147483643
	