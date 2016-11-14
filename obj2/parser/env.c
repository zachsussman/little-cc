# 1 "parser/env.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/env.c" 2
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
# 2 "parser/env.c" 2
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
# 3 "parser/env.c" 2
# 1 "parser/env.h" 1


# 1 "parser/../util/stack.h" 1



# 1 "parser/../util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 5 "parser/../util/stack.h" 2

typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);
# 4 "parser/env.h" 2

# 1 "parser/ast.h" 1




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
# 6 "parser/ast.h" 2
# 1 "parser/types.h" 1





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
# 7 "parser/ast.h" 2
# 1 "parser/scope.h" 1





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
# 8 "parser/ast.h" 2



typedef enum node_type_e node_type;
enum node_type_e {


    AST_NONE,
    AST_VARIABLE,
    AST_INTEGER,
    AST_CHAR,
    AST_FN_CALL,
    AST_STRING,
    AST_CAST,

    AST_SIZEOF,


    AST_ARROW,
    AST_ARRAY_SUB,
    AST_INCREMENT,
    AST_DECREMENT,


    AST_NEGATIVE,
    AST_ADDRESS,
    AST_DEREFERENCE,
    AST_LOGICAL_NOT,


    AST_MULTIPLICATION,
    AST_DIVISION,


    AST_ADDITION,
    AST_SUBTRACTION,


    AST_LT,
    AST_LTE,
    AST_GT,
    AST_GTE,


    AST_EQ,
    AST_NEQ,



    AST_LOGICAL_AND,


    AST_LOGICAL_OR,


    AST_TERNARY,


    AST_ASSIGN,


    AST_LOCAL_DECLARATION,
    AST_STATEMENT,
    AST_IF,
    AST_WHILE,
    AST_RETURN,
    AST_FOR,
    AST_BREAK,
    AST_SWITCH,


    AST_SEQUENCE,

    AST_FUNCTION,
    AST_GLOBAL_DECLARATION,
    AST_STRUCT_DECLARATION,
    AST_TYPEDEF,
    AST_ENUM,

    AST_FILE
};


typedef struct node_s node;
struct node_s {
    node_type type;
    void* extra;
};

typedef struct extra_var_s extra_var;
struct extra_var_s {
    char* name;
};

typedef struct extra_string_s extra_string;
struct extra_string_s {
    char* s;
};

typedef struct extra_int_s extra_int;
struct extra_int_s {
    int val;
};

typedef struct extra_char_s extra_char;
struct extra_char_s {
    int val;
};

typedef struct extra_call_s extra_call;
struct extra_call_s {
    char* fn_name;
    queue* args;
};

typedef struct extra_sizeof_s extra_sizeof;
struct extra_sizeof_s {
    var_type* type;
};

typedef struct extra_cast_s extra_cast;
struct extra_cast_s {
    var_type* type;
    node* inner;
};

typedef struct extra_arrow_s extra_arrow;
struct extra_arrow_s {
    node* inner;
    char* field;
};

typedef struct extra_binop_s extra_binop;
struct extra_binop_s {
    node* left;
    node* right;
};

typedef struct extra_ternary_s extra_ternary;
struct extra_ternary_s {
    node* left;
    node* middle;
    node* right;
};

typedef struct extra_unop_s extra_unop;
struct extra_unop_s {
    node* inner;
};

typedef struct extra_statement_s extra_statement;
struct extra_statement_s {
    node* expr;
};

typedef struct extra_sequence_s extra_sequence;
struct extra_sequence_s {
    queue* Q;
    scope* sc;
};

typedef struct extra_declaration_s extra_declaration;
struct extra_declaration_s {
    var_type* type;
    char* name;
    node* init;
};

typedef struct extra_if_s extra_if;
struct extra_if_s {
    node* cond;
    node* body;
    node* else_body;
};

typedef struct extra_while_s extra_while;
struct extra_while_s {
    node* cond;
    node* body;
};

typedef struct extra_for_s extra_for;
struct extra_for_s {
    node* init;
    node* cond;
    node* end;
    node* body;
    scope* sc;
};


typedef struct extra_case_s extra_case;
struct extra_case_s {
    int val;
    node* body;
};

typedef struct extra_switch_s extra_switch;
struct extra_switch_s {
    node* cond;
    int length;
    extra_case** cases;
    node* n_default;
    scope* sc;
};

