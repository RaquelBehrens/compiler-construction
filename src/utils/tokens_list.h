#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 1000

typedef struct {
    yytokentype type;
    char* word
} token_t;

char* tokens[MAX_SYMBOLS];
int num_tokens = 0;

//char* lookup_token(char* symbol);

void insert_token(token_t yytoken) {
    if (num_tokens >= MAX_SYMBOLS) {
        printf("Error: symbol table overflow\n");
        return;
    }
    tokens[num_tokens] = new_token;
    num_tokens++;
}
/*
char* lookup_token(char* symbol) {
    int i;
    for (i = 0; i < num_tokens; i++) {
        if (strcmp(tokens[i], symbol) == 0) {
            return tokens[i];
        }
    }
    return NULL;
}*/

void print_tokens() {
    int i;
    printf("Tokens\n");
    for (i = 0; i < num_tokens; i++) {
        printf("%s\n", tokens[i]);
    }
}