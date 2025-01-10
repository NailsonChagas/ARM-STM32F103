/*
 * Exemplo 3: semaforo
 *
 * Semaforo carro:
 * Vermelho -> Verde -> Amarelo -> Vermelho -> ...
 *
 * Botão diz para ativa o sinal de pedestre vai de verde para vermelho
 * e abre o Semaforo de pedestre, após certo tempo fecha e deixa o semaforo
 * de carro amarelo
 *
 */

#include "stm32f1xx.h"
#include <stdint.h>

uint8_t check_button();
void delay_ms(uint16_t t);

int main(void)
{
	uint8_t flag = 0;
	uint8_t pedestrian = 0;

	RCC->APB2ENR |= 1 << 2; // Habilitar clock na porta A (bit 2)

	/*
	 * PA0 -> Output (02 MHz): Led vermelho (semefaro veiculo)
	 * PA1 -> Output (02 MHz): Led amarelo (semefaro veiculo)
	 * PA2 -> Output (02 MHz): Led verde (semefaro veiculo)
	 *
	 * PA3 -> Input (General purpose output push-pull): Botão push
	 *
	 * PA4 -> Output (02 MHz): Led vermelho (semaforo pedestre)
	 * PA5 -> Output (02 MHz): Led verde (semaforo pedestre)
	 *
	 * Portanto CRL deve ser:
	 *						      PA5           PA4           PA3           PA2           PA1           PA0
	 *  0  0  0  0  0  0  0 |  0  0  1  0 |  0  0  1  0 |  1  0  0  0 |  0  0  1  0 |  0  0  1  0 |  0  0  1  0
	 * __ __ __ __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __ | __ __ __ __
	 * 31 30 29 28 27 26 25 | 24 23 22 21 | 20 19 18 17 | 16 15 14 13 | 12 11 09 08 | 07 06 05 04 | 03 02 01 00
	 * que é 228222 em hexadecimal
	 */
	GPIOA->CRL = 0x228222;

	// resistor pull up na entrada PA3
	GPIOA->ODR = 1 << 3;

	while(1){
		switch(flag){
			case 1: // vermelho
				GPIOA->ODR &= ~(1 << 1); // desliga o amarelo veiculo
				GPIOA->ODR |= 1 << 0; // liga o vermelho veiculo

				if (pedestrian == 1){
					GPIOA->ODR &= ~(1 << 4); // desliga o vermelho pedestre
					GPIOA->ODR |= 1 << 5; // liga o verde pedestre
					delay_ms(750);
					flag = 3; // para entrar no case 4 na proxima iteração
				}
				else{
					delay_ms(500);
				}
				break;
			case 2: // verde
				GPIOA->ODR &= ~(1 << 0); // desliga o vermelho veiculo
				GPIOA->ODR |= 1 << 2;  // liga o verde veiculo
				delay_ms(500);
				break;
			case 3: // amarelo
				GPIOA->ODR &= ~(1 << 2); // desliga o verde veiculo
				GPIOA->ODR |= 1 << 1; // liga o amarelo veiculo
				delay_ms(250);
				flag = 0;
				break;
			case 4:
				GPIOA->ODR &= ~(1 << 5); // desliga o verde pedestre
				GPIOA->ODR |= (1 << 4) | (1 << 1); // liga o vermelho pedestre / liga o amarelo veiculo
				delay_ms(250);
				flag = 1; // para ir para o case 2 na proxima iteração
				break;
		}
		pedestrian = check_button();
		flag += 1;
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

uint8_t check_button(){
	// checando se o botão no pino 3 esta pressionado
	if((GPIOA->IDR & (1 << 3)) == 0){
		// delay simples para debouncing (ideal seria usar clock e interrupções)
		for (volatile uint32_t i = 0; i < 10000; i++);

		// checa valor do bit 3 novamente para garantir que o botão esta pressioando
		if((GPIOA->IDR & (1 << 3)) == 0){
			return 1;
		}

		// espera o botão ser solto
		while ((GPIOA->IDR & (1 << 3)) == 0);
	}
	return 0;
}
