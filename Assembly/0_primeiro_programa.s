// como o tutor do video usado considera que esta rodando com um O.S
// o r7 sera um registrador especial usado para se comunicar
// com o sistema operacional
// r7 ira armazenar informações sobre system calls 

// opcodes usados:
// - MOV: opcode responsaval por mover dados entre registradores
//		- MOV destino, origem
//			- destino: registrador de destino
//			- origem: registrador/memória de origem
// - SWI: software interrupt, quando ocorre o O.S vai ler o r7

.global _start // .global diz que o inicio é a label _start
_start: // Label, similar a uma função em linguagens de alto nivel
	MOV r0, #30 // colocando a constante inteira 30 no registrador r0
	MOV r1, #0x0A // colocando a constante hexadecimal 0A no registrador r1
	
	MOV r7, #1 // 1 em r7 indica ao O.S que quero fechar o programa
	SWI 0 // chama uma interrupção no O.S para que ele rode a syscall feita em r7