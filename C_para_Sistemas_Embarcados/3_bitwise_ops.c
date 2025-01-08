#include <stdint.h>

void _exit(int status) {
    while (1) {}
}

int main() {
    volatile char a = 0x35;  //     bin: 110101 | dec: 53
    volatile char b = 0x0F;  //     bin: 001111 | dec: 15
    //---------------------------------------------------------------
    volatile char c = a & b; // AND      000101 | dec:  5 | hex: 0x05 
    volatile char d = a | b; //  OR      111111 | dec: 63 | hex: 0x3F 
    volatile char e = a ^ b; // XOR      111010 | dec: 58 | hex: 0x3A 
    volatile char f = ~a;    // NOT      001010 | dec: 10 | hex: 0x0A 
    return 0;
}
