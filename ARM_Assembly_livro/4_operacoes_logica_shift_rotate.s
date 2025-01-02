// Instruções lógicas
/*
Executando pelo CPUlator (GNU assembler) para facilitar a execução
Suas diferenças podem ser vistas aqui
https://developer.arm.com/documentation/dui0742/i/migrating-from-armasm-to-the-armclang-integrated-assembler/overview-of-differences-between-armasm-and-gnu-syntax-assembly-code?lang=en

0x00000000 = 00000000000000000000000000000000
0x1A86116B = 00011010100001100001000101101011
0xF459B8DC = 11110100010110011011100011011100
0xFFFFFFFF = 11111111111111111111111111111111

__ __ __ __ __ ... __ __ __ __ __ __ 
31 30 29 28 27 ... 05 04 03 02 01 00

Z -> ativa se e somente se resultado for 0x00000000
N -> tera o mesmo valor que o bit 31
V -> não afetada
C -> ativado quando o bit "sai do range" usando shift (left ou right)

--------------------------------------------------------
INTRUCTION |               DESCRIÇÃO                   |
-----------|-------------------------------------------|
   AND     |             operação "e"                  |
   ORR     |             operação "ou"                 |
   EOR     |         operação "ou exclusivo"           |
   BIC     |  	   limpa os bits expecificados         | 
   ANDS    |       operação "e" e ativa flags          |
   ORRS    |       operação "ou" e ativa flags         |
   EORS    |   operação "ou exclusivo" e ativa flags   |
   BICS    | limpa os bits expecificados e ativa flags |
   MVN     |   negação do valor em rn e move para rd   |
   LSL     |           logical shift left              |
   LSLS    |  logical shift left e ativa flags (C)     |
   LSR     |           logical shift right             |
   LSRS    |  logical shift right e ativa flags (C)    |
--------------------------------------------------------

LSR rA, rB, n_shifts : rA = rB_value / 2^(n_shifts)

LSL rA, rB, n_shifts : rA = rB_value * 2^(n_shifts)
========================================================

Intruções de shift e rotate disponivel no ARM Cortex-M3
(usado no STM32F103)

---------------------------------------
OPERAÇÃO |         DESCRIÇÃO          | 
---------|----------------------------|
  ASR    |   Arithmetic Shift Right   |
  LSL    |      Logic Shift Left      |
  LSR    |      Logic Shift Right     |
  ROR    |        Rotate Right        |
  RRX    | Rotate Right Through Carry |
---------------------------------------

========================================================
ARM só possui rotação para direita
para rotacionar N vezes para esquerda deve 
fazer a RoR 32-N

rotation to the right (ROR)
     original: 00001011 = 11
 1 rotation R: 10000101 = 133 / -123
 2 rotation R: 11000010 = 194 / -62
 3 rotation R: 01100001 = 97
seus usos são mais abstratos que shifts
usado para calculo de hashs e encriptação
=========================================================
Shift e rotation pode ser usado dentro de outras instruções
Exemplos:
- shift r0 para direita 3 vezes e armazena o resultado em r1
MOVS R1, R0, LSR #3

- shift r2 para direita 4 vezes e soma com r1 e armazena em r3
ADDS R3, R1, R2, LSR #4

*/

.global _start
_start:
	LDR r0, =0x00000000
	LDR r1, =0x1A86116B
	LDR r2, =0xF459B8DC
	LDR r3, =0xFFFFFFFF
	
	// r3: 11110100010110011011100011011100 = 4099520732
	// r4: 01111010001011001101110001101110 = 2049760366
	LSR r4, r2, #1
	
	// r3: 11110100010110011011100011011100 = 4099520732
	// r4: 00111101000101100110111000110111 = 1024880183
	LSR r4, r2, #2
	
	// r3: 11110100010110011011100011011100 = 4099520732
	// r4: 00011110100010110011011100011011 =  512440091
	LSR r4, r2, #3
	
	// r1: 00011010100001100001000101101011 = 444993899
	// r5: 00110101000011000010001011010110 = 889987798
	LSL r5, r1, #1
	
	// r1: 00011010100001100001000101101011 = 444993899
	// r5: 01101010000110000100010110101100 = 1779975596
	LSL r5, r1, #2
	
	// r1: 00011010100001100001000101101011 = 444993899
	// r5: 11010100001100001000101101011000 = 3559951192
	LSL r5, r1, #3
	