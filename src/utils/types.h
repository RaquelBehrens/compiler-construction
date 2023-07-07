#include <stdio.h>
#include <string.h>

#define TYPES_QUANTITY 19


union Value {
    int i;
    float f;
    char str[100];
};

typedef struct {
    char * node_before;
    char * node_after;
    char operation[3];
    char * result;
    union Value value;
} node;

node valid_operations[TYPES_QUANTITY] = {
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
};

char * check_operation(char* node_before, char* node_after, char* operation) {
    if (strcmp(node_before, node_after) == 0) {
        if (strcmp(node_before, "string") == 0) {
            if (strcmp(operation, "+") != 0) {
                printf("Operator between strings is not +");
            }
            return node_before;
        }

    }
    
    printf("Error: Invalid Type Operation between %s %s %s!\n", node_before, operation, node_after);
    return "0";
}