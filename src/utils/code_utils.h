#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char last_for_end_lable_[10];
int LABEL_COUNT = 0;

typedef struct opt_else {
    char label[10];
    char code[100];
} opt_else;

void get_temp_var(char* var, int num_v) {
    // Create a t<0~> variable name to be used
    char num[3];
    strcpy(var, "t");
    snprintf(num, 2 + 1, "%d", num_v);
    strcat(var, num);
}

void new_label(char* lbl) {
    strcpy(lbl, "LABEL");
    char num[2];
    snprintf(num, 2 + 1, "%d", LABEL_COUNT);
    strcat(lbl, num);
    LABEL_COUNT += 1;
}