typedef struct extra_fn_arg_s extra_fn_arg;
struct extra_fn_arg_s {
    var_type* type;
    char* name;
};

typedef struct extra_function_s extra_function;
struct extra_function_s {
    var_type* ret;
    char* name;
    int argc;
    extra_fn_arg** args;
    node* body;
    scope* sc;
};

typedef struct extra_struct_s extra_struct;
struct extra_struct_s {
    char* name;
    var_type* decl;
};

typedef struct extra_typedef_s extra_typedef;
struct extra_typedef_s {
    var_type* type;
    char* name;
};

typedef struct extra_enum_s extra_enum;
struct extra_enum_s {
    char* name;
    queue* vals;
};

node* new_node_var(char* name);
node* new_node_int(char* repr);
node* new_node_char(char val);
node* new_node_string(char* s);

node* new_node_call(char* repr);
void node_call_enq(node* call, node* arg);
bool node_call_empty(node* call);
node* node_call_deq(node* call);

node* new_node_sizeof(var_type* type);
node* new_node_cast(var_type* type, node* inner);
node* new_node_arrow(node* inner, char* field);
node* new_node_binop(node_type n, node* left, node* right);
node* new_node_ternary(node_type n, node* left, node* middle, node* right);
node* new_node_unop(node_type n, node* inner);
node* new_node_statement(node* expr);
node* new_node_declaration(node_type scope, var_type* type, char* name, node* init);
node* new_node_if(node* cond, node* body, node* else_body);
node* new_node_while(node* cond, node* body);
node* new_node_for(node* init, node* cond, node* end, node* body);
node* new_node_break();

extra_case* new_node_case(int val, node* body);
node* new_node_switch(node* cond, queue* cases, node* n_default);

node* new_node_sequence();
void sequence_enq(node* seq, node* next);
node* sequence_deq(node* seq);
bool sequence_empty(node* seq);

extra_fn_arg* new_node_fn_arg(var_type* type, char* name);
node* new_node_function(var_type* ret, char* name, queue* args, node* body);
node* new_node_struct(char* name, var_type* decl);
node* new_node_typedef(var_type* type, char* name);
node* new_node_enum(char* name);
void enum_add_val(node* n, char* val);

void ast_construct_scope(node* n);

void print_node(node* n);
# 6 "parser/env.h" 2




typedef struct fn_info_s fn_info;
struct fn_info_s {
    int argc;
    var_type* ret;
    hash* args;
    scope* locals;
    int local_size;
};

typedef struct switch_info_s switch_info;
struct switch_info_s {
    int switchn;
    int max;
    int* addrs;
};

typedef struct env_s env;
struct env_s {
    fn_info* curr_fn;

    int global_count;
    hash* vars;

    int string_count;
    hash* strings;

    scope* sc;

    hash* fns;

    hash* structs;

    hash* typedefs;

    int label_count;

    stack* ends;

    queue* switches;
    int switchn;
};

env* env_new();

void env_add_global(env* E, var_type* t, char* name);
var_info* env_get_info(env* E, char* name);

void env_reg_fn(env* E, char* name, var_type* ret);
void env_add_fn(env* E, char* name, var_type* ret, scope* s);
void env_add_fn_arg(env* E, char* name, var_type* t, char* arg);

void env_set_fn(env* E, char* name);
void env_clear_fn(env* E);
int env_num_args(env* E);
int env_get_args_size(env* E);

void env_register_scope(env* E, scope* s);
void env_deregister_scope(env* E);

int env_get_local_size(env* E);

int env_get_string(env* E, char* s);
void env_do_over_vars(env* E, void* info, void *f);
void env_do_over_strings(env* E, void* info, void *f);
void env_do_over_fns(env* E, void* info, void* f);

void env_register_struct(env* E, char* name, var_type* decl);
t_struct_field* env_get_field(env* E, var_type* s, char* field);
var_type* env_get_type(env* E, char* name);

void env_register_typedef(env* E, char* name, var_type* type);

var_type* env_ast_type(env* E, node* n);
int type_get_size(env* E, var_type* t);

int env_get_label(env* E);

void env_register_end(env* E, int end);
int env_last_end(env* E);
void env_deregister_end(env* E);

int env_register_switch(env* E, int max, extra_case** cases);
void env_do_over_switches(env* E, void* file, void *f);

void env_add_enum_value(env* E, char* name, int val);
# 4 "parser/env.c" 2



int max(int a, int b) {
    if (a > b) return a;
    else return b;
}

