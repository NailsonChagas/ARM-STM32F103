// isso ainda não é totalmente funcional
// mas da uma boa noção de como chamar 
// uma função e voltar para onde foi executada

.global _start
_start:
	MOV r0, #1
	MOV r1, #2
	
	// Branch Link (BL)
	// salva em lr o endereço da proxima  
	// linha em que a função add2 foi chamada
	BL add2
	
	MOV r3, #4

add2:
	r2, r0, r1
	BX lr //branch para a linha salva lr