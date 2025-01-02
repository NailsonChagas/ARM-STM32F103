; Instruções aritméticas
; Obs: lidando apenas com unsigned numbers
;
;Unsigned data:
;   SIZE  | BITS |    DECIMAL   |  HEXADECIMAL | LOAD/STORE |
;---------|------|--------------|--------------|------------|
;   byte  |   8  |     0~255    |    0~0xFF    | LDRB/STRB  |
;half-word|  16  |    0~65535   |   0~0xFFFF   | LDRH/STRH  |
;   word  |  32  | 0~4294967295 | 0~0xFFFFFFFF |  LDR/STR   |
;
;Instruções que não alteram flag: 
; INSTRUÇÃO |          DESCRIÇÃO            |
;-----------|-------------------------------|
;    ADD    |           Adição              |
;    ADC    |      Adição com o carry       |
;    SUB    |          Subtração            |
;    SBC    |    Subtração com o carry      |
;    RSB    |      Subtração reversa        |
;    RSC    | Subtração reversa com o carry |
;
;Instruções que alteram flag: 
;  INSTRUÇÃO |                 DESCRIÇÃO                   |
;------------|---------------------------------------------|
;    ADDS    |           Adição e ativa flags              |
;    ADCS    |      Adição com o carry e ativa flags       |
;    SUBS    |          Subtração e ativa flags            |
;    SBCS    |    Subtração com o carry  e ativa flags     |
;    RSBS    |      Subtração reversa e ativa flags        |
;    RSCS    | Subtração reversa com o carry e ativa flags |
;
;Flags do CPSR (afetadas por operações aritméticas)
; FLAG | DESCRIÇÃO | BIT |
;------|-----------|-----|
;   N  | negativo  |  31 |
;   Z  |   zero    |  30 |
;   C  |   carry   |  29 |
;   V  | overflow  |  28 |
;
;Multiplicação
; INSTRUÇÃO |             TAMANHO MÁXIMO DO RESULTADO            |                     USO                   |
; ----------|----------------------------------------------------|-------------------------------------------|
;    MUL    |               res: 32 bits (32bits)                |               MUL res, rA, rB             |
;   UMULL   | res_lower_32, res_high_32: 32bits, 32bits (64bits) |  UMULL res_lower_32, res_high_32, rA, rB  |
;    MLA	|               res: 32 bits (32bits)                |               MUL res, rA, rB, rC         |
;   UMLAL   | res_lower_32, res_high_32: 32bits, 32bits (64bits) |  UMLAL res_lower_32, res_high_32, rA, rB  |
;MUL res, rA, rB  res = rA_value * rB_value
;UMULL res_lower_32, res_high_32, rA, rB  res_lower_32, res_high_32 = rA_value * rB_value 
;MLA res, rA, rB, rC  res = (rA_value * rB_value) + rC	
;UMLAL res_lower_32, res_high_32, rA, rB  res_lower_32, res_high_32 = (rA_value * rB_value) + res_lower_32,res_high_32

;Divisão
;UDIV res, rA, rB (res = rA_value/rB_value)
	
; Example 3-3: Write a program to calculate the total sum of five words of data. Each data value
; represents the mass of a planet in integer. The decimal data are as follow: 1000000000, 2000000000,
; 3000000000, 4000000000, and 4100000000. The results should be in R9:R8

; A soma desses valores (14100000000) ultrapassa o 
; valor maximo que pode ser armazenado em 32bits
; (4294967295). Então será dividido o resultados 
; em duas words (32bits)
PLANETA1 EQU 1000000000
PLANETA2 EQU 2000000000
PLANETA3 EQU 3000000000
PLANETA4 EQU 4000000000
PLANETA5 EQU 4100000000
	
	EXPORT main
	AREA operacoes_aritmeticas, CODE, READONLY
main
	LDR r0, =PLANETA1
	LDR r1, =PLANETA2
	LDR r2, =PLANETA3
	LDR r3, =PLANETA4
	LDR r4, =PLANETA5
	
	MOV r8, #0 ;32 bits menos significativos
	MOV r9, #0 ;32 bits mais significativos
	
	ADDS r8, r8, r0 ; r8 += r0
	ADC r9, r9, #0 ; r9 += (0 + carry) --> caso não tenha carry sera 0
	ADDS r8, r8, r1 ; r8 += r1
	ADC r9, r9, #0 ; r9 += (0 + carry)
	ADDS r8, r8, r2 ; r8 += r2
	ADC r9, r9, #0 ; r9 += (0 + carry)
	ADDS r8, r8, r3 ; r8 += r3
	ADC r9, r9, #0 ; r9 += (0 + carry)
	ADDS r8, r8, r4 ; r8 += r4
	ADC r9, r9, #0 ; r9 += (0 + carry)
	
HERE B HERE	
	END