var_info* new_global_var(env* E, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_GLOBAL;
    v->index = E->global_count++;
    return v;
}

var_info* new_arg_var(env* E, fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_ARG;
    v->index = f->argc;
    f->argc = f->argc + max(type_get_size(E, t), 8);
    return v;
}

var_info* new_local_var(env* E, fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_LOCAL;
    v->index = f->local_size;
    f->local_size = f->local_size + max(type_get_size(E, t), 8);
    return v;
}

var_info* new_const_var(env* E, int val) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = type_new_base(LANG_INT);
    v->type = VAR_CONST;
    v->index = val;
    return v;
}

fn_info* new_fn_info(var_type* ret, scope* s) {
    fn_info* v = malloc(sizeof(fn_info));
    v->ret = ret;
    v->args = hash_new(5);
    v->locals = s;
    v->argc = 0;
    v->local_size = 0;

    return v;
}


fn_info* new_fn_reg_info (var_type* ret) {
    fn_info* v = malloc(sizeof(fn_info));
    v->ret = ret;
    v->args = hash_new(5);
    v->locals = scope_new(0);
    v->argc = 0;
    v->local_size = -1;
    return v;
}

bool is_env(env* E) {
    return E != 0 && E->vars != 0;
}

env* env_new() {
    env* E = malloc(sizeof(env));
    E->vars = hash_new(30);
    E->strings = hash_new(30);
    E->fns = hash_new(30);
    E->structs = hash_new(30);
    E->typedefs = hash_new(30);
    E->ends = stack_new();
    E->switches = queue_new();
    E->switchn = 0;
    E->label_count = 1;
    E->global_count = 1;
    E->string_count = 1;
    E->curr_fn = 0;
    E->sc = 0;

    my_assert("parser/env.c", 88, "is_env(E)", is_env(E));
    return E;
}

int env_get_string(env* E, char* s) {
    my_assert("parser/env.c", 93, "is_env(E)", is_env(E));

    if (hash_get(E->strings, s) == 0) {
        char* new_s = strdup(s);
        hash_insert(E->strings, new_s, (void*)(long)(E->string_count)++);
    }

    return (int)hash_get(E->strings, s);
}

void env_add_global(env* E, var_type* t, char* name) {
    my_assert("parser/env.c", 104, "is_env(E)", is_env(E));

    char* new_name = strdup(name);
    var_info* v = new_global_var(E, t);
    hash_insert(E->vars, new_name, v);

    my_assert("parser/env.c", 110, "is_env(E)", is_env(E));
}

var_info* env_get_info(env* E, char* name) {
    my_assert("parser/env.c", 114, "is_env(E)", is_env(E));

    if (E->curr_fn && hash_get(E->curr_fn->args, name)) {
        return (var_info*) hash_get(E->curr_fn->args, name);
    } else if (E->sc != 0 && scope_find_local(E->sc, name)) {
        return scope_find_local(E->sc, name);
    } else if (hash_get(E->vars, name)) {
        return (var_info*) hash_get(E->vars, name);
    } else {
        printf("Variable '%s' not found\n", name);
        my_assert("parser/env.c", 124, "false", 0);
    }

}

void env_set_fn(env* E, char* name) {
    my_assert("parser/env.c", 130, "is_env(E)", is_env(E));
    fn_info* f = hash_get(E->fns, name);
    if (f == 0) {
        printf("Function %s not found\n", name);
        my_assert("parser/env.c", 134, "false", 0);
    }
    else {
        E->curr_fn = f;
    }


    my_assert("parser/env.c", 141, "f->locals != NULL", f->locals != 0);
}

void env_clear_fn(env* E) {
    my_assert("parser/env.c", 145, "is_env(E)", is_env(E));
    E->curr_fn = 0;
}

int env_num_args(env* E) {
    my_assert("parser/env.c", 150, "is_env(E)", is_env(E));
    if (E->curr_fn == 0) return 0;
    else return E->curr_fn->argc;
}

void env_reg_fn(env* E, char* name, var_type* ret) {
    my_assert("parser/env.c", 156, "is_env(E)", is_env(E));

    char* new_name = strdup(name);
    fn_info* f = new_fn_reg_info(ret);
    hash_insert(E->fns, new_name, f);
}

