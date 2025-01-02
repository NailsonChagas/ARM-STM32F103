// Subroutine (função)
/*
Uma subrotina é uma sequência de instruções que realiza uma tarefa específica 
e pode ser chamada em diferentes pontos do programa.
No código abaixo, a subrotina é a função 'pow', que calcula a potência de um 
número (r0^r1) usando multiplicações repetidas.

A função 'pow' recebe dois parâmetros:
- r0: a base (valor para ser elevado).
- r1: o expoente (quantas vezes a base será multiplicada).

O resultado da operação é armazenado em r2 e retornado após a execução.

O código chama a subrotina 'pow' com os valores 2 e 3, calculando 2^3, e em seguida retorna para o ponto onde foi chamada para continuar a execução.
*/

.global _start
_start:
	MOV r0, #2        // Carrega 2 em r0 (base)
	MOV r1, #3        // Carrega 3 em r1 (expoente)
	BL pow            // Chama a subrotina pow (r0_value ^ r1_value) e salva a linha em lr
	// Após a execução de pow, o controle retorna aqui
	
	ADD r4, r2, #1    // Incrementa o valor de r2 (resultado de pow) e armazena em r4
	B end             // Vai para o fim do programa

pow:
	MOV r2, #1        // Inicializa o resultado (r2) com 1
	MOV r3, r1        // Inicializa o contador de multiplicações (r3) com o expoente (r1)
loop:
	CMP r3, #0        // Compara o contador com 0
	BEQ done          // Se o contador for 0, sai do loop
	
	MUL r2, r2, r0    // Multiplica o resultado (r2) pela base (r0)
	SUB r3, r3, #1    // Decrementa o contador
	B loop            // Volta ao loop

done:
	BX lr             // Retorna da subrotina (vai para a linha salva em lr)

end:
