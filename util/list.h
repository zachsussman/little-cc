#pragma once

#include <stdbool.h>

typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);