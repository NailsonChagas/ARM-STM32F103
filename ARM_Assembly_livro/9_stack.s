// Stack in Arm Cortex
/*
	Stack é uma estrura de dados na RAM -> "Primeiro a entrar, ultimo a sair"
	
	PUSH: inserir dado no topo
	POP: retirar dado do topo
	
	Stack Pointer (registrador sp): aponta para o endereço de memória em que 
	esta o topo da pilha

	PUSH {r0, r1, ..., rN} armazena os valores dentro dos registradores na pilha
	POP {r0, r1, ..., rN} armazena os valores do topo da pilha nos resgistradores

	Tabela explicativa na pagina 131 do livro
	
	Exemplos de uso:
		- Funções chamando funções: armazenar o lr
		- Preservar valores de registros
*/

.global _start
_start:
	MOV r0, #1
	MOV r1, #2
	MOV r2, #3
	
	PUSH {r0, r1, r2} // ordem: Primeiro r2 (3), depois r1 (2), e por último r0 (1) -> r0 (1) no topo
	POP {r3, r4, r5} // ordem: Primeiro r3 = 1, depois r4 = 2 e por ultimo r5 = 3
	
	//exemplo de função chamando função
	BL func1
	
	MOV r0, #3
	
	B exit
	
func1:
	PUSH {lr}
	BL func2
	POP {lr}
	MOV r1, #2
	BX lr // volta para _start
	
func2:
	MOV r2, #1
	BX lr // volta para func1
	
exit:
	B exit