# Variáveis
CC = arm-none-eabi-gcc
CFLAGS = -Wall -O3 -mcpu=cortex-m3 -mthumb

# Alvo principal
default: all

# Nome do arquivo fonte
SRC = $(FILE).c
BIN = $(FILE).bin
ASM = $(FILE).s

# Regras
all: $(BIN) $(ASM)

$(BIN): $(SRC)
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

$(ASM): $(SRC)
	$(CC) $(CFLAGS) -S -o $(ASM) $(SRC)

# Limpeza
clean:
	rm -f $(BIN) $(ASM)
