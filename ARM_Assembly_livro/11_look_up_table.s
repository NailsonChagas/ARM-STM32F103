/*

A seção .data é uma área da memória RAM usada por programas para armazenar dados globais 
ou estáticos inicializados. Esses dados são definidos pelo programador e possuem valores 
atribuídos antes da execução do programa. Quando o programa é carregado na memória, os 
valores da seção .data são copiados da memória de armazenamento permanente (ex.: Flash ou ROM) 
para a RAM, para que possam ser lidos ou modificados durante a execução.

.data não faz parte da HEAP e nem da STACK

*/

.section .data           // Seção de dados
table:
    .word 0              // Quadrado de 0
    .word 1              // Quadrado de 1
    .word 4              // Quadrado de 2
    .word 9              // Quadrado de 3
    .word 16             // Quadrado de 4

.section .text           // Seção de código
.global _start

_start:
    LDR R0, =table       // Carrega o endereço da tabela em R0
    MOV R1, #3           // Índice que queremos buscar (neste caso, 3)
	
	/*
		Como os valores na tabela são do tipo .word, que ocupam 4 bytes, o índice 
		precisa ser multiplicado por 4 para localizar corretamente o valor correspondente 
		na memória.
		
		Busca o valor: R2 = table[R1]
		LSL #2 multiplica R1 por 4 (tamanho de word)
	*/
	
    LDR R2, [R0, R1, LSL #2]  
                             
    B .
