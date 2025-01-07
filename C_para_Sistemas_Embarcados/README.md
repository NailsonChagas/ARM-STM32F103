# Compilação para ARM 32

Este documento explica como preparar o ambiente de desenvolvimento e como usar o Makefile para compilar códigos fonte C para binário e código assembly na arquitetura ARM 32.

## Pré-requisitos (Toolchain ARM):
Instale o `arm-none-eabi-gcc` e outros utilitários do toolchain.
```bash
sudo apt update && sudo apt install gcc-arm-none-eabi
```

## Usando o Makefile
1. **Prepare o arquivo fonte**:
    - Certifique-se de que seu arquivo fonte C está no mesmo diretório que o Makefile. Exemplo:
     ```
     main.c
     Makefile
     ```

2. **Compilando o código**:
    - Para compilar o arquivo fonte, execute o seguinte comando, substituindo `main` pelo nome do seu arquivo (sem a extensão):
     ```bash
     make FILE=main
     ```
    - Isso irá gerar dois arquivos:
        - `main`: o binário executável.
        - `main.s`: o código assembly correspondente.

3. **Limpando os arquivos gerados**:
    - Para limpar os arquivos gerados pela compilação, execute:
     ```bash
     make clean
     ```

## Personalizações
- Para mudar as opções de compilação, edite a variável `CFLAGS` no Makefile. Por exemplo:
  ```make
  CFLAGS = -Wall -O2 -mcpu=cortex-m3 -mthumb
  ```
- Certifique-se de ajustar o `-mcpu` de acordo com o modelo do microcontrolador que você está utilizando.