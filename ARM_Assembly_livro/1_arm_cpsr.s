// CPSR (Current Program Status Register) - pg40
// Armazena os status do programa
// Assim como os outros registradores, possui 32bits:
// N  Z  C  V  ... M4 M3 M2 M1 M0
// __ __ __ __ ... __ __ __ __ __ 
// 31 30 29 28 ... 04 03 02 01 00

// Os 4 primeiros bits armazenam o status de 
// algumas operações aritméticas e lógicas: 
// 	- N: negative
//	- Z: zero
//	- C: carry
//	- V: overflow

// algumas operações que causam flags
// INSTRUCTION | FLAGS AFFECTED
//     CMP     |     C, Z, N
//    ANDS     |     C, Z, N
//    ORRS     |     C, Z, N
//    MOVS     |     C, Z, N
//    ADDS     |    C, Z, N, V
//    SUBS     |    C, Z, N, V

// algumas operações que usam as flags
// para trocar de branch
// INSTRUCTION | FLAGS AFFECTING
//     BCS     | branch if C = 1
//     BCC     | branch if C = 0
//     BEQ     | branch if Z = 1
//     BNE     | branch if Z = 0
//     BMI     | branch if N = 1
//     BPL     | branch if N = 0
//     BVS     | branch if V = 1
//     BVC     | branch if V = 0

.global _start

_start:
	MOV r0, #0x00000009C
	MOV r1, #0xFFFFFFF64
	
	// ADD com status
	ADDS r2, r0, r1 // ira ativar a flag Z e C
	
	BEQ zero
	
zero:
	MOV r1, #0
	B _start