# 1 "tokenizer/tokens.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "tokenizer/tokens.c" 2
# 1 "tokenizer/../diff.h" 1
# 20 "tokenizer/../diff.h"
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
# 2 "tokenizer/tokens.c" 2

# 1 "tokenizer/tokens.h" 1


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
# 4 "tokenizer/tokens.c" 2

bool is_token(token* T) {
    return T != 0 && T->repr != 0;
}

token* token_new(token_type type, char* r) {
    token* T = malloc(sizeof(token));
    T->type = type;
    T->repr = r;

    my_assert("tokenizer/tokens.c", 14, "is_token(T)", is_token(T));
    return T;
}

bool is_dynamic_token(token* T) {
    return T->type == NAME || T->type == NUMBER || T->type == STRING ||
            T->type == CHARACTER || T->type == OTHER;
}

void token_delete(token* T) {
    my_assert("tokenizer/tokens.c", 24, "is_token(T)", is_token(T));
    if (is_dynamic_token(T)) free(T->repr);
    free(T);
}

char* str_token_type(token* T) {
    my_assert("tokenizer/tokens.c", 30, "is_token(T)", is_token(T));

    switch(T->type) {
        case NAME:
            return "NAME";
            break;

        case NUMBER:
            return "NUMBER";
            break;

        case KW_INT:
            return "KW";
            break;

        case OTHER:
            return "OTHER";
            break;

        default:
            return "SYMBOL";
            break;
    }
}
