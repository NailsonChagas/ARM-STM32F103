// BGT Branch if Greater Than
// BGT Branch if Less Than
// BGE Branch if Greater or Equal 
// BLE Branch if Less or Equal 
// BEQ Branch if Equal
// BNE Branch if Not Equal

.global _start
_start:
	MOV r0, #3
	MOV r1, #3
	
	// Como comparar registros?
	// r0 - r1
	// se r0 < r1:  CPSR N
	// se r0 > r1:  CPSR C
	// se r0 == r1: CPSR Z
	CMP r0, r1
	
	// Branch if Greater Than (BGT)
	BGT se_maior // caso seja maior entra nessa branch
	
	// BRANCH ALWAYS: sempre ira para a branch default
	// esta aqui para não entrar nas outras labels
	BAL default

se_maior:
	MOV r2, #1	
	// ao fim vai para default pois executa sequencialmente

default:
	MOV r2, #2