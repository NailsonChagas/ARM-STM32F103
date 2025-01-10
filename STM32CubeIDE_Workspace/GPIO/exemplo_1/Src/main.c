/*
 *
 * Este é um exemplo em que estarei fazendo o LED conectado ao pino PC13 ficar piscando
*/

#include "stm32f1xx.h"
#include <stdint.h>

void delay_ms(uint16_t t);

int main(void)
{
	// Habilitando o clock na porta C
	RCC->APB2ENR |=  1 << 4; // bit 4 -> I/O port C clock enable (IOPC EN)

	/*
	 * Para acender o LED do pino 13 precisarei configuralo como uma saida digital
	 *
	 * CRH -> configurar pinos de 8 a 15
	 *
	 * Para configuras PC13 os bits usados de CRH são:
	 * - CNF13 bits -> 23 22
	 * - MODE13 bits -> 21 20
	 *
	 * MODE13 será configurado com 10 (Output com velocidade máxima de 2 MHz)
	 * CNF13 será configurado como 00 (General-purpose output push-pull: saida será Vcc ou 0V)
	 *
	 * Pinos não usados seram marcados como input (MODE = 00) analogico (CNF = 00)
	 *
	 * CRH deve ficar assim:
	 *  0  0  0  0  0  0  0  0 |  0  0  1  0 |  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
	 * __ __ __ __ __ __ __ __ | __ __ __ __ | __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __
	 * 31 30 29 28 27 26 25 24 | 23 22 21 20 | 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
	 *
	 * Esse numero é 200000 em hexadecimal
	 * */
	GPIOC->CRH = 0x200000;

	while(1){
		/*
		 * Para acender o LED devo dizer que o estado lógico do pino é high
		 * ODR deve ficar assim:
		 *  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0
		 * __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __
		 * 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
		 * Esse numero é 2000 em hexadecimal
		 *
		 * Para apagar o LED devo dizer que o estado lógico do pino é low
		 * ODR deve ficar assim:
		 *  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
		 * __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __
		 * 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
		 * Esse numero é 0 em hexadecimal
		 * */

		GPIOC->ODR = 0x2000; // liga led do pino 13
		delay_ms(100);

		/* Um problema que notei é que quando esta em low o led esta acendendo e quando
		 * esta em high o led esta deligando.
		 *
		 * Isto é um problema com como o led foi posicionado na placa, como encontrado
		 * na resposta desta pergunta no stackoverflow:
		 * https://stackoverflow.com/questions/65539472/built-in-led-is-off-when-gpioc13-is-high-but-on-then-gpioc13-is-low
		 *
		 * */

		GPIOC->ODR = 0x0; // desliga led do pino 13
		delay_ms(100);

	}
}

/* Retirado do livro
 * Sendo usado por que não sei usar o clock ainda
 * The following delay is tested with Keil and 72MHz */
void delay_ms(uint16_t t){
	volatile unsigned long l = 0;
	for(uint16_t i = 0; i < t; i++){
		for(l = 0; l < 6000; l++){}
	}
}
