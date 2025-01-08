#include <stdint.h>

void _exit(int status){
    while (1){}
}

int main() {
    volatile short int a = 0xF7E8;             // bin: 1111011111101000 | dec: 63464
    volatile short int set_mask = 0x5;         // bin: 0000000000000101 | dec: 5 
    volatile short int clean_mask = 0xFE3F;    // bin: 1111111000111111 | dec: 65087 

    /*
        Os bits com 1 na mascara são marcados como 1 em 'a'
        a:        1111011111101000
        set_mask: 0000000000000101
                  ---------------- OR
                  1111011111101101
    */
    volatile short int set = a | set_mask;     // bin: 1111011111101101 | dec: 63469 | hex: 0xF7ED
    
    /*
        Os bits com 0 na mascara são marcados como 0 em 'a'
        a:          1111011111101000
        clean_mask: 1111111000111111
                    ---------------- AND
                    1111011000101000
    */
    volatile short int clean = a & clean_mask; // bin: 1111011000101000 | dec: 63016 | hex: 0xF628

    return 0;
}