void env_add_fn(env* E, char* name, var_type* ret, scope* s) {
    my_assert("parser/env.c", 164, "is_env(E)", is_env(E));
    my_assert("parser/env.c", 165, "s != NULL", s != 0);

    if (hash_get(E->fns, name) == 0) {
        char* new_name = strdup(name);
        fn_info* f = new_fn_info(ret, s);
        hash_insert(E->fns, new_name, f);
    }
    else {
        fn_info* fn = hash_get(E->fns, name);
        fn->local_size = 0;
        fn->locals = s;
    }

}

void env_add_fn_arg(env* E, char* name, var_type* t, char* arg) {
    my_assert("parser/env.c", 181, "is_env(E)", is_env(E));

    char* new_arg = strdup(arg);
    fn_info* f = hash_get(E->fns, name);
    hash_insert(f->args, new_arg, new_arg_var(E, f, t));
}

void env_register_scope(env* E, scope* s) {
    my_assert("parser/env.c", 189, "is_env(E)", is_env(E));

    E->sc = s;
}

void env_deregister_scope(env* E) {
    my_assert("parser/env.c", 195, "is_env(E)", is_env(E));
    my_assert("parser/env.c", 196, "E->sc != NULL", E->sc != 0);

    E->sc = E->sc->parent;
}

var_type* env_get_return_type(env* E, char* fn) {
    my_assert("parser/env.c", 202, "is_env(E)", is_env(E));
    fn_info* f = hash_get(E->fns, fn);
    if (f == 0) return 0;
    else return f->ret;
}

int env_align(int s) {
    if (s / 16 * 16 == s) return s;
    else return (s/16 + 1) * 16;
}

int env_get_local_size(env* E) {
    my_assert("parser/env.c", 214, "is_env(E)", is_env(E));

    if (E->curr_fn != 0 && E->curr_fn->locals != 0)
        return env_align(E->curr_fn->locals->nall);
    else {
        my_assert("parser/env.c", 219, "false", 0);
    }
}

int env_get_args_size(env* E) {
    my_assert("parser/env.c", 224, "is_env(E)", is_env(E));
    if (E->curr_fn) return env_align(E->curr_fn->argc);
    else my_assert("parser/env.c", 226, "false", 0);
}

void env_register_struct(env* E, char* name, var_type* decl) {
    my_assert("parser/env.c", 230, "is_env(E)", is_env(E));

    hash_insert(E->structs, strdup(name), decl);
}

t_struct_field* env_get_field(env* E, var_type* s, char* field) {
    my_assert("parser/env.c", 236, "is_env(E)", is_env(E));
    my_assert("parser/env.c", 237, "s != NULL", s != 0);
    my_assert("parser/env.c", 238, "field != NULL", field != 0);

    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }

    if (s == 0 || s->base != LANG_STRUCT) {
        printf("Attempted to get field from non-struct (env_get_field) ");
        if (s != 0) printf("%i", s->base);
        printf("\n");
        exit(1);
    }

    t_struct_extra* e = s->extra;
    return hash_get(e->fields, field);
}

void env_register_typedef(env* E, char* name, var_type* type) {
    my_assert("parser/env.c", 256, "is_env(E)", is_env(E));

    hash_insert(E->typedefs, strdup(name), type);
}

var_type* env_get_type(env* E, char* name) {
    my_assert("parser/env.c", 262, "is_env(E)", is_env(E));

    if (hash_get(E->structs, name)) return hash_get(E->structs, name);
    else if (hash_get(E->typedefs, name)) return hash_get(E->typedefs, name);
    else return 0;
}

var_type* _env_promote(var_type* a, var_type* b) {
    if (a->base == LANG_POINTER) return a;
    else if (b->base == LANG_POINTER) return b;
    else if (a->base == LANG_INT && b->base == LANG_INT) return type_new_base(LANG_INT);
    else if (a->base == LANG_CHAR && b->base == LANG_CHAR) return type_new_base(LANG_CHAR);
    else return a;
}

var_type* _env_ast_binop_type(env* E, node* n) {
    extra_binop* e = n->extra;
    return _env_promote(env_ast_type(E, e->left), env_ast_type(E, e->right));
}

var_type* _env_ast_unop_type(env* E, node* n) {
    extra_unop* e = n->extra;
    return env_ast_type(E, e->inner);
}

var_type* env_dereference_type(env* E, var_type* type) {
    while (type != 0 && (type->base == LANG_UNDET_STRUCT || type->base == LANG_UNDET))
        type = env_get_type(E, type->extra);
    if (type->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer type %i (env_ast_type)\n", type->base);
        exit(1);
    }
    return type->extra;
}


