#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX_VAR 200

char* DEALLOCATED_TEMP_VARS[MAX_VAR] ;
char* ALLOCATED_TEMP_VARS[MAX_VAR];
char last_for_end_lable_[10];
int LABEL_COUNT = 0;
int unused_temps = 0;

typedef struct opt_else {
    char label[10];
    char code[100];
} opt_else;

void get_temp_var(char* var) {
    // Create a t<0~> variable name to be used
    char num[3];
    snprintf(num, 2 + 1, "%d", unused_temps);
    strcat(var, num);
    unused_temps += 1;
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