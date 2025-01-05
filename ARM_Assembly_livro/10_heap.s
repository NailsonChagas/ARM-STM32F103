// Heap
/*
Stack (pilha): é uma região de memória usada para armazenar dados temporários, 
como variáveis locais, endereços de retorno de funções e parâmetros. Ela funciona
no estilo LIFO (Last In, First Out), ou seja, o último dado inserido é o primeiro 
a ser removido. A stack cresce para baixo (endereços mais baixos) e é gerenciada
automaticamente pelo compilador ou programador.


Heap (montão): é uma região de memória usada para alocação dinâmica, onde o 
programador pode alocar e desalocar blocos de memória durante a execução do 
programa. A heap cresce para cima (endereços mais altos) e exige que o programador 
implemente ou utilize um sistema para gerenciar essa memória.

--------------------------------------------------------------------------------
|                 STACK	                |                HEAP                  |  
|---------------------------------------|--------------------------------------|
|      Memória estática/temporária	    |         Memória dinâmica             |
|      Gerenciada automaticamente	    |      Gerenciada manualmente          |
|           CRESCE PARA BAIXO*	        |          CRESCE PARA CIMA*           |
|           Rápida e limitada	        |      Mais lenta, mas flexível        |
| Usada para variáveis locais e funções	| Usada para objetos e dados dinâmicos |
--------------------------------------------------------------------------------

*Crescer para baixo: 
Na maioria dos sistemas, a stack começa em um endereço alto na memória (ultimo endereço 
da SRAM) e, à medida que dados são adicionados, o ponteiro da stack (SP) diminui, apontando 
para endereços mais baixos.
Exemplo:
    Antes de adicionar: SP = 0x20001000      (536875008)
    Após adicionar um dado: SP = 0x20000FFC  (536875004)

*Crescer para cima: 
A heap geralmente começa em um endereço baixo na memória (primeiro endereço da SRAM) e, 
conforme novos blocos são alocados, o ponteiro da heap aumenta, movendo-se para endereços 
mais altos.
Exemplo:
	Antes de alocar: Ponteiro da heap = 0x20002000       (536879104)
	Após alocar 32 bytes: Ponteiro da heap = 0x20002020  (536879136)
	
OBS: a stack e a heap devem ter limites bem definidos de modo a impedir a heap colidir
com a stack. 
*/

.syntax unified // especifica que o código será escrito na "Unified Assembly Language"
.global _start


// Definir limites da heap
.equ HEAP_START, 0x20002000
.equ HEAP_END,   0x20003000

/*
r0: endereço de memória do ultimo elemento existente na heap
r1: registrador com o valor de quanto de memória deve ser alocado
r3: endereço do ultimo bloco alocado
*/

_start:
	LDR r0, =HEAP_START   // inicalmente o primero e ultimo tem o mesmo endereço
    MOV r1, #4           // Tamanho do bloco a alocar (4*8bits = 32 bytes)
	
    BL malloc             // Aloca 32 bytes
    // Endereço do bloco alocado será retornado em r0

    // Simula uso do bloco alocado
    MOV r2, #0xAC         // Exemplo: escreve no bloco
    STR r2, [r3] //armazenando #0xAB no bloco de memória alocado

    // Fim
    B .
	
// Função malloc
// Entrada: r1 (tamanho do bloco)
// Saída: r0 (ultimo elemento da heap ou 0 se não houver espaço)
//  	  r3 (endereço inicial do bloco alocado ou 0 se não houver espaço)
malloc:
    LDR r2, =HEAP_END     // endereço final da heap
    CMP r0, r2            // verifica se há espaço suficiente
	MOV r3, r0            // r3 sera o endereço inical do bloco a ser alocado
    ADD r0, r0, r1        // calcula novo ponteiro para o ultimo elemento da heap
    BHI no_memory         // se ultrapassar HEAP_END, pula para erro
    BX lr                 // retorna ao chamador com endereço alocado

no_memory:
    MOV r0, #0            // retorna 0 para indicar falha
	MOV r3, #0 		      // retorna 0 para indicar falha
    BX lr
	
	