#include <stdio.h>
#include <string.h>

#define MAX_LISTS 1000

union List {
    int value;
    struct recursive_list * list;
};

//structing syntax symbol table
typedef struct recursive_list {
    union List list;
} recursive_list;

