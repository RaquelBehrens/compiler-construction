#include <stdio.h>
#include <string.h>
#include "../../y.tab.h"

#define MAX_SYMBOLS 1000

typedef struct {
    yytoken_kind_t type;
    char word[32]; // allocate space for the token word
} token_t;

token_t tokens[MAX_SYMBOLS];
int num_tokens = 0;

void insert_token(yytoken_kind_t type, char* word) {
    if (num_tokens >= MAX_SYMBOLS) {
        printf("Error: symbol table overflow\n");
        return;
    }
    tokens[num_tokens].type = type;
    strcpy(tokens[num_tokens].word, word);
    num_tokens++;
}

token_t* lookup_token(char* symbol) {
    int i;
    for (i = 0; i < num_tokens; i++) {
        if (strcmp(tokens[i].word, symbol) == 0) {
            return &tokens[i];
        }
    }
    return NULL;
}

void print_tokens() {
    int i;
    printf("Tokens\n");
    for (i = 0; i < num_tokens; i++) {
        printf("<%d, %s>\n", tokens[i].type, tokens[i].word);
        continue;
    }
}
