/**
 * Display de 7 segmentos
 * A -> PA0
 * B -> PA1
 * C -> PA2
 * D -> PA3
 * E -> PA4
 * F -> PA5
 * G -> PA6
 *
 * 0: 1 1 1 1 1 1 0 | 0 1 1 1 1 1 1
 * 1: 0 1 1 0 0 0 0 | 0 0 0 0 1 1 0
 * 2: 1 1 0 1 1 0 1 | 1 0 1 1 0 1 1
 * 3: 1 1 1 1 0 0 1 | 1 0 0 1 1 1 1
 * 4: 0 1 1 0 0 1 1 | 1 1 0 0 1 1 0
 * 5: 1 0 1 1 0 1 1 | 1 1 0 1 1 0 1
 * 6: 1 0 1 1 1 1 1 | 1 1 1 1 1 0 1
 * 7: 1 1 1 0 0 0 0 | 0 0 0 0 1 1 1
 * 8: 1 1 1 1 1 1 1 | 1 1 1 1 1 1 1
 * 9: 1 1 1 0 0 1 1 | 1 1 0 0 1 1 1
 * a: 0 0 1 1 1 0 1 | 1 0 1 1 1 0 0
 * b: 0 0 1 1 1 1 1 | 1 1 1 1 1 0 0
 * c: 0 0 0 1 1 0 1 | 1 0 1 1 0 0 0
 * d: 0 1 1 1 1 0 1 | 1 0 1 1 1 1 0
 * e: 1 0 0 1 1 1 1 | 1 1 1 1 0 0 1
 * f: 1 0 0 0 1 1 1 | 1 1 1 0 0 0 1
 * 	  _ _ _ _ _ _ _ | _ _ _ _ _ _ _
  *   A B C D E F G | G F E D C B A
 */

#include "stm32f1xx.h"
#include <stdint.h>

void delay_ms(uint16_t t);
uint8_t check_button();

int main(void)
{
	/* Para este exemplo estarei usando a porta A
     * bit 2 -> I/O port A clock enable (IOPA EN) |
    **/
	RCC->APB2ENR |= 1 << 2;


	/* Pinos usados vão de 0 a 7 -> usar CRL
	 *
	 * Pinos 0 a 6 serão saida:
	 * 	- Mode = 10 (Output 2MHz)
	 *  - CNF = 00 General purpose output push-pull
	 *
	 * Pino 7 será entrada:
	 * 	- Mode = 00 (Input)
	 * 	- CNF = 10 (Entrada com resistor pull-up/pull-down)
	 *  - Configurar se o resistor é pull-up ou pull-down no ODR
	 *
	 * CRL:
	 *   Pino 7        Pino 6        Pino 5        Pino 4        Pino 3        Pino 2        Pino 1        Pino 0
	 * 1  0  0  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0
	 *__ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __
	 *31 30 29 28 | 27 26 25 24 | 23 22 21 20 | 19 18 17 16 | 15 14 13 12 | 11 10 09 08 | 07 06 05 04 | 03 02 01 00
	 * CNF   MODE    CNF   MODE    CNF   MODE    CNF   MODE    CNF   MODE    CNF   MODE    CNF   MODE    CNF   MODE
	 *
	 * 10000010001000100010001000100010 = 0x82222222
	 * */
	GPIOA->CRL = 0x82222222;

	// resistor pull up na entrada PA7
	/*
	 *  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0
	 * __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __
	 * 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
	 * */
	GPIOA->ODR = 1 << 7;


	const uint8_t hex_lookup[] = {
			0x3F, 0x6, 0x5B, 0x4F, // 0111111, 0000110, 1011011, 1001111
			0x66, 0x6D, 0x7D, 0x7, // 1100110, 1101101, 1111101, 0000111
			0x7F, 0x67, 0x5C, 0x7C,// 1111111, 1100111, 1011100, 1111100
			0x58, 0x5E, 0x79, 0x71 // 1011000, 1011110, 1111001, 1110001
	};

	uint8_t i = 0, changed = 0;

	while(1){
//		for(uint8_t i = 0; i < 16; i++){
//			GPIOA->ODR |= hex_lookup[i];
//			delay_ms(100);
//			GPIOA->ODR &= 0xFF80; // zerar os bits 6 a 0: 1111 | 1111 | 1000 0000
//		}
		GPIOA->ODR |= hex_lookup[i];
		delay_ms(15);
		GPIOA->ODR &= 0xFF80; // zerar os bits 6 a 0: 1111111110000000

		if(i < 16){
			i += check_button();
		}
		else{
			i = 0;
		}
	}
}

uint8_t check_button(){
	// checando se o botão no pino 7 esta pressionado
	if((GPIOA->IDR & (1 << 7)) == 0){ // == 0 pois esta usando pull up
		// delay simples para debouncing (ideal seria usar clock e interrupções)
		delay_ms(10);

		// checa valor do bit 7 novamente para garantir que o botão esta pressioando
		if((GPIOA->IDR & (1 << 7)) == 0){
			return 1;
		}

		// espera o botão ser solto
		while ((GPIOA->IDR & (1 << 7)) == 0);
	}
	return 0;
}

void delay_ms(uint16_t t){
	volatile unsigned long l = 0;
	for(uint16_t i = 0; i < t; i++){
		for(l = 0; l < 6000; l++){}
	}
}

