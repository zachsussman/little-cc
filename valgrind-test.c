#include <stdlib.h>

struct s {
    int* a;
    int* b;
};

int main() {
    struct s* p = malloc(sizeof(struct s));
    free(p);
    return 0;
}