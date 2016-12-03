#include "../diff.h"
#include "xerror.h"

void xerror(char* msg) {
    printf("Error: %s\n", msg);
    exit(1);
}