var_type* env_ast_type(env* E, node* n) {
    my_assert("parser/env.c", 299, "n != NULL", n != 0);
    my_assert("parser/env.c", 300, "is_env(E)", is_env(E));

    var_type* type;

    node_type t = n->type;
    if (t == AST_VARIABLE) {
        var_info* v = env_get_info(E, ((extra_var*)(n->extra))->name);
        if (v == 0) type = 0;
        type = v->lang_t;
    } else if (t == AST_INTEGER) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_CHAR) {
        type = type_new_base(LANG_CHAR);
    } else if (t == AST_FN_CALL) {
        type = env_get_return_type(E, ((extra_call*)(n->extra))->fn_name);
    } else if (t == AST_CAST) {
        type = ((extra_cast*)(n->extra))->type;
    } else if (t == AST_SIZEOF) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_ARROW) {
        extra_arrow* e = (extra_arrow*)n->extra;
        var_type* st_t = env_dereference_type(E, env_ast_type(E, e->inner));
        while (st_t != 0 && (st_t->base == LANG_UNDET_STRUCT || st_t->base == LANG_UNDET))
            st_t = env_get_type(E, st_t->extra);
        if (st_t->base != LANG_STRUCT) {
            printf("Attempted to arrow non-struct, env ast type, %i\n", st_t->base);
            exit(1);
        }
        type = type_get_field(st_t, e->field)->type;
    } else if (t == AST_ARRAY_SUB) {
        type = env_dereference_type(E, env_ast_type(E, ((extra_binop*)(n->extra))->left));
    } else if (t == AST_ADDRESS) {
        type = type_new_pointer(_env_ast_unop_type(E, n));
    } else if (t == AST_DEREFERENCE) {
        type = env_dereference_type(E, _env_ast_unop_type(E, n));
    } else if (t == AST_INCREMENT || t == AST_DECREMENT) {
        type = _env_ast_unop_type(E, n);
    } else if (t == AST_ADDITION || t == AST_SUBTRACTION || t == AST_MULTIPLICATION || t == AST_DIVISION) {
        type = _env_ast_binop_type(E, n);
    } else if (t == AST_LOGICAL_NOT || t == AST_LOGICAL_AND || t == AST_LOGICAL_OR ||
               t == AST_EQ || t == AST_NEQ || t == AST_LT || t == AST_LTE || t == AST_GT ||
               t == AST_GTE) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_ASSIGN) {
        type = env_ast_type(E, ((extra_binop*)(n->extra))->left);
    }
    else {
        type = 0;
    }
    while (type != 0 && (type->base == LANG_UNDET_STRUCT || type->base == LANG_UNDET)) {
        type = env_get_type(E, type->extra);
    }
    return type;
}
# 374 "parser/env.c"
int env_get_label(env* E) {
    return (E->label_count)++;
}



void env_register_end(env* E, int end) {
    push(E->ends, (void*)(long) end);
}

int env_last_end(env* E) {
    int x = (int)pop(E->ends);
    push(E->ends, (void*)(long) x);
    return x;
}

void env_deregister_end(env* E) {
    pop(E->ends);
}


int env_register_switch(env* E, int max, extra_case** cases) {
    switch_info* s = malloc(sizeof(switch_info));
    s->switchn = (E->switchn)++;
    s->max = max;
    enq(E->switches, s);
    return s->switchn;
}
# 412 "parser/env.c"
void env_add_enum_value(env* E, char* name, int val) {
    my_assert("parser/env.c", 413, "is_env(E)", is_env(E));

    char* new_name = strdup(name);
    hash_insert(E->vars, new_name, new_const_var(E, val));
}

int type_get_size(env* E, var_type* t) {
    my_assert("parser/env.c", 420, "t != NULL", t != 0);
    (printf("%s:%d \t", "parser/env.c", 421) && (printf("type of type %d",t->base)+1) && printf("\n"));
    switch (t->base) {
        case LANG_VOID:
        case LANG_INT:
        case LANG_POINTER:
            return 8;
        case LANG_CHAR:
            return 1;
        case LANG_UNDET_STRUCT:
        case LANG_UNDET:
            return type_get_size(E, env_get_type(E, t->extra));
        case LANG_STRUCT:
            return ((t_struct_extra*)(t->extra))->size;
        default:
            printf("What is type %i?\n", t->base);
            exit(1);
    }
}
