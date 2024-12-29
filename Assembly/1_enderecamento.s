// .word: diz que os valores possuem tamanho da word (32bits)

// a os endereços da tabela de memória
// são incrementos de 4 em 4 octetos
// 1 octeto é 8 bits

// opcodes usados:
// - MOV: opcode responsaval por mover dados entre registradores
//		- MOV destino, origem
//			- destino: registrador de destino
//			- origem: registrador/memória de origem
// - SWI: software interrupt, quando ocorre o O.S vai ler o r7
// - LDR: carregar memória da stack para o registrador

.global _start 
_start: 
	MOV r0, #10 // imediate adressing
	MOV r1, r0 // register direct adressing
	
	// colocando o endereço do primeiro elemento da lista em r2
	LDR r2, =lista // direct adressing
	// neste ponto r2 tem o endereço que o primeiro 
	// elemento da lista tem na memory table
	// no caso 0x18 ou em decimal 24 (exemplo)
	// seria como se r2 estivesse apontando para a tabela de memoria
	
	// coloca o valor do primeiro elemento da lista
	// ou seja, le o valor do endereço 24 da memory
	// table
	LDR r3, [r2] //register indirect adressing
	
	// coloca em r4 o valor do segundo valor da lista
	// soma 4 pois 4 octetos a frente esta o próximo endereço
	LDR r4, [r2, #4] // r2 + 4
	
	// coloca em r4 o valor do terceiro valor da lista
	// soma 8 pois 8 octetos a frente esta o próximo endereço
	LDR r4, [r2, #8] // r2 + 4
	
	// pré incremento: r2 = r2 + 4
	// r2 agora tem o endereço do segundo elemento da lista
	// r5 tera o valor decimal 5
	LDR r6, [r2, #4]! 
	
	// pós incremento: 
	// r5 recebe o valor em r2
	// r2 recebe o endereço r2 + 4
	LDR r6, [r2], #4
	
.data  // todo dado a ser inserido na stack deve ser colocado aqui
lista: // label lista seria como se fosse uma variavel
	.word 4, 5, -9, 1, 0