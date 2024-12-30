/*
Esse é Linker Script para o microcontrolador STM32F103C8

- O que é um Linker Script?
R: O arquivo Linker Script contém informações importantes sobre como o 
linker deve organizar o programa na memória.

- O que é o linker?
R: Uma ferramenta que combina vários arquivos objeto gerados pelo 
compilador em um único executável
*/

/* 
ENTRY: define o ponto de entrada do programa, ou seja, o endereço
da primeira instrução a ser executada quando o programa é iniciado
*/
ENTRY(main); /* Neste caso o ponto de entrada sera a branch main */

/*
MEMORY: especifica as áreas de memória disponíveis no microcontrolador

0. () - A região de memória suporta:
- r: leitura
- w: escrita
- x: execução

1. ORIGIN - Conforme a seção 4 (Memory mapping):
- Memória Flash: tem endereço 0x08000000
- Memória SRAM: tem endereço 0x20000000

2. LENGTH - Conforme a especificação do STM32F103C8:
- Memória Flash: 64Kbytes
- Memória SRAM: 20Kbytes
*/
MEMORY {
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 64K 
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}