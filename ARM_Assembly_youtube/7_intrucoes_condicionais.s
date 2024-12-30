// instrução condicionais
// ADDLT
// ADDGT
// ADDEQ
// ADDNE
// ...
// MOVGE
// ...

.global _start
_start:
	MOV r0, #2
	MOV r1, #4
	CMP r0, r1
	
	// só ira somar se r0 < r1
	ADDLT r2, r2, #1 // r2 += 1
	
	
	// só ira fazer MOV se r0 > r1
	CMP r1, r0
	MOVGE r2, #0