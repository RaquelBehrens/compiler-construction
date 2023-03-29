#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 1000

typedef struct {
    int address;
    char symbol[32];
    int usage_count;
} symbol_t;

symbol_t symbol_table[MAX_SYMBOLS];
int num_symbols = 0;

void insert_symbol(int address, char* symbol, int usage_count) {
    if (num_symbols >= MAX_SYMBOLS) {
        printf("Error: symbol table overflow\n");
        return;
    }
    
    symbol_table[num_symbols].address = address;
    strcpy(symbol_table[num_symbols].symbol, symbol);
    symbol_table[num_symbols].usage_count = usage_count;
    num_symbols++;
}

symbol_t* lookup_symbol(char* symbol) {
    int i;
    for (i = 0; i < num_symbols; i++) {
        if (strcmp(symbol_table[i].symbol, symbol) == 0) {
            return &symbol_table[i];
        }
    }
    return NULL;
}

int number_of_symbols() {
    return num_symbols;
}

void print_table() {
    int i;
    printf("Symbol Table\n");
    for (i = 0; i < num_symbols; i++) {
        printf("%d, %s, %d\n", symbol_table[i].address, symbol_table[i].symbol, symbol_table[i].usage_count);
    }
}

