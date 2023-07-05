#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX_VAR 50

typedef struct {
    char node_before[32];
    int is_funcall;
    char op[2];
    char code[200];
    char last_temp[3];
    char var[50];
} semantic;

char* DEALLOCATED_TEMP_VARS[MAX_VAR] ;
char* ALLOCATED_TEMP_VARS[MAX_VAR];
int LABEL_COUNT = 0;
int unused_temps = 0;

void get_temp_var(char* var) {
    if (unused_temps) {
        char* var = DEALLOCATED_TEMP_VARS[unused_temps - 1];
        ALLOCATED_TEMP_VARS[MAX_VAR - unused_temps - 1];
        unused_temps = unused_temps - 1;
        return;
    }else {
        // Create a t<0~> variable name to be used
        int i = 0;
        while (i < MAX_VAR) {
            strcpy(var, "t");
            char num[2];
            snprintf(num, 2 + 1, "%d", i);
            strcat(var, num);
            for(int j; j < MAX_VAR; j++) {
                if (strcmp(var, ALLOCATED_TEMP_VARS[j]) != 0 && j>=i) {
                    ALLOCATED_TEMP_VARS[j] = var;
                    return;
                }
            }
            i += 1;
        }
        printf("\nMAX TEMP VAR USED\n");
    }
}

void free_temp_var(char* var) {
    for(int j; j < MAX_VAR; j++) {
        if (strcmp(var, ALLOCATED_TEMP_VARS[j]) == 0) {
            ALLOCATED_TEMP_VARS[j] = "0";
            break;
        }
    }
    DEALLOCATED_TEMP_VARS[unused_temps] = var;
    unused_temps += 1;
}

void new_label(char* lbl) {
    strcpy(lbl, "LABEL");
    char num[2];
    snprintf(num, 2 + 1, "%d", LABEL_COUNT);
    strcat(lbl, num);
    LABEL_COUNT += 1;
}