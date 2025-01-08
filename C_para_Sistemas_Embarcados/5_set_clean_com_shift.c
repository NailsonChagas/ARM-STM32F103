#include <stdint.h>

void _exit(int status) {
    while (1) {}
}

int main() {
    volatile short int a = 0x08;    // bin: 0000000000001000 | dec: 8

    // Setar os bits 15, 12 e 0 de 'a'
    /*
        (1 << 15) desloca o valor 1 para a 15ª posição a esquerda
        aux1 = 1000000000000000

        (1 << 12) desloca o valor 1 para a 12ª posição a esquerda
        aux2 = 0001000000000000
        
        (1 << 0) desloca o valor 1 para a 0ª posição a esquerda
        aux3 = 0001000000000001

        aux4 = aux1 | aux2 | aux3
        aux4 = 1001000000000001 dec: 36865

        a:    0000000000001000
        aux4: 1001000000000001
              ---------------- OR
        a:    1001000000001001
    */
    a |= (1 << 15) | (1 << 12) | (1 << 0);

    // Limpar os bits 15, 12 e 0 de 'a' 
    /*
        aux4 = aux1 | aux2 | aux3
        aux4 = 1001000000000001

        aux5 = ~aux4 = 0110111111111110 dec: 28670

        a:    1001000000001001
        aux5: 0110111111111110
              ---------------- AND
        a:    0000000000001000
    */
    a &= ~((1 << 15) | (1 << 12) | (1 << 0));

    return 0;
}
