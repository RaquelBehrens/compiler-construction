#include <stdio.h>
#include <string.h>

#define TYPES_QUANTITY 19

typedef struct {
    char node_before[32];
    char node_after[32];
    char operator[32];
    char result[32];
} operation;

operation valid_operations[TYPES_QUANTITY] = {
    {"string", "string", "+", "string"},
    {"int", "int", "+", "int"},
    {"int", "int", "-", "int"},
    {"int", "int", "*", "int"},
    {"int", "int", "%", "int"},
    {"int", "int", "/", "int"},
    {"float", "float", "+", "float"},
    {"float", "float", "-", "float"},
    {"float", "float", "*", "float"},
    {"float", "float", "%", "float"},
    {"float", "float", "/", "float"},
    {"float", "int", "+", "float"},
    {"float", "int", "-", "float"},
    {"float", "int", "*", "float"},
    {"float", "int", "/", "float"},
    {"int", "float", "+", "float"},
    {"int", "float", "-", "float"},
    {"int", "float", "*", "float"},
    {"int", "float", "/", "float"},
};

char * check_operation(char* node_before, char* node_after, char* operator) {
    for (int i = 0; i < TYPES_QUANTITY; i++) {
        if ((strcmp(valid_operations[i].node_before, node_before) == 0) &&
            (strcmp(valid_operations[i].node_after, node_after) == 0) &&
            (strcmp(valid_operations[i].operator, operator) == 0) 
            ) {
            return valid_operations[i].result;
        }
    }

    printf("Error: Invalid Type Operation between %s %s %s!\n", node_before, operator, node_after);
    return NULL;
}