#include <stdio.h>
#include <string.h>

#define MAX_LISTS 1000

//structing syntax symbol table
typedef struct recursive_list {
    int value;
    struct recursive_list * list;
} recursive_list;

