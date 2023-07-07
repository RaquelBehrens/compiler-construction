// Implementing Static Stack using an Array in C
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// MAX_SCOPES will be the capacity of the Static Stack
#define MAX_SCOPES 1000

typedef struct {
    sst symbol_table[MAX_SCOPES];
    int num_symbols;
    bool is_loop;
} scope;

// Initializing the top of the stack to be 0, because the stack initializes with the main scope
int top = 0;
int top_all_scopes = 0;

// Initializing the stack using an array
scope scopes[MAX_SCOPES];
scope all_scopes[MAX_SCOPES];

// Function prototypes
void push();       // Push element to the top of the stack
scope* pop();         // Remove and return the top most element of the stack
scope peek();        // Return the top most element of the stack
bool is_empty();    // Check if the stack is in Underflow state or not
bool is_full();     // Check if the stack is in Overflow state or not


void push(scope x){
    if(top == MAX_SCOPES-1)
        printf("Overflow Error: can't add more elements into the stack\n");
    else{
        top += 1;
        scopes[top] = x;
        scopes[top].num_symbols = 0;
    }
}

void push_all_scopes(scope x){
    if(top_all_scopes == MAX_SCOPES-1)
        printf("Overflow Error: can't add more elements into the stack\n");
    else{
        top_all_scopes += 1;
        all_scopes[top_all_scopes] = x;
    }
}

scope* pop(){
    if(top == -1) {
        printf("Underflow Error: Stack already empty, can't remove any element\n");
        return NULL;
    } else {
        scope* x = &scopes[top];
        top -= 1;
        return x;
    }
}

scope peek(){
    scope x = scopes[top];
    return x;
}

bool is_empty(){
    return top == -1;
}

bool is_full(){
    return top == MAX_SCOPES-1;
}
