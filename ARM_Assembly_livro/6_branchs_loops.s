// Branchs
/*

-------------------------------------------------------------------------------------
|INSTRUÇÃO|                   DESCRIÇÃO                    |         AÇÃO         |
|---------|------------------------------------------------|----------------------|
| BCS/BHS | Branch if Carry Set / Branch if Higher or Same |     Branch if C=1    |
| BCC/BLO |    Branch if Carry Clear / Branch if Lower     |     Branch if C=0    |
|   BEQ   |               Branch if Equal                  |     Branch if Z=1    |
|   BNE   |             Branch if Not Equal                |     Branch if Z=0    |
|   BLS   |           Branch if Lower or Same              | Branch if Z=1 ou C=0 |
|   BHI   |               Branch if Higher                 | Branch if Z=0 ou C=1 |
|  B/BAL  |                Branch Always                   |     Always branch    |                      
|   CMP   |                    Compare                     | rA - rB e ativa flags|
-----------------------------------------------------------------------------------            

Diferentemente do SUBS o CMP não ira armazenar o resultado da subtração

*/

.global _start
_start:
	MOV r0, #8 // MOV r0, #8
	MOV r1, #8 // MOV r1, #0
	
	CMP r1, r0
	BHI loop_1
    BLO loop_2
	B end

// loop com r1 > r0
loop_1:
	ADD r0, r0, #1 // r0 += 1
	
	/*
	  r0 - r1:
      	se r0 < r1:  CPSR N
	  	se r0 > r1:  CPSR C
	  	se r0 == r1: CPSR Z
	*/
	CMP r1, r0 
	BHI loop_1 // se r1 > r0 
	B end  

// loop com r1 < r0
loop_2:
	ADD r1, r1, #1 // r0 += 1
	
	/*
	  r0 - r1:
      	se r0 < r1:  CPSR N
	  	se r0 > r1:  CPSR C
	  	se r0 == r1: CPSR Z
	*/
	CMP r1, r0 
	BLO loop_2 // se r1 < r0 
	B end

end:
	MOV r3, #3
	