/**
 * Neste exemplo irei acender um led quando eu clicar um botão e desligar quando eu clicar novamente
 * pino PA0 -> entrada com um botão
 * pino PA1 -> saida com um LED
 */

#include "stm32f1xx.h"
#include <stdint.h>


int main(void)
{
	/* Para este exemplo estarei usando a porta A
	 * bit 2 -> I/O port A clock enable (IOPA EN) |
	 **/
	RCC->APB2ENR |= 1 << 2;

	/* Como os pinos usados estão no intervalo 0 a 7 irei usar o
	 * CRL para configurar os pinos
	 *
	 * PA0:
	 *  - MODE0 (bits 1 e 0): 00 (Input)
	 *  - CRL0 (bits 3 e 2): 10 (Entrada com resistor pull-up/pull-down)
	 *  	- Obs: ODR escolhe se o resistor pull-up ou pull-down (1: pull-up, 0: pull-down)
	 *
	 * PA1:
	 *  - MODE1 (bits 5 e 4): 10 (Output 02 MHz)
	 *  - CRL1 (bits 7 e 6): 00 (General purpose output push-pull)
	 *
	 * CRL deve ficar:
	 *  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 |  0  0  1  0 |  1  0  0  0
	 * __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ | __ __ __ __ | __ __ __ __
	 * 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 | 07 06 05 04 | 03 02 01 00
	 *
	 * esse numero em hexa é 28
	 * */
	GPIOA->CRL = 0x28;

	/* Configurando o resistor da entrada como pull up (1 quando não pressionado, 0 quando pressionado)
	 *
	 *  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 |  1
	 * __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ | __
	 * 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 | 00
	 * */
	//GPIOA->ODR = 0x1; // 1 << 0;
	GPIOA->ODR = 0x3; // 1 << 0; -> led começa ligado

	while(1){

		/* Checa se o valor do bit 0 é 0 no IDR
		 * caso for 1 o botão não esta sendo pressionado
		 *
		 * GPIOA->IDR & 0x1 = bit0
		 */
		if((GPIOA->IDR & 0x1) == 0){
			// delay simples para debouncing (ideal seria usar clock e interrupções)
			for (volatile uint32_t i = 0; i < 10000; i++);

			// checa valor do bit 0 novamente para garantir que o botão esta pressioando
			if((GPIOA->IDR & 0x1) == 0){
				/*
				 * Inverte o valor do bit 1 usando XOR e mascara 0x2 (1 no bit 1)
				 *
				 * exemplo1:
				 * 		03 02 01 00
				 * ODR:  0  0  0  1
				 * 0x2:  0  0  1  0
				 * ---------------- XOR
				 * ODR:  0  0  1  1
				 *
				 * exemplo2:
				 *      03 02 01 00
				 * ODR:  0  0  1  1
				 * 0x2:  0  0  1  0
				 * ---------------- XOR
				 * ODR:  0  0  0  1
				 * */
				GPIOA->ODR ^= 0x2;

				// espera o botão ser solto
				while ((GPIOA->IDR & (1 << 0)) == 0);
			}
		}
	}
}
