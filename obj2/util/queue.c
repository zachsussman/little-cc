# 1 "util/queue.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "util/queue.c" 2
# 1 "util/queue.h" 1


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
# 4 "util/queue.h" 2
# 1 "util/../tokenizer/tokens.h" 1


enum token_type_e {
    NAME,
    NUMBER,
    STRING,
    CHARACTER,

    OPEN_BRACE,
    CLOSED_BRACE,

    SEMICOLON,

    OP_PLUS,
    OP_MINUS,
    OP_MUL,
    OP_DIV,
    OP_SINGLE_AND,
    OP_SINGLE_OR,
    OP_BOOL_AND,
    OP_BOOL_OR,
    OP_ASSIGN,
    OP_EQ,
    OP_NOT_BANG,
    OP_NOT_TILDE,
    OP_NEQ,

    OP_LT,
    OP_GT,
    OP_LTE,
    OP_GTE,
    OP_ARROW,
    OP_DOT,

    OP_INC,
    OP_DEC,

    OP_COLON,
    OP_QUESTION,

    OP_COMMA,

    OPEN_PAREN,
    CLOSED_PAREN,
    OPEN_BRACKET,
    CLOSED_BRACKET,

    KW_INT,
    KW_IF,
    KW_WHILE,
    KW_RETURN,
    KW_VOID,
    KW_ELSE,
    KW_STRUCT,
    KW_SIZEOF,
    KW_TYPEDEF,
    KW_CHAR,
    KW_FOR,
    KW_SWITCH,
    KW_CASE,
    KW_DEFAULT,
    KW_BREAK,
    KW_ENUM,

    OTHER
};
typedef enum token_type_e token_type;

typedef struct token_s token;
struct token_s {
    token_type type;
    char* repr;
};

token* token_new(token_type t, char* r);
void token_delete(token* t);
char* str_token_type(token* t);
# 5 "util/queue.h" 2
# 1 "util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 6 "util/queue.h" 2

typedef struct queue_s queue;
struct queue_s {
    list* front;
    list* back;
};

queue* queue_new();
bool queue_empty(queue* Q);
void enq(queue* Q, void* d);
void* peek(queue* Q);
void* deq(queue* Q);
queue* queue_readonly(queue* Q);
int queue_length(queue* Q);
void queue_free(queue* Q);

void queue_test();
# 2 "util/queue.c" 2


bool is_segment_q(list* a, list* b) {
    if (a == 0 || b == 0) return 0;
    else if (a == b) return 1;
    else return is_segment_q(a->next, b);
}


bool is_queue(queue* Q) {
    return Q != 0 && is_segment_q(Q->front, Q->back);
}

queue* queue_new() {

    queue* Q = malloc(sizeof(queue));
    Q->front = malloc(sizeof(list));
    Q->back = Q->front;
    Q->front->next = 0;


    my_assert("util/queue.c", 23, "is_queue(Q)", is_queue(Q));
    return Q;
}

bool queue_empty(queue* Q) {
    my_assert("util/queue.c", 28, "is_queue(Q)", is_queue(Q));

    return Q->front == Q->back;
}

void enq(queue* Q, void* d) {
    my_assert("util/queue.c", 34, "is_queue(Q)", is_queue(Q));


    list* l = malloc(sizeof(list));

    my_assert("util/queue.c", 39, "l != NULL", l != 0);
    Q->back->data = d;
    Q->back->next = l;
    l->next = 0;
    Q->back = l;

    my_assert("util/queue.c", 45, "is_queue(Q)", is_queue(Q));
}

void* peek(queue* Q) {
    my_assert("util/queue.c", 49, "is_queue(Q)", is_queue(Q));
    my_assert("util/queue.c", 50, "!queue_empty(Q)", !queue_empty(Q));

    return Q->front->data;
}

void* deq(queue* Q) {
    my_assert("util/queue.c", 56, "is_queue(Q)", is_queue(Q));
    my_assert("util/queue.c", 57, "!queue_empty(Q)", !queue_empty(Q));

    void* d = Q->front->data;
    Q->front = Q->front->next;

    my_assert("util/queue.c", 62, "is_queue(Q)", is_queue(Q));
    return d;
}

queue* queue_readonly(queue* Q) {
    my_assert("util/queue.c", 67, "Q != NULL", Q != 0);

    queue* new = malloc(sizeof(queue));
    new->front = Q->front;
    new->back = Q->back;
    return new;
}

int queue_length(queue* Q) {
    list* l = Q->front;
    int length = 0;
    while (l != Q->back) {
        l = l->next;
        length++;
    }
    return length;
}
