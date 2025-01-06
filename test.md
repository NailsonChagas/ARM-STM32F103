### Acesso a memória em ARM

#### Arquitetura de Memória
- A arquitetura ARM utiliza endereços de 32 bits, possibilitando acesso direto a até 4 GB de memória (endereços de `0x00000000` a `0xFFFFFFFF`), com cada byte possuindo um endereço exclusivo. Isso é conhecido como CPU byte-addressable.
- O barramento de dados (D31–D0) suporta acesso a dados de 8 bits (byte), 16 bits (halfword) e 32 bits (word). Já o barramento de endereços (A31–A0) controla os acessos às memórias internas e externas.

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
        - Endereços reais: 0x20000000 – 0x200FFFFF.
        - Endereços alias: 0x22000000 – 0x23FFFFFF.
    - **Periféricos Bit-Band:**
        - Endereços reais: 0x40000000 – 0x400FFFFF.
        - Endereços alias: 0x42000000 – 0x43FFFFFF.

- **Vantagens**
    - Operações em bits individuais se tornam atômicas (não podem ser interrompidas), aumentando a confiabilidade e eficiência.
