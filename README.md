# ARM STM32F103  

Este repositório tem como objetivo documentar meu processo de aprendizado nas disciplinas de **Arquitetura e Organização de Computadores** e **Sistemas Microcontrolados**, utilizando o microcontrolador STM32F103 na placa de desenvolvimento *"Blue Pill"*. Como material de estudo, utilizo o livro *"[The STM32F103 Arm Microcontroller and Embedded Systems Using Assembly and C](https://www.amazon.com.br/STM32F103-Arm-Microcontroller-Embedded-Systems/dp/1970054018)"*.  

## Índice  
1. [Conhecimentos gerais](#conhecimentos-gerais) 
    1. [Glossário](#glossário)
    2. [Microprocessador VS Microcontrolador](#microprocessador-vs-microcontrolador)  
    3. [Tipos de computadores](#tipos-de-computadores)
    4. [Como escolher um microcontrolador?](#como-escolher-um-microcontrolador)
2. [Arquitetura ARM](#arquitetura-arm)
    1. [Pequeno historico](#pequeno-historico)
    2. [Adaptabilidade tem suas desvantagens](#adaptabilidade-tem-suas-desvantagens)

## Conhecimentos gerais

### Glossário 
Adicionar: ADC, SPI, DAC, I2C, UART, SRAM, Memória Flash

- **Blue Pill**: Uma placa de desenvolvimento compacta baseada no microcontrolador STM32F103. É popular por seu baixo custo e versatilidade, sendo amplamente utilizada em projetos embarcados e prototipagem.

- **CPU (Central Processing Unit)**: Unidade central de processamento, responsável por executar instruções e realizar cálculos necessários ao funcionamento de programas.

- **IC (Integrated Circuit)**: Circuito integrado, um componente eletrônico que combina diversos componentes (como transistores, resistores e capacitores) em um único chip de silício.

- **I/O (Input/Output)**: Termo usado para descrever os pinos ou interfaces de entrada e saída que permitem que um dispositivo se comunique com o mundo externo.

- **Microcontrolador**: Um chip que combina CPU, RAM, ROM e periféricos de I/O em um único IC, projetado para controle de dispositivos eletrônicos em aplicações embarcadas.

- **Microprocessador**: Um chip que contém apenas a CPU e exige a adição de componentes externos (RAM, ROM e I/O) para funcionar, usado principalmente em sistemas de computação mais complexos.

- **PC (Personal Computer)**: Computador pessoal projetado para uso geral, como tarefas de escritório, navegação na internet, edição de vídeos e jogos. Normalmente inclui um microprocessador, RAM, armazenamento (ex.: HD/SSD) e periféricos como teclado e monitor.

- **Periféricos I/O**: Dispositivos ou circuitos conectados ao microcontrolador que permitem a interação com o mundo externo, como LEDs, sensores, displays e atuadores. Esses periféricos podem ser utilizados para entrada (ex.: botões) ou saída (ex.: motores).

- **RAM (Random Access Memory)**: Memória de acesso aleatório utilizada para armazenar temporariamente dados e instruções que estão sendo processados pela CPU. A RAM é volátil, ou seja, seus dados são perdidos quando o dispositivo é desligado.

- **RISC (Reduced Instruction Set Computer)**: Linha de arquitetura de processadores que favorece um conjunto simples e pequeno de instruções que levam aproximadamente a mesma quantidade de tempo para serem executadas.

- **ROM (Read-Only Memory)**: Memória de leitura apenas, usada para armazenar dados permanentes ou instruções essenciais que não podem ser alteradas, como o firmware do dispositivo. Diferentemente da RAM, a ROM é não volátil, mantendo os dados mesmo sem energia.

- **Sistema embarcado**: Um sistema de computação projetado para realizar uma tarefa específica, geralmente incorporado em dispositivos maiores. Utiliza microcontroladores ou microprocessadores e é comum em aplicações como automóveis, eletrodomésticos, sistemas médicos e dispositivos IoT.

### Microprocessador VS Microcontrolador
- Microprocessadores: Não possuem RAM, ROM ou I/O's. Devem ser conectados externamente a RAM, ROM e I/O's.

- Microcontroladores: CPU, RAM, ROM e I/O's estão juntos em um mesmo IC.

### Tipos de computadores
Computadores usalmente podem ser divididos em três grupos:
- PC's: Inclui Desktop's e notebooks. Feito para uso geral (ler artigos, jogar, trabalhar, etc), usam microprocessadores.
- Servidores: Usados para hospedar sites, armazenar bancos de dados e processar grandes quantidades de dados.
- Sistemas embarcados: Computadores de uso específico, nos quais o software e o hardware estão integrados para realizar uma tarefa específica. Exemplos incluem câmeras digitais, aspiradores de pó, players de MP3, mouses, teclados e impressoras. Na maioria das vezes, utilizam microcontroladores, mas quando necessário, processadores de uso geral podem ser usados.

### Como escolher um microcontrolador?
Microcontrolador devem ser escolhidos com base nas caracteristicas do chip (velocidade de clock, consumo de energia, preço e memórias e periféricos integrados) e recursos disponiveis (suporte, IDE, produção ativa, etc)

## Arquitetura ARM
ARM (Advanced RISC Machine) é uma família de arquiteturas de processadores baseadas no modelo RISC (Reduced Instruction Set Computing). A ARM Holdings, uma empresa britânica, é a responsável pelo desenvolvimento e licenciamento dessas arquiteturas. A arquitetura ARM é caracterizada por: eficiência energética, simplicidade, tamanho compacto e capacidade de personalização

### Pequeno historico
ARM surgiu na decada de 1980 dentro da empresa "Acorn Computers" (Reino unido) graças ao trabalho de Steve Furber e Sophie Wilson que trabalharam para definir a arquitetura ARM e suas instruções. Em 1985 o primeiro microprocessador ARM foi produzido, mas devido a competição com a arquitetura x86, a empresa "Acorn Computers" foi forçada a focar no mercado de microcontroladores para sistemas embarcados. Graças a seu sucesso no mercado de microcontroladores e ao interesse crecente no uso do chip, a empresa "ARM" foi fundada para licenciar o uso da arquitetura para empresas de fabricação e desenvolvimento de semicondutores. 

### Adaptabilidade tem suas desvantagens
A arquitetura ARM, incluindo registradores, instruções e mapa de memória, é definida e patenteada pela "ARM Holdings". Fabricantes licenciam essa propriedade intelectual (PI) e adicionam seus próprios periféricos. Embora a CPU seja a mesma em chips ARM de diferentes fornecedores, os periféricos (portas I/O, UART, temporizadores, ADC, SPI, DAC, I2C, etc.) e memórias (memória Flash, SRAM) variam. Isso resulta em incompatibilidade ao tentar usar uma mesmo código em diferentes chips ARM, sendo uma das principais desvantagens dessa arquitetura. Um programa para a porta serial de um chip ARM da Texas Instruments, por exemplo, pode não funcionar em um chip ARM da NXP.