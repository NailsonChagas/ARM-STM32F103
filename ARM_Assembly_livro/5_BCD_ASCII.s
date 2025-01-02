// BCD e ASCII
/*

BCD = Binary Coded Decimal
Forma de representar números decimais no formato binário
No BCD, cada dígito decimal (0 a 9) é representado por um grupo de 4 bits

----------------
| INT | BINARY |
|-----|--------|
|  0  |  0000  |
|  1  |  0001  |
|  2  |  0010  |
|  3  |  0011  |
|  4  |  0100  |
|  5  |  0101  |
|  6  |  0110  |
|  7  |  0111  |
|  8  |  1000  |
|  9  |  1001  |
----------------

- Unpacked BCD: Cada dígito decimal é armazenado em um byte de 8 bits, onde 
apenas os 4 bits menos significativos contêm a informação do número, e os 4 
bits superiores são zeros. Exemplo: "0000 1001" representa o número decimal 9

- Packed BCD: Dois dígitos decimais são compactados em um único byte. 
O dígito menos significativo ocupa os 4 bits inferiores, e o mais significativo, 
os 4 bits superiores. Exemplo: "0101 1001" representa o número decimal 59.

ARM apenas suporta Unpacked BCD

=================================================================================

ASCII = American Standard Code for Information Interchange
cada caractere é representado por 7bits 

exemplo com os numeros decimais:
-------------------------------------------
| KEY | ASCII |  BINARY  | BCD (Unpacked) |
|-----|-------|----------|----------------|
|  0  |   30  | 011 0000 |   0000 0000    |
|  1  |   31  | 011 0001 |   0000 0001    |
|  2  |   32  | 011 0010 |   0000 0010    |
| ... |  ...  |    ...   |       ...      | 
|  9  |   39  | 011 1001 |   0000 1001    |   
-------------------------------------------

quando a tecla 9 é precisonada o que o computador ira ler sera 0x9 (011 1001 )

*/

.global _start
_start:
	MOV r0, #0x39
	
	// convertendo de ASCII para Unpacked BCD
	// #0x39 - #0x30 = #9
	// ou
	// 0011 1001 
	//    AND
	// 0000 1111
	// ---------
	// 0000 1001
	SUB r1, r0, #0x30
	AND r2, r0, #0x0F