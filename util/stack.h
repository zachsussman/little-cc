#pragma once

#include <stdbool.h>
#include "list.h"

typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);