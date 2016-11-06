# 1 "parser/types.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/types.c" 2
# 1 "parser/../diff.h" 1
# 17 "parser/../diff.h"
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
# 2 "parser/types.c" 2

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


int hash_str(char *str);
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
};

void types_init();
var_type* type_new_base(lang_type t);
var_type* type_new_pointer(var_type* inner);
var_type* type_pointer_inner(var_type* p);
var_type* type_new_fn(var_type* ret);


var_type* type_new_struct();
void type_add_field(var_type* s, char* name, var_type* type);
t_struct_field* type_get_field(var_type* s, char* name);

var_type* type_new_undet_struct(char* name);
var_type* type_new_undet(char* name);



void type_print(var_type* v);
# 4 "parser/types.c" 2

var_type* VAR_INT = 0;
var_type* VAR_VOID = 0;
var_type* VAR_CHAR = 0;
var_type* type_new_base(lang_type t) {
    if (VAR_INT == 0) {
        VAR_INT = malloc(sizeof(var_type));
        VAR_INT->base = LANG_INT;
        VAR_INT->extra = 0;
    }
    if (VAR_VOID == 0) {
        VAR_VOID = malloc(sizeof(var_type));
        VAR_VOID->base = LANG_VOID;
        VAR_VOID->extra = 0;
    }
    if (VAR_CHAR == 0) {
        VAR_CHAR = malloc(sizeof(var_type));
        VAR_CHAR->base = LANG_CHAR;
        VAR_CHAR->extra = 0;
    }

    if (t == LANG_INT) return VAR_INT;
    else if (t == LANG_VOID) return VAR_VOID;
    else if (t == LANG_CHAR) return VAR_CHAR;
    else {
        printf("Unknown type %i\n", t);
        exit(1);
    }
}

var_type* type_new_pointer(var_type* inner) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_POINTER;
    v->extra = (void*) inner;
    return v;
}

var_type* type_pointer_inner(var_type* p) {
    return (var_type*) (p->extra);
}

var_type* type_new_fn(var_type* ret);

var_type* type_new_struct() {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_STRUCT;
    t_struct_extra* e = malloc(sizeof(t_struct_extra));
    e->nfields = 0;
    e->size = 0;
    e->fields = hash_new(5);
    v->extra = (void*) e;
    return v;
}

void type_add_field(var_type* s, char* name, var_type* type) {
    0;
    0;

    t_struct_extra* e = (t_struct_extra*) s->extra;
    t_struct_field* f = malloc(sizeof(t_struct_field));
    f->type = type;
    f->index = e->nfields;
    (e->nfields)++;
    (e->size) += 8;

    hash_insert(e->fields, strdup(name), f);
}

t_struct_field* type_get_field(var_type* s, char* name) {
    0;
    0;

    t_struct_extra* e = (t_struct_extra*) s->extra;
    return (t_struct_field*) hash_get(e->fields, name);
}


var_type* type_new_undet_struct(char* name) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_UNDET_STRUCT;
    v->extra = (void*) strdup(name);
    return v;
}

var_type* type_new_undet(char* name) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_UNDET;
    v->extra = (void*) strdup(name);
    return v;
}


void type_print(var_type* v) {
    0;

    switch (v->base) {
        case LANG_INT:
            printf("int");
            break;
        case LANG_VOID:
            printf("void");
            break;
        case LANG_CHAR:
            printf("char");
            break;
        case LANG_POINTER:
            type_print(type_pointer_inner(v));
            printf("*");
            break;
        case LANG_UNDET_STRUCT:
            printf("struct %s", v->extra);
            break;
        case LANG_UNDET:
            printf("%s", v->extra);
            break;
        default:
            printf("TYPE_UNKNOWN");
            break;
    }
}
