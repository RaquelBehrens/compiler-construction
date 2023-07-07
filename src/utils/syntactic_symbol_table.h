#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 1000

//structing syntax symbol table
typedef struct {
    char symbol[32];
    char type[32];
    int usage_count;
    int dimension;
} sst;

sst* lookup_sst_symbol(sst *symbol_table, int num_symbols, char* symbol) {
    int i;
    printf("%s\n", symbol);
    sst * teste = symbol_table;
    for (i = 0; i < num_symbols; i++) {
        if (strcmp(symbol_table[i].symbol, symbol) == 0) {
            return &symbol_table[i];
        }
    }
    return NULL;
}

void insert_new_sst_symbol(sst *symbol_table, int num_symbols, char* symbol, char* type, int usage_count, int dimension) {
    sst* table_entry = lookup_sst_symbol(symbol_table, num_symbols, symbol);
    if (table_entry == NULL) {
        if (num_symbols >= MAX_SYMBOLS) {
            printf("Error: symbol table overflow\n");
            return;
        }
        strcpy(symbol_table[num_symbols].symbol, symbol);
        strcpy(symbol_table[num_symbols].type, type);
        symbol_table[num_symbols].usage_count = usage_count;
        symbol_table[num_symbols].dimension = dimension;

        num_symbols = num_symbols + 1;
    } else {
        printf("Error: symbol declared two times in the same scope\n");
    }
}

void print_sst_table(sst *symbol_table, int num_symbols) {
    int i;
    printf("Symbol Table\n");
    for (i = 0; i < num_symbols; i++) {
        printf("%s, %s, %d\n", symbol_table[i].symbol, symbol_table[i].type, symbol_table[i].usage_count);
    }
}

