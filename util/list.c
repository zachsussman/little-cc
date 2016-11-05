#include "../diff.h"
#include "list.h"

bool is_segment(list* a, list* b) {
    if (a == NULL) return false;
    if (a == b) return true;
    return is_segment(a->next, b);
}