// loops com branchs

// o código abaixo ira percorrer a lista
// e somar seus elementos em r2

.global _start

// definindo a constante endlist
// hex aaaaaaaa indica que a memória esta vazia
.equ endlist, 0xaaaaaaaa

// no mundo real não seria assim pois usar 
// memória não alocada é imprevisivel
// uma forma de resolver isso é colocar
// um simbolo conhecido no final da lista

_start:
	MOV r2, #0

	// armazenando o endereço do primeiro elemento
	// da lista em r0
	LDR r0, =list
	LDR r3, =endlist
	
	// armazenar o valor do primeiro elemento da lista
	// em r1
	LDR r1, [r0]
	
	ADD r2, r2, r1
	
	
loop:
	// carrega em r1 o próximo elemento da lista
	LDR r1, [r0, #4]!
	
	CMP r1, r3
	BEQ exit //caso r1 == r3 sair do loop
	
	ADD r2, r2, r1
	
	// se chegar aqui
	// Branch Always para o inicio do loop
	BAL loop
	
exit: //apenas existe para sair do loop

.data
list:
	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10