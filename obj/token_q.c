# 1 "token_q.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "token_q.c" 2
# 1 "./token_q.h" 1


# 1 "./diff.h" 1
# 17 "./diff.h"
typedef int bool;



typedef int size_t;


void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
void* fopen();
# 4 "./token_q.h" 2
# 1 "./tokenizer/tokens.h" 1


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
# 5 "./token_q.h" 2
# 1 "./util/queue.h" 1




# 1 "./util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 6 "./util/queue.h" 2

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
# 6 "./token_q.h" 2

void token_enq(queue* Q, token* d);
token* token_peek(queue* Q);
token* token_deq(queue* Q);
# 2 "token_q.c" 2



void token_enq(queue* Q, token* t) {
    enq(Q, (void*) t);
}

token* token_deq(queue* Q) {
    token* t = (token*) deq(Q);
    if (1) printf("%s ", t->repr, t->type);
    return t;
}

token* token_peek(queue* Q) {
    return (token*) peek(Q);
}
