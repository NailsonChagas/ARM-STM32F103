# ARM STM32F103  
Este repositório tem como objetivo documentar meu processo de aprendizado nas disciplinas de **Arquitetura e Organização de Computadores** e **Sistemas Microcontrolados**, utilizando o microcontrolador STM32F103 na placa de desenvolvimento *"Blue Pill"*. Como material de estudo, utilizo o livro *"[The STM32F103 Arm Microcontroller and Embedded Systems Using Assembly and C](https://www.amazon.com.br/STM32F103-Arm-Microcontroller-Embedded-Systems/dp/1970054018)"*.  

## Índice  
1. [Conhecimentos gerais](#conhecimentos-gerais)  
    1. [Glossário](#glossário)  
    2. [Microprocessador VS Microcontrolador](#microprocessador-vs-microcontrolador)  
    3. [Tipos de computadores](#tipos-de-computadores)  
    4. [Como escolher um microcontrolador?](#como-escolher-um-microcontrolador)  
2. [Arquitetura ARM](#arquitetura-arm)  
    1. [RISC](#risc) 
    2. [Pequeno histórico](#pequeno-histórico)  
    3. [Adaptabilidade tem suas desvantagens](#adaptabilidade-tem-suas-desvantagens)  
    4. [Registrador (register)](#registrador-register)  
        1. [Registrador de Uso Geral (General Purpose Register - GPR)](#registrador-de-uso-geral-general-purpose-register---gpr)
        2. [Stack Pointer (SP)](#stack-pointer-sp)
        3. [Link Register (LR)](#link-register-lr)
        4. [Program Counter (PC)](#program-counter-pc)
        5. [Current Program Status Register (CPSR)](#current-program-status-register-cpsr)
    5. [Mapa de memória](#mapa-de-memória)
    6. [SRAM](#sram)
    7. [Assembly](#assembly)
    8. [Pipelining e arquitetura Harvard em ARM](#pipelining-e-arquitetura-harvard-em-arm)
    9. [Acesso a memória em ARM](#acesso-a-memória-em-arm)
        1. [Alinhamento de Dados](#alinhamento-de-dados)
        2. [Modos de Endereçamento Avançados](#modos-de-endereçamento-avançados)
        3. [Modos com Registrador e Shift](#modos-com-registrador-e-shift)
        4. [Endereçamento Relativo ao PC](#endereçamento-relativo-ao-pc)
        5. [Endereçamento Bit a Bit (Bit-Banding)](#endereçamento-bit-a-bit-bit-banding)    
3. [STM32F103C8T6](#stm32f103c8t6)
    1. [Nomenclatura](#nomenclatura)
    2. [Especificações](#especificações)
    3. [Ambiente de Desenvolvimento](#ambiente-de-desenvolvimento)
	4. [C para Sistemas Embarcados](#c-para-sistemas-embarcados)
		1. [Tamanhos e Especificações dos Tipos de Dados](#tamanhos-e-especificações-dos-tipos-de-dados)
		2. [Operações Bitwise em C](#operações-bitwise-em-c)

## Conhecimentos gerais

### Glossário
- **ADC (Analog-to-Digital Converter)**: Conversor analógico-digital, responsável por converter sinais analógicos em valores digitais que podem ser processados por microcontroladores ou outros dispositivos digitais.

- **DAC (Digital-to-Analog Converter)**: Conversor digital-analógico, utilizado para converter sinais digitais em sinais analógicos.

- **I2C (Inter-Integrated Circuit)**: Um protocolo de comunicação serial síncrona utilizado para conectar dispositivos em uma rede de baixa velocidade, como sensores, em sistemas embarcados.

- **Memória Flash**: Tipo de memória não volátil utilizada para armazenar dados e programas em dispositivos eletrônicos, permitindo que as informações sejam mantidas mesmo após o desligamento do dispositivo.

- **Periféricos I/O**: Dispositivos ou circuitos conectados ao microcontrolador que permitem a interação com o mundo externo, como LEDs, sensores, displays e atuadores. Esses periféricos podem ser utilizados para entrada (ex.: botões) ou saída (ex.: motores).

- **RAM (Random Access Memory)**: Memória de acesso aleatório utilizada para armazenar temporariamente dados e instruções que estão sendo processados pela CPU. A RAM é volátil, ou seja, seus dados são perdidos quando o dispositivo é desligado.

- **Registers**: Áreas de armazenamento dentro da CPU usadas para guardar dados temporários e instruções em processo de execução.

- **RISC (Reduced Instruction Set Computer)**: Linha de arquitetura de processadores que favorece um conjunto simples e pequeno de instruções que levam aproximadamente a mesma quantidade de tempo para serem executadas.

- **ROM (Read-Only Memory)**: Memória de leitura apenas, usada para armazenar dados permanentes ou instruções essenciais que não podem ser alteradas, como o firmware do dispositivo. Diferentemente da RAM, a ROM é não volátil, mantendo os dados mesmo sem energia.

- **SPI (Serial Peripheral Interface)**: Protocolo de comunicação serial utilizado para conectar microcontroladores a periféricos, permitindo a transferência rápida de dados.

- **Sistema embarcado**: Um sistema de computação projetado para realizar uma tarefa específica, geralmente incorporado em dispositivos maiores. Utiliza microcontroladores ou microprocessadores e é comum em aplicações como automóveis, eletrodomésticos, sistemas médicos e dispositivos IoT.

- **UART (Universal Asynchronous Receiver/Transmitter)**: Protocolo de comunicação assíncrona utilizado para transmitir e receber dados entre dispositivos, como microcontroladores e computadores.

- **Blue Pill**: Uma placa de desenvolvimento compacta baseada no microcontrolador STM32F103. É popular por seu baixo custo e versatilidade, sendo amplamente utilizada em projetos embarcados e prototipagem.


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

### RISC
RISC (Reduced Instruction Set Computer) é uma arquitetura de processador que se caracteriza por ter um conjunto de instruções simples e de execução rápida. A ideia principal por trás do RISC é que um processador deve ser capaz de executar a maioria de suas operações em um único ciclo de clock, tornando o design mais eficiente e permitindo um desempenho superior em relação a arquiteturas mais complexas, como o CISC (Complex Instruction Set Computer).

A arquitetura RISC pode ser caracterizada pelos seguintes fatos:

0. **Instruções de tamanho unico**: As intruções de um processador RISC possem tamanhos iguais, ao contrário da arquitetura CISC em que uma intrução pode ter tamanho 1byte e outra 5 bytes.
1. **Número limitado de registradores**: CPU's RISC possuem um numero pequeno de registradores (comumente de 8 a 16)
2. **Conjunto de instruções simplificado**: O processador possui um número reduzido de instruções, e cada uma delas é otimizada para ser executada rapidamente, sem precisar de ciclos múltiplos.
3. **Execução em um ciclo de clock**: A maioria das instruções pode ser executada em um único ciclo de clock, o que torna a execução mais eficiente.
4. **Instruções de tipo único**: O foco é em operações simples de manipulação de dados e controle de fluxo, em vez de instruções complexas.
5. **Uso eficiente de registradores**: Em vez de acessar a memória frequentemente, as instruções RISC usam os registradores de forma intensiva para operações, o que também contribui para maior velocidade.

A arquitetura ARM, por exemplo, é baseada em RISC, o que permite que seus processadores sejam eficientes em termos de desempenho e consumo de energia, sendo amplamente utilizados em dispositivos móveis, sistemas embarcados e outros produtos que exigem um bom equilíbrio entre desempenho e eficiência energética.

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

### SRAM  
- **Stack:**  
  O **Stack** é uma região de memória SRAM usada para armazenar dados temporários, como variáveis locais e registros salvos durante chamadas de função. Ele cresce e encolhe de forma dinâmica, normalmente de endereços altos para endereços baixos, e é gerenciado automaticamente pelo compilador e pelo processador através do ponteiro de pilha (SP - Stack Pointer). Em ARM assembly, instruções como `PUSH` e `POP` são usadas para manipular o stack.  

- **Heap:**  
  O **Heap** é outra região de memória SRAM usada para alocação dinâmica de memória em tempo de execução. Diferentemente do stack, ele cresce de endereços baixos para altos. A alocação e liberação de memória no heap são gerenciadas explicitamente pelo programador, geralmente por meio de chamadas de funções como `malloc` e `free` (em linguagens de alto nível) ou manipulação direta de ponteiros. O uso do heap em sistemas embarcados deve ser cuidadoso devido aos recursos limitados.  

### Assembly
Esse trecho foi dividido em duas partes:
1. Foram desenvolvidos com base nos seguintes recursos:  
    - [Vídeo no YouTube](https://www.youtube.com/watch?v=gfmRrPjnEw4&t=386s)  
    - [Emulador ARM DE1-SoC](https://cpulator.01xz.net/?sys=arm-de1soc)
    - Os códigos, acompanhados de comentários explicativos, estão disponíveis na pasta `ARM_Assembly_youtube`.
2. Seguindo os capitulos 2 a 6 do livro:
    - Os códigos, acompanhados de comentários explicativos, estão disponíveis na pasta `ARM_Assembly_livro`.
    
Depois de assistir o vídeo e reproduzir os códigos, devo ler os capítulos 2 ao 6 do livro *"[The STM32F103 Arm Microcontroller and Embedded Systems Using Assembly and C](https://www.amazon.com.br/STM32F103-Arm-Microcontroller-Embedded-Systems/dp/1970054018)"* e fazer os exercicios presentes no site ao fim de cada capítulo.

### Pipelining e arquitetura Harvard em ARM
- **Pipelining:** Em microprocessadores antigos, a CPU executava uma instrução por vez. O pipelining permite que a CPU busque e execute instruções simultaneamente, dividindo a execução em etapas menores que podem ser executadas em paralelo. A execução é limitada pela etapa mais lenta do pipeline

- **Arquitetura Harvard:** A arquitetura Harvard separa os barramentos de código e dados, permitindo que a CPU busque instruções e acesse dados ao mesmo tempo. 


### Acesso a memória em ARM

#### Arquitetura de Memória
- A arquitetura ARM utiliza endereços de 32 bits, possibilitando acesso direto a até 4 GB de memória (endereços de `0x00000000` a `0xFFFFFFFF`), com cada byte possuindo um endereço exclusivo. Isso é conhecido como CPU byte-addressable.
- O barramento de dados (D31-D0) suporta acesso a dados de 8 bits (byte), 16 bits (halfword) e 32 bits (word). Já o barramento de endereços (A31-A0) controla os acessos às memórias internas e externas.

#### Barramentos AHB e APB
- O ARM utiliza dois principais barramentos para gerenciar acessos:
  - **AHB (Advanced High-Performance Bus):** Conecta a CPU à memória interna rápida (ROM/RAM) e periféricos de alta velocidade, como GPIO. Oferece acesso em um único ciclo.
  - **APB (Advanced Peripheral Bus):** É utilizado para periféricos mais lentos, como ADC, UART, SPI e I2C. É conectado ao AHB por meio de uma ponte (AHB-to-APB bridge) que permite conversão de acessos rápidos para lentos.

#### Ciclos de Memória e Wait States
- Um ciclo de barramento é o tempo necessário para a CPU ler ou escrever na memória ou nos periféricos. O tempo pode variar:
  - **0 Wait State (WS):** A memória responde no mesmo ciclo.
  - **1 WS, 2 WS, etc.:** A memória demora mais ciclos para responder, especialmente em memórias externas. Exemplo:
    - Um sistema de 50 MHz com 0 WS tem um ciclo de 20 ns (1/50 MHz * 2 ciclos = 40 ns).
    - Com 1 WS, o ciclo aumenta para 60 ns.

#### Largura de Banda do Barramento
- A largura de banda mede a velocidade de transferência de dados entre a CPU e a memória. Ela é influenciada pela largura do barramento e pelo tempo de ciclo. Por exemplo:
  - Um barramento de 32 bits (4 bytes) com um ciclo de 20 ns tem uma largura de banda de 200 MB/s.

#### Alinhamento de Dados
- No ARM, os dados devem ser alinhados por palavra (word-aligned) para melhor desempenho, ou seja, armazenados em endereços múltiplos de 4 (como 0x0, 0x4, 0x8). Dados desalinhados exigem ciclos adicionais de memória, diminuindo a eficiência.

#### Modos de Endereçamento Avançados

Os modos de endereçamento determinam como o endereço da memória é calculado durante instruções como LDR (Load Register) e STR (Store Register). O ARM oferece modos avançados para maior flexibilidade.

1. Pre-indexado:
- O endereço é calculado antes do acesso à memória. Por exemplo:
  - `LDR R1, [R0, #4]` calcula `R0 + 4` como o endereço efetivo, mas não altera o valor de R0.

2. Pre-indexado com Writeback:
- Semelhante ao pre-indexado, mas o registrador base é atualizado com o novo valor. Por exemplo:
  - `LDR R1, [R0, #4]!` calcula o endereço efetivo como `R0 + 4` e armazena o novo valor em R0.

3. Post-indexado:
- O endereço efetivo usa o valor atual do registrador base e, após o acesso, o registrador base é atualizado. Por exemplo:
  - `LDR R1, [R0], #4` acessa o endereço contido em R0 e, depois, atualiza `R0 = R0 + 4`.

#### Modos com Registrador e Shift
- O ARM permite usar outro registrador ou aplicar deslocamentos (shift) ao calcular o endereço. Por exemplo:
  - `LDR R1, [R0, R2, LSL #2]` calcula o endereço como `R0 + (R2 * 4)`.


#### Endereçamento Relativo ao PC
- O ARM usa o registrador PC (Program Counter) para acessar dados ou instruções relativas à linha atual do programa. Por exemplo:
  - `LDR R0, [PC, #4]` acessa um endereço `PC + 4 + 4`.
- **ADR Pseudo-instruction:** Facilita carregar um endereço em um registrador sem calcular deslocamentos manualmente. Por exemplo:
  - `ADR R0, Label` é traduzido como algo como `ADD R0, PC, offset`.

#### Endereçamento Bit a Bit (Bit-Banding)

- **Problema com Read-Modify-Write (RMW)**
    - Alterar apenas um bit em um byte convencionalmente exige três etapas:
        1. Ler o byte inteiro.
        2. Modificar o bit desejado.
        3. Escrever o byte inteiro de volta.
    - Em sistemas multitarefa, isso pode causar conflitos se duas tarefas tentarem alterar o mesmo byte simultaneamente.

- **Bit-Banding no Cortex-M**
    - O ARM Cortex-M introduz o bit-banding, que cria **endereços alias** para bits individuais em regiões específicas da memória:
    - Por exemplo, o bit 3 do endereço 0x20000004 é mapeado para o endereço alias 0x2200008C.
    - Fórmula para calcular endereços alias:
        - Endereço Alias = Base Alias + (Byte Offset * 32) + (Bit Número * 4)

- **Regiões Bit-Band**
    - **SRAM Bit-Band:**
        - Endereços reais: 0x20000000 - 0x200FFFFF.
        - Endereços alias: 0x22000000 - 0x23FFFFFF.
    - **Periféricos Bit-Band:**
        - Endereços reais: 0x40000000 - 0x400FFFFF.
        - Endereços alias: 0x42000000 - 0x43FFFFFF.

- **Vantagens**
    - Operações em bits individuais se tornam atômicas (não podem ser interrompidas), aumentando a confiabilidade e eficiência.


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
- Tensão de Operação: 3,3V (Alimentação)
- Entradas Analógicas: 10 pinos de entrada analógica
- Pinos de E/S Digitais: 37 pinos GPIO distribuídos em quatro portas (A, B, C e D)
- Capacidade de Corrente dos Pinos: Cada pino GPIO pode fornecer ou consumir até 6mA de corrente
- Comunicações: Suporte a I2C, SPI, UART, CAN e USB

### Ambiente de Desenvolvimento
Como estou usando o sistema Ubuntu 22.04 (Linux), não utilizarei a mesma IDE mencionada no livro (ARM Keil), pois ela está disponível apenas para Windows, e não gostei de como está funcionando via Wine. Por conta disso, utilizarei a STM32CubeIDE para criar projetos que não utilizam o HAL, assim como foi feito no livro. Depois de aprender a programar utilizando registradores, pretendo estudar o HAL, já que ele simplifica bastante o processo de desenvolvimento.

- **Usando a STM32CubeIDE sem o HAL**:
	1. Clicar em `Start new STM32 project`
	2. Procure por `f103c8t6` na seção `Commercial Part Number`
	3. Selecione o microcontrolador `STM32F103C8T6`
	4. Criar o projeto com as seguintes configurações:
		- Targeted Language: `C`
		- Targeted Binary Type: `Executable`
		- Targeted Project Type: `Empty`
	5. Comentar a seção `#if !defined(__SOFT_FP__) && defined(__ARM_FP)` na `main.c` já que o `Cortex-M3` não possui uma FPU integrada 
	6. Incluir as bibliotecas e arquivos na pasta `Inc`:
		- `CMSIS/Core/Include`
		- `Device/ST/STM32F1xx/Include`
			- No arquivo `stm32f1xx.h` descomentar `#define STM32F103xB`
		- Obs:
			- Ambos disponiveis em [STM32CubeF1](https://github.com/STMicroelectronics/STM32CubeF1)
			- Para facilitar deixei os arquivos em uma pasta chamada `Drivers` neste repositório
	
	Obs: Projeto `0_test` é um projeto vazio em que foi seguido acima

### C para Sistemas Embarcados
Obs: Os arquivos `C` com exemplos de uso e os arquivos `Assembly` resultantes, comentados, estão na pasta `C_para_Sistemas_Embarcados`

#### Tamanhos e Especificações dos Tipos de Dados
A linguagem C não especifica o tamanho dos tipos de dados; depende do compilador.

1. **Exemplos de tamanhos típicos em sistemas ARM (32 bits):**
    - `char`: 1 byte (signed: -128 a 127, unsigned: 0 a 255).
    - `short int`: 2 bytes (signed: -32.768 a 32.767, unsigned: 0 a 65.535).
    - `int` e `long`: 4 bytes (int: mesmo que long no ARM, signed: -2.147.483.648 a 2.147.483.647).
    - `long long`: 8 bytes (signed: -9,22x10¹⁸ a 9,22x10¹⁸).

2. **Desempenho e Alinhamento**:
    - **Alinhamento**: Variáveis são alocadas em endereços específicos (ex.: múltiplos de 4 em sistemas de 32 bits).
    - **Desalinhamento** pode causar penalidades de desempenho.

3. **Razões para Escolha do Tipo de Dados**:
    - **Desempenho**: Em CPUs de 8 bits, tipos menores otimizam recursos. Em ARM, 1, 2 ou 4 bytes têm impacto similar.
    - **Overflow**: Tipos pequenos podem causar erros de overflow (ex.: contagem de segundos em `short int`).
    - **Coerção**: Conversão implícita de tipos (ex.: `int` para `char`) pode levar a resultados indesejados.

4. **Padrões C99 (`stdint.h`)**:
    - Tipos de dados com tamanho fixo (ex.: `int8_t`, `uint32_t`) garantem portabilidade e clareza.

#### Operações Bitwise em C

1. **Operadores Bitwise**:
    - `&` (AND), `|` (OR), `^` (XOR), `~` (NOT), `>>` (shift right), `<<` (shift left).
    - **Exemplo**:
        - `0x35 & 0x0F` → `0x05`
        - `0x04 | 0x68` → `0x6C`
        - `~0x55` → `0xAA`

2. **Definições e Manipulação de Bits**:
    - **Definir bits**: `register |= MASK` (ex.: `register |= 0x08` define o bit 3).
    - **Limpar bits**: `register &= ~MASK` (ex.: `register &= ~0x20` limpa o bit 5).
    - **Alternar bits**: `register ^= MASK`.

3. **Teste de Bits**:
    - Para verificar o estado de um bit específico:
        ```c
        if (var1 & 0x20) { /* Bit 5 é 1 */ } else { /* Bit 5 é 0 */ }
        ```

4. **Gerar Máscaras com Shift**:
    - `1 << n`: Cria uma máscara com o bit `n` definido.
    - **Combinações de bits**: `(1 << n) | (1 << m)` define os bits `n` e `m`.

5. **Campos de Bits em Registradores**:
   Em sistemas embarcados, é comum que certos bits de um registrador (ou variável) representem campos com valores significativos. Ao invés de manipular os bits individualmente, podemos usar máscaras e operações bitwise para lidar eficientemente com esses campos.

    - **Exemplos Práticos**:
     1. **Zerar um Campo**:
        - Para zerar os bits 15-12:
          ```c
          register &= ~(15 << 12);
          ```
        **Explicação**:
        - Criamos uma máscara `15 << 12` (`15` em binário é `1111`, deslocado para os bits 15-12).
        - O operador `~` inverte os bits da máscara, criando `0`s nos bits 15-12 e `1`s nos outros.
        - Usamos `&` para aplicar a máscara invertida ao registrador, garantindo que os bits 15-12 sejam zerados enquanto os outros permanecem inalterados.

     2. **Configuração de um Divisor de Clock**:
        Imagine um registrador de 32 bits onde os **bits 30-28** representam um divisor de clock. Cada combinação desses 3 bits define um valor de divisor, por exemplo:
        - `000` = Divisor 0
        - `001` = Divisor 1
        - `101` = Divisor 5

        Para definir o valor `5` nesse campo (bits 30-28):

        - **Limpar os bits 30-28**:
            ```c
            register &= ~(7 << 28);
            ```
            **Explicação**:
            - Criamos uma máscara `7 << 28` (`7` em binário é `111`, deslocado para os bits 30-28).
            - O operador `~` inverte os bits da máscara, criando `0`s nos bits 30-28 e `1`s nos outros.
            - Usamos `&` para zerar os bits 30-28, mantendo os outros bits do registrador inalterados.

        - **Definir o valor `5` nos bits 30-28**:
            ```c
            register |= 5 << 28;
            ```
            **Explicação**:
            - Criamos uma máscara para o valor `5` (`5` em binário é `101`) e a deslocamos para os bits 30-28.
            - Usamos `|` para definir os bits 30-28 com o valor `5`, sem alterar os outros bits do registrador.

        - **Combinação das operações**:
            ```c
            register = (register & ~(7 << 28)) | (5 << 28);
            ```
            **Explicação**:
            - A operação é combinada em uma única instrução.
            - Primeiro, limpamos os bits 30-28 com `register & ~(7 << 28)`.
            - Em seguida, configuramos os bits 30-28 para `5` com `| (5 << 28)`.

### Programação de I/O