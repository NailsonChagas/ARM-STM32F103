// 1. funções e subrotinas precisam fazer calculos
// 2. para fazer calculos precisamos dos registradores
// 3. numero de registros são limitados
// 4. havera momentos que teremos que usar registradores 
// que já estão sendo usados fora da função dentro de uma função
// 5. para isso precisaremos armazenar o valor do registrador 
// na memória, usar ele dentro da função, e retornar o valor
// da memória para ele
// 6. isso cria o conceito de variaveis locais que após
// serem usadas dentro das funções são dealocadas

.global _start
_start:
	// supondo que todos os registros estão ocupados

	MOV r0, #1
	MOV r1, #3
	
	// coloca r1 no topo da pilha
	// coloca r0 no topo da pila
	// no final estara na ordem r0 -> r1
	PUSH {r0, r1}
	
	BL get_value
	
	// pega o topo da pilha e põe em r0
	// pega o topo da pilha e põe em r1
	POP {r0, r1}
	
	// desvio incondicional
	B end
	
get_value:
	MOV r0, #5
	MOV r1, #7
	ADD r2, r0, r1
	BX lr
	
end: