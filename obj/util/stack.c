# 1 "util/stack.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "util/stack.c" 2
# 1 "util/../diff.h" 1
# 20 "util/../diff.h"
typedef int bool;
typedef int long;



typedef int size_t;

void my_assert();

void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
void* fopen();
char* strndup();
int strtol();
char* strdup();
void fprintf(void* f, char* b);
void fclose(void* f);
# 2 "util/stack.c" 2
# 1 "util/stack.h" 1



# 1 "util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 5 "util/stack.h" 2

typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);
# 3 "util/stack.c" 2


bool is_stack(stack* S) {
    return S != 0 && is_segment(S->top, S->bottom);
}

stack* stack_new() {
    stack* S = malloc(sizeof(stack));
    S->top = malloc(sizeof(list));
    S->bottom = S->top;

    my_assert("util/stack.c", 14, "is_stack(S)", is_stack(S));
    return S;
}

bool stack_empty(stack* S) {
    my_assert("util/stack.c", 19, "is_stack(S)", is_stack(S));

    return S->top == S->bottom;
}

void push(stack* S, void* d) {
    my_assert("util/stack.c", 25, "is_stack(S)", is_stack(S));

    list* l = malloc(sizeof(list));
    l->data = d;
    l->next = S->top;
    S->top = l;

    my_assert("util/stack.c", 32, "is_stack(S)", is_stack(S));
}

void* pop(stack* S) {
    my_assert("util/stack.c", 36, "is_stack(S)", is_stack(S));
    my_assert("util/stack.c", 37, "!stack_empty(S)", !stack_empty(S));

    void* r = S->top->data;
    S->top = S->top->next;

    my_assert("util/stack.c", 42, "is_stack(S)", is_stack(S));
    return r;
}
