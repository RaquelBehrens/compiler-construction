// Implementing Static Stack using an Array in C

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// N will be the capacity of the Static Stack
#define N 1000

typedef struct {
    sst symbol_table[N];
    int num_symbols;
    bool is_loop;
} scope;

// Initializing the top of the stack to be 0, because the stack initializes with the main scope
int top = 0;

// Initializing the stack using an array
scope scopes[N];

// Function prototypes
void push();       // Push element to the top of the stack
sst pop();         // Remove and return the top most element of the stack
sst peek();        // Return the top most element of the stack
bool is_empty();    // Check if the stack is in Underflow state or not
bool is_full();     // Check if the stack is in Overflow state or not


void push(sst x){
    if(top == N-1)
        printf("Overflow Error: can't add more elements into the stack\n");
    else{
        top += 1;
        scopes[top] = x;
    }
}

sst pop(){
    if(top == -1)
        printf("Underflow Error: Stack already empty, can't remove any element\n");
    else{
        sst x = scopes[top];
        top -= 1;
        return x;
    }
    return null;
}

sst peek(){
    sst x = scopes[top];
    return x;
}

bool is_empty(){
    return top == -1
}

bool is_full(){
    return top == N-1
}