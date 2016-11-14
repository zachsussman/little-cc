#include "diff.h"

void my_assert(char* file, int line, char* cond, bool c) {
    if (!c) {
        printf("%s:%d assertion failed: %s\n", file, line, cond);
        exit(1);
    }
}