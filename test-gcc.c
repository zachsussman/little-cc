#include <stdlib.h>
#include <stdio.h>
#include "util/hash.h"

int main() {
    char* a = malloc(sizeof(char)*3);
    a[0] = 'a';
    a[1] = 'b';
    a[2] = 0;

    char* b = malloc(sizeof(char)*3);
    b[0] = 'a';
    b[1] = 'b';
    b[2] = 0;

    printf("%i %i\n", hash_str(a), hash_str(b));
    return 0;
}