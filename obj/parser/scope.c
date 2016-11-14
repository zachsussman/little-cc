# 1 "parser/scope.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/scope.c" 2
# 1 "parser/../diff.h" 1
# 20 "parser/../diff.h"
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
# 2 "parser/scope.c" 2
# 1 "parser/scope.h" 1


# 1 "parser/types.h" 1


# 1 "parser/../util/queue.h" 1



# 1 "parser/../util/../tokenizer/tokens.h" 1


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
# 5 "parser/../util/queue.h" 2
# 1 "parser/../util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 6 "parser/../util/queue.h" 2

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
# 4 "parser/types.h" 2
# 1 "parser/../util/hash.h" 1



typedef struct hash_chain_s hash_chain;
struct hash_chain_s {
    char* key;
    void* value;
    hash_chain* next;
};

typedef struct hash_s hash;
struct hash_s {
    int size;
    int capacity;
    hash_chain** chains;
};


long hash_str(char *str);
hash* hash_new(int capacity);
bool hash_in(hash* H, char* k);
void hash_insert(hash* H, char* k, void* v);
void* hash_get(hash* H, char* k);
void hash_do_over(hash* H, void* info, void* f);
# 5 "parser/types.h" 2

typedef enum lang_type_e lang_type;
enum lang_type_e {
    LANG_INT,
    LANG_VOID,
    LANG_CHAR,
    LANG_POINTER,
    LANG_FN,
    LANG_STRUCT,
    LANG_UNDET_STRUCT,
    LANG_UNDET
};

typedef struct var_type_s var_type;
struct var_type_s {
    lang_type base;
    void* extra;
};

typedef struct t_fn_extra_s t_fn_extra;
struct t_fn_extra_s {
    var_type* ret;
    queue* args;
};

typedef struct t_struct_field_s t_struct_field;
struct t_struct_field_s {
    var_type* type;
    int index;
};

typedef struct t_struct_extra_s t_struct_extra;
struct t_struct_extra_s {
    int nfields;
    int size;
    hash* fields;
    char* name;
};

void types_init();
var_type* type_new_base(lang_type t);
var_type* type_new_pointer(var_type* inner);
var_type* type_pointer_inner(var_type* p);
var_type* type_new_fn(var_type* ret);


var_type* type_new_struct(char* name);
void type_add_field(var_type* s, char* name, var_type* type);
t_struct_field* type_get_field(var_type* s, char* name);

var_type* type_new_undet_struct(char* name);
var_type* type_new_undet(char* name);



void type_print(var_type* v);
# 4 "parser/scope.h" 2


typedef enum scope_type_e scope_type;
enum scope_type_e {
    VAR_GLOBAL,
    VAR_ARG,
    VAR_LOCAL,
    VAR_CONST
};

typedef struct var_info_s var_info;
struct var_info_s {
    var_type* lang_t;
    scope_type type;
    int index;
};


typedef struct scope_s scope;
struct scope_s {
    hash* locals;
    scope* parent;
    int nown;
    int nall;
};

bool is_scope(scope* s);
scope* scope_new(scope* parent);
void scope_add_local(scope* s, char* name, var_type* t);
var_info* scope_find_local(scope* s, char* name);
# 3 "parser/scope.c" 2


bool is_scope(scope* s) {
    return s != 0 && s->locals != 0 &&
           s->nown == s->locals->size*8 && s->nall >= s->nown;
}

scope* scope_new(scope* parent) {
    my_assert("parser/scope.c", 11, "is_scope(parent) || parent == NULL", is_scope(parent) || parent == 0);

    scope* s = malloc(sizeof(scope));
    s->locals = hash_new(10);
    s->nown = 0;
    s->nall = 0;
    s->parent = parent;

    return s;
}

int scope_get_next_index(scope* s) {
    if (s == 0) return 0;
    else return scope_get_next_index(s->parent) + s->nown;
}

void scope_add_count(scope* s, int c) {
    while (s != 0) {
        s->nall = s->nall + c;
        s = s->parent;
    }
}

void scope_add_local(scope* s, char* name, var_type* t) {
    if (hash_get(s->locals, name) != 0) return;

    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_LOCAL;
    v->index = scope_get_next_index(s);

    hash_insert(s->locals, strdup(name), v);
    int size = 8;
    s->nown = s->nown + size;
    scope_add_count(s, size);
}

var_info* scope_find_local(scope* s, char* name) {
    if (s == 0) return 0;

    var_info* v = hash_get(s->locals, name);
    if (v == 0) return scope_find_local(s->parent, name);
    else return v;
}
