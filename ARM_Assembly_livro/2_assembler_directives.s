; ARM Assembler directives
; Instruções -> diz a CPU o que fazer
; Assembler directives -> diz ao Assembler o que fazer
; Essas diretivas são do assembler usado no Keil ou no ARMASM
; Não ira funcionar com o GNU Assembler (https://cpulator.01xz.net/?sys=arm-de1soc) 
; O que me fez aprender uma coisa importante, diferentes assemblers teram diferentes diretivas	

; DIRETIVA  | DESCRIÇÃO
; -----------------------------------------------------------
;   AREA    | Nova área de código ou dados
;   END     | Final do código fonte
;   EQU     | Associa um contante numérica com um nome
;   INCLUDE | Inclui conteudo de um arquivo no programa atual
;   EXPORT  | Diz que um nome ou simbolo sera usado por outro módulo (arquivo)
;   IMPORT  | Diz que um nome ou simbolo presentre em outro módulo será usado

; AREA: fala para o assembler definir uma nova seção de memória
; segue o seguinte formato:
; AREA nome_da_seção, atributo, atributo, ...
; Atributos comumente usados:
; 1. CODE: atributo usado para determinar que uma área
;   sera usada para executar instruções (nosso código), 
;   como possui apenas código é por padrão READONLY
; 2. DATA: atributo usado para determinar uma área da memória
;   sera usada somemente para armazenagem de dados, por padrão
;   é READWRITE. Uma área DATA separa SRAM para ser usada para
;   as variaveis e a stack
; 3. READONLY: determina que a área de memória deve apenas ser lida,
;   todas as seções READONLY usam a memória Flash, e são armazenadas
;   ao lado uma das outras na Flash pelo linker
; 4. READWRITE: determina que a seção de memória pode ser lida e escrita
;   todas seções READWRITE usam a SRAM, e são colocadas uma ao lado da outra
;   pelo linker
; 5. ALIGN: atributo que indica como a memória deve ser alocada de acordo
;   com os endereços.
; Ex:
; 1. AREA MY_ASM_PROG1, CODE, READONLY
;    Define uma área de código em que a memória pode apenas ser lida

	EXPORT main
	AREA programa, CODE, READONLY
main
	MOV r0, #0x25
	MOV r1, #0x34
	ADD r2, r0, r1
	
HERE B HERE
	END