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
    printf("1\n");
    printf("%s\n", node_before);
    if (strcmp(node_before, node_after) == 0) {
        printf("1\n");
        if (strcmp(node_before, "string") == 0) {
            printf("1\n");
            if (strcmp(operation, "+") != 0) {
                printf("Operator between strings is not +");
            }
            return node_before;
        }

    }
    printf("1\n");
    printf("Error: Invalid Type Operation between %s %s %s!\n", node_before, operation, node_after);
    
    return "0";
}