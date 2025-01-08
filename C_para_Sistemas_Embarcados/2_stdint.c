#include <stdint.h>

void _exit(int status) {
    while (1) {}
}

int main() {
    volatile int8_t a = 1;  //  8 bits (1 bytes)
    volatile int16_t b = 2; // 16 bits (2 bytes)
    volatile int32_t c = 3; // 32 bits (4 bytes)
    volatile int64_t d = 4; // 64 bits (8 bytes)

    return 0;
}
