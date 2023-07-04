#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 19

typedef struct {
    char node_before[32];
    char node_after[32]
    char operator[32];
    char result[32];
} operation;

operation valid_operations[MAX_SYMBOLS];

valid_operations[0].node_before = "string";
valid_operations[0].node_after = "string";
valid_operations[0].operator = "+";
valid_operations[0].result = "string";

valid_operations[1].node_before = "int";
valid_operations[1].node_after = "int";
valid_operations[1].operator = "+";
valid_operations[1].result = "int";

valid_operations[2].node_before = "int";
valid_operations[2].node_after = "int";
valid_operations[2].operator = "-";
valid_operations[2].result = "int";

valid_operations[3].node_before = "int";
valid_operations[3].node_after = "int";
valid_operations[3].operator = "*";
valid_operations[3].result = "int";

valid_operations[4].node_before = "int";
valid_operations[4].node_after = "int";
valid_operations[4].operator = "%";
valid_operations[4].result = "int";

valid_operations[5].node_before = "int";
valid_operations[5].node_after = "int";
valid_operations[5].operator = "/";
valid_operations[5].result = "int";

valid_operations[6].node_before = "float";
valid_operations[6].node_after = "float";
valid_operations[6].operator = "+";
valid_operations[6].result = "float";

valid_operations[7].node_before = "float";
valid_operations[7].node_after = "float";
valid_operations[7].operator = "-";
valid_operations[7].result = "float";

valid_operations[8].node_before = "float";
valid_operations[8].node_after = "float";
valid_operations[8].operator = "*";
valid_operations[8].result = "float";

valid_operations[9].node_before = "float";
valid_operations[9].node_after = "float";
valid_operations[9].operator = "%";
valid_operations[9].result = "float";

valid_operations[10].node_before = "float";
valid_operations[10].node_after = "float";
valid_operations[10].operator = "/";
valid_operations[10].result = "float";

valid_operations[11].node_before = "float";
valid_operations[11].node_after = "int";
valid_operations[11].operator = "+";
valid_operations[11].result = "float";

valid_operations[12].node_before = "float";
valid_operations[12].node_after = "int";
valid_operations[12].operator = "-";
valid_operations[12].result = "float";

valid_operations[13].node_before = "float";
valid_operations[13].node_after = "int";
valid_operations[13].operator = "*";
valid_operations[13].result = "float";

valid_operations[14].node_before = "float";
valid_operations[14].node_after = "int";
valid_operations[14].operator = "/";
valid_operations[14].result = "float";

valid_operations[15].node_before = "int";
valid_operations[15].node_after = "float";
valid_operations[15].operator = "+";
valid_operations[15].result = "float";

valid_operations[16].node_before = "int";
valid_operations[16].node_after = "float";
valid_operations[16].operator = "-";
valid_operations[16].result = "float";

valid_operations[17].node_before = "int";
valid_operations[17].node_after = "float";
valid_operations[17].operator = "*";
valid_operations[17].result = "float";

valid_operations[18].node_before = "int";
valid_operations[18].node_after = "float";
valid_operations[18].operator = "/";
valid_operations[18].result = "float";

char * check_operation(char* node_before, char* node_after, char* operator) {
    for (int i = 0; i < MAX_SYMBOLS; i++) {
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