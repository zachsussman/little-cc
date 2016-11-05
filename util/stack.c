#include "../diff.h"
#include "stack.h"
#include "list.h"

bool is_stack(stack* S) {
    return S != NULL && is_segment(S->top, S->bottom);
}

stack* stack_new() {
    stack* S = malloc(sizeof(stack));
    S->top = malloc(sizeof(list));
    S->bottom = S->top;

    assert(is_stack(S));
    return S;
}

bool stack_empty(stack* S) {
    assert(is_stack(S));

    return S->top == S->bottom;
}

void push(stack* S, void* d) {
    assert(is_stack(S));

    list* l = malloc(sizeof(list));
    l->data = d;
    l->next = S->top;
    S->top = l;

    assert(is_stack(S));
}

void* pop(stack* S) {
    assert(is_stack(S));
    assert(!stack_empty(S));

    void* r = S->top->data;
    S->top = S->top->next;

    assert(is_stack(S));
    return r;
}