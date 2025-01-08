#include <stdint.h>

void _exit(int status) {
    while (1) {}
}

// int e long são iguais em ARM 32

int main() {
    /*
        The volatile keyword is intended to prevent the compiler from applying any optimizations 
        on objects that can change in ways that cannot be determined by the compiler
        https://www.geeksforgeeks.org/understanding-volatile-qualifier-in-c/

        Usado abaixo para que o compilador não remova as variaveis por não estarem sendo usadas
    */

    // volatile char a = 0;                 // 1 byte ( 8 bits):           -128 ~ 127
    // volatile unsigned char b = 0;        // 1 byte ( 8 bits):              0 ~ 255
    // volatile short int c = 0;            // 2 byte (16 bits):        -32,768 ~ 32,767
    // volatile unsigned int d = 0;         // 2 byte (16 bits):              0 ~ 65,535
    volatile int e = 1;                     // 4 byte (32 bits): -2,147,483,648 ~ 2,147,483,647
    volatile long f = 2;                    // 4 byte (32 bits): -2,147,483,648 ~ 2,147,483,647
    // volatile unsigned long g = 1;        // 4 byte (32 bits):              0 ~ 4,294,967,295

    for (unsigned char i = 0; i < 255; i++)
    {   
        // g *= i; 
        f *= i;
        e *= i * -1;
        // d += i;
        // c -= i;  
        // b += 1;
        // a -= 1;
    }
    

    return 0;
}
