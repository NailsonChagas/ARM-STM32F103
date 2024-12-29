# ARM STM32F103  
Este repositório tem como objetivo documentar meu processo de aprendizado nas disciplinas de **Arquitetura e Organização de Computadores** e **Sistemas Microcontrolados**, utilizando o microcontrolador STM32F103 na placa de desenvolvimento *"Blue Pill"*. Como material de estudo, utilizo o livro *"[The STM32F103 Arm Microcontroller and Embedded Systems Using Assembly and C](https://www.amazon.com.br/STM32F103-Arm-Microcontroller-Embedded-Systems/dp/1970054018)"*.  

## Índice  
1. [Conhecimentos gerais](#conhecimentos-gerais)  
    1. [Glossário](#glossário)  
    2. [Microprocessador VS Microcontrolador](#microprocessador-vs-microcontrolador)  
    3. [Tipos de computadores](#tipos-de-computadores)  
    4. [Como escolher um microcontrolador?](#como-escolher-um-microcontrolador)  
2. [Arquitetura ARM](#arquitetura-arm)  
    1. [Pequeno histórico](#pequeno-histórico)  
    2. [Adaptabilidade tem suas desvantagens](#adaptabilidade-tem-suas-desvantagens)  
    3. [Registrador (register)](#registrador-register)  
        1. [Registrador de Uso Geral (General Purpose Register - GPR)](#registrador-de-uso-geral-general-purpose-register---gpr)
        2. [Stack Pointer (SP)](#stack-pointer-sp)
        3. [Link Register (LR)](#link-register-lr)
        4. [Program Counter (PC)](#program-counter-pc)
        5. [Current Program Status Register (CPSR)](#current-program-status-register-cpsr)
    4. [Mapa de memória](#mapa-de-memória)
    5. [Assembly](#assembly)
3. [STM32F103C8T6](#stm32f103c8t6)
    1. [Nomenclatura](#nomenclatura)
    2. [Especificações](#especificações)

## Conhecimentos gerais

### Glossário
- **ADC (Analog-to-Digital Converter)**: Conversor analógico-digital, responsável por converter sinais analógicos em valores digitais que podem ser processados por microcontroladores ou outros dispositivos digitais.

- **DAC (Digital-to-Analog Converter)**: Conversor digital-analógico, utilizado para converter sinais digitais em sinais analógicos.

- **I2C (Inter-Integrated Circuit)**: Um protocolo de comunicação serial síncrona utilizado para conectar dispositivos em uma rede de baixa velocidade, como sensores, em sistemas embarcados.

- **IC (Integrated Circuit)**: Circuito integrado, um componente eletrônico que combina diversos componentes (como transistores, resistores e capacitores) em um único chip de silício.

- **I/O (Input/Output)**: Termo usado para descrever os pinos ou interfaces de entrada e saída que permitem que um dispositivo se comunique com o mundo externo.

- **Memória Flash**: Tipo de memória não volátil utilizada para armazenar dados e programas em dispositivos eletrônicos, permitindo que as informações sejam mantidas mesmo após o desligamento do dispositivo.

- **Microcontrolador**: Um chip que combina CPU, RAM, ROM e periféricos de I/O em um único IC, projetado para controle de dispositivos eletrônicos em aplicações embarcadas.

- **Microprocessador**: Um chip que contém apenas a CPU e exige a adição de componentes externos (RAM, ROM e I/O) para funcionar, usado principalmente em sistemas de computação mais complexos.

- **PC (Personal Computer)**: Computador pessoal projetado para uso geral, como tarefas de escritório, navegação na internet, edição de vídeos e jogos. Normalmente inclui um microprocessador, RAM, armazenamento (ex.: HD/SSD) e periféricos como teclado e monitor.

- **Periféricos I/O**: Dispositivos ou circuitos conectados ao microcontrolador que permitem a interação com o mundo externo, como LEDs, sensores, displays e atuadores. Esses periféricos podem ser utilizados para entrada (ex.: botões) ou saída (ex.: motores).

- **RAM (Random Access Memory)**: Memória de acesso aleatório utilizada para armazenar temporariamente dados e instruções que estão sendo processados pela CPU. A RAM é volátil, ou seja, seus dados são perdidos quando o dispositivo é desligado.

- **Registers**: Áreas de armazenamento dentro da CPU usadas para guardar dados temporários e instruções em processo de execução.

- **RISC (Reduced Instruction Set Computer)**: Linha de arquitetura de processadores que favorece um conjunto simples e pequeno de instruções que levam aproximadamente a mesma quantidade de tempo para serem executadas.

- **ROM (Read-Only Memory)**: Memória de leitura apenas, usada para armazenar dados permanentes ou instruções essenciais que não podem ser alteradas, como o firmware do dispositivo. Diferentemente da RAM, a ROM é não volátil, mantendo os dados mesmo sem energia.

- **SPI (Serial Peripheral Interface)**: Protocolo de comunicação serial utilizado para conectar microcontroladores a periféricos, permitindo a transferência rápida de dados.

- **Sistema embarcado**: Um sistema de computação projetado para realizar uma tarefa específica, geralmente incorporado em dispositivos maiores. Utiliza microcontroladores ou microprocessadores e é comum em aplicações como automóveis, eletrodomésticos, sistemas médicos e dispositivos IoT.

- **UART (Universal Asynchronous Receiver/Transmitter)**: Protocolo de comunicação assíncrona utilizado para transmitir e receber dados entre dispositivos, como microcontroladores e computadores.

- **Blue Pill**: Uma placa de desenvolvimento compacta baseada no microcontrolador STM32F103. É popular por seu baixo custo e versatilidade, sendo amplamente utilizada em projetos embarcados e prototipagem.

- **CPU (Central Processing Unit)**: Unidade central de processamento, responsável por executar instruções e realizar cálculos necessários ao funcionamento de programas.

### Microprocessador VS Microcontrolador
- **Microprocessadores**: Não possuem RAM, ROM ou I/O's. Devem ser conectados externamente a RAM, ROM e I/O's.

- **Microcontroladores**: CPU, RAM, ROM e I/O's estão juntos em um mesmo IC.

### Tipos de computadores
Computadores geralmente podem ser divididos em três grupos:
- **PC's**: Inclui desktops e notebooks. Feitos para uso geral (ler artigos, jogar, trabalhar, etc.), usam microprocessadores.

- **Servidores**: Usados para hospedar sites, armazenar bancos de dados e processar grandes quantidades de dados.

- **Sistemas embarcados**: Computadores de uso específico, nos quais o software e o hardware estão integrados para realizar uma tarefa específica. Exemplos incluem câmeras digitais, aspiradores de pó, players de MP3, mouses, teclados e impressoras. Na maioria das vezes, utilizam microcontroladores, mas quando necessário, processadores de uso geral podem ser usados.

### Como escolher um microcontrolador?
Microcontroladores devem ser escolhidos com base nas características do chip (velocidade de clock, consumo de energia, preço, 
memórias e periféricos integrados) e recursos disponíveis (suporte, IDE, produção ativa, etc).

## Arquitetura ARM
ARM (Advanced RISC Machine) é uma família de arquiteturas de processadores baseadas no modelo RISC (Reduced Instruction Set Computing). 
A ARM Holdings, uma empresa britânica, é a responsável pelo desenvolvimento e licenciamento dessas arquiteturas. A arquitetura ARM 
é caracterizada por: eficiência energética, simplicidade, tamanho compacto e capacidade de personalização.

### Pequeno histórico
A ARM surgiu na década de 1980 dentro da empresa "Acorn Computers" (Reino Unido) graças ao trabalho de Steve Furber e Sophie Wilson, 
que trabalharam para definir a arquitetura ARM e suas instruções. Em 1985, o primeiro microprocessador ARM foi produzido, mas devido 
à competição com a arquitetura x86, a empresa "Acorn Computers" foi forçada a focar no mercado de microcontroladores para sistemas embarcados.
Graças ao seu sucesso no mercado de microcontroladores e ao crescente interesse no uso do chip, a empresa "ARM" foi fundada para licenciar 
o uso da arquitetura para empresas de fabricação e desenvolvimento de semicondutores. 

### Adaptabilidade tem suas desvantagens
A arquitetura ARM, incluindo registradores, instruções e mapa de memória, é definida e patenteada pela "ARM Holdings". 
Fabricantes licenciam essa propriedade intelectual (PI) e adicionam seus próprios periféricos. Embora a CPU seja a mesma 
em chips ARM de diferentes fornecedores, os periféricos (portas I/O, UART, temporizadores, ADC, SPI, DAC, I2C, etc.) e 
memórias (memória Flash, SRAM) variam. Isso resulta em incompatibilidade ao tentar usar o mesmo código em diferentes chips ARM, 
sendo uma das principais desvantagens dessa arquitetura. Um programa para a porta serial de um chip ARM da Texas Instruments, por exemplo, 
pode não funcionar em um chip ARM da NXP.

### Registrador (register)
Registradores ARM possuem 32 bits, ou seja, se um dado possuir mais de 32 bits (1 Word), ele deve ser quebrado em pedaços de 32 bits. 
Mesmo com o padrão da arquitetura ARM sendo 32 bits, algumas de suas instruções suportam operações usando dados de um único bit, 8 bits e 16 bits.

- **1 Bit = 0 ou 1**
- **1 Byte = 8 Bits**
- **1 Half-Word = 2 Bytes = 16 Bits**
- **1 Word = 2 Half-Words = 4 Bytes = 32 Bits**

Obs: 32 bits pode ser representado por um hex de 8 digitos

A arquitetura ARM possui 17 registradores:
- **R0 ~ R12**: registrador de uso Geral
- **R13**: ponteiro de Pilha (Stack Pointer - SP)
- **R14**: registro de Link (Link Register - LR)
- **R15**: contador de Programa (Program Counter - PC)
- **CPSR**: current program status register

#### Registrador de Uso Geral (General Purpose Register - GPR)
Os registradores de uso geral são pequenos espaços de memória dentro de uma CPU que podem ser usados para armazenar dados temporários, 
como valores intermediários em cálculos ou dados transferidos entre a memória e a CPU. Eles não possuem uma função específica e podem 
ser utilizados para qualquer propósito definido pelo programador ou compilador. Exemplos em arquiteturas ARM incluem os registradores R0 a R12.

#### Stack Pointer (SP)
O Stack Pointer é um registrador especializado que aponta para o topo da pilha de memória. 
A pilha é uma estrutura de dados usada para armazenar informações temporárias, como valores de variáveis locais, 
endereços de retorno e parâmetros de função.

#### Link Register (LR)
O Link Register é um registrador que armazena o endereço de retorno de uma sub-rotina ou função chamada.

#### Program Counter (PC)
O Program Counter é um registrador que contém o endereço da próxima instrução a ser executada pela CPU.

#### Current Program Status Register (CPSR)
Registrador usado para armazenar informações sobre o estado atual do processador.
Suas funções principais incluem:
- **N (Negative)**: Indica se o resultado de uma operação foi negativo.
- **Z (Zero)**: Indica se o resultado de uma operação foi zero.
- **C (Carry)**: Reflete um carry out em operações de soma/subtração ou indica operações de rotação.
- **V (Overflow)**: Indica um overflow em operações aritméticas.
- **T**: Indica se o processador esta em estado Thumb (16 bits)
- **I**: Habilita interrupções
- **F**: Desativa interrupções

### Mapa de memória 
Na arquitetura ARM, existe apenas um espaço de memória que pode ir até 4 Gigabytes. Sendo esse espaço de memória interno dividido em 3 seções:
- I/O registers: Área dedicada para os registradores dos periféricos. O seu tamanho é definido pelo numero de pinos e funções periféricas suportadas pelo chip.
- SRAM: Usado para variáveis de dados e pilha (stack) e é acessado pelas instruções do microcontrolador
- Flash ROM: Bloco de memória reservado para armazenar o programa. Também pode ser usado para armazenar dados estáticos (ex: look-up table e strings)

### Assembly
Os códigos, acompanhados de comentários explicativos, estão disponíveis na pasta `Assembly`.

Foram desenvolvidos com base nos seguintes recursos:  
- [Vídeo no YouTube](https://www.youtube.com/watch?v=gfmRrPjnEw4&t=386s)  
- [Emulador ARM DE1-SoC](https://cpulator.01xz.net/?sys=arm-de1soc)

Depois de assistir o vídeo e reproduzir os códigos, devo ler os capítulos 2 ao 6 do livro *"[The STM32F103 Arm Microcontroller and Embedded Systems Using Assembly and C](https://www.amazon.com.br/STM32F103-Arm-Microcontroller-Embedded-Systems/dp/1970054018)"* e fazer os exercicios presentes no site ao fim de cada capítulo.

## STM32F103C8T6
O `STM32F103C8T6` é um microcontrolador da série STM32 da STMicroelectronics, amplamente utilizado em sistemas embarcados devido ao seu excelente custo-benefício e versatilidade. Ele pertence à família STM32F1, que é baseada na arquitetura `ARM Cortex-M3`.

### Nomenclatura
- **STM32:** Indica que pertence à família STM32 de microcontroladores baseados em arquiteturas ARM Cortex.

- **F:** Refere-se à série de produtos dentro da família STM32. No caso, "F" representa a série focada em alto desempenho para aplicações gerais.

- **103:** Especifica a subfamília do microcontrolador.
    - **1** indica que é baseado no núcleo ARM Cortex-M3.
    - **03** indica o nível de funcionalidade e recursos, como velocidades de clock, interfaces e memória.

- **C:** Representa o encapsulamento (package) do microcontrolador. "C" geralmente significa um encapsulamento LQFP (Low-Profile Quad Flat Package) de 48 pinos.

- **8:** Refere-se à capacidade de memória Flash do microcontrolador. O número 8 indica que possui 64 KB de memória Flash (a ST usa um código em que "8" corresponde a 64 KB, "B" seria 128 KB, etc.).

- **T:** Indica a faixa de temperatura operacional. "T" significa que o microcontrolador pode operar na faixa de temperatura industrial, geralmente entre -40°C e +85°C.

- **6:** Refere-se à classe de encapsulamento e acabamento. "6" geralmente indica que o microcontrolador é de grau padrão (com acabamento de qualidade padrão).

### Especificações
- Frequência da CPU: 72 MHz
- Memória RAM: 20 KB
- Memória Flash: 64 KB