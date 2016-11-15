# 1 "writer/driver.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "writer/driver.c" 2
# 1 "writer/../diff.h" 1
# 20 "writer/../diff.h"
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
# 2 "writer/driver.c" 2

# 1 "writer/../parser/ast.h" 1




# 1 "writer/../parser/../util/queue.h" 1



# 1 "writer/../parser/../util/../tokenizer/tokens.h" 1


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
# 5 "writer/../parser/../util/queue.h" 2
# 1 "writer/../parser/../util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 6 "writer/../parser/../util/queue.h" 2

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
# 6 "writer/../parser/ast.h" 2
# 1 "writer/../parser/types.h" 1



# 1 "writer/../parser/../util/hash.h" 1



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
# 5 "writer/../parser/types.h" 2

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
# 7 "writer/../parser/ast.h" 2
# 1 "writer/../parser/scope.h" 1





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
# 8 "writer/../parser/ast.h" 2



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
# 4 "writer/driver.c" 2
# 1 "writer/driver.h" 1



# 1 "writer/../parser/env.h" 1


# 1 "writer/../parser/../util/stack.h" 1





typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);
# 4 "writer/../parser/env.h" 2






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
# 5 "writer/driver.h" 2

void write_header(void* f);
void ast_write(void* f, node* n, env* E);
void write_footer(void* f, env* E);
# 5 "writer/driver.c" 2


char** arg_registers;

void ast_lvalue_write(void* f, node* n, env* E);

void emit(void* f, char* s) {
    fprintf(f, "\t%s\n", s);
}

void ast_int_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 16, "n != NULL", n != 0);
    my_assert("writer/driver.c", 17, "n->type == AST_INTEGER", n->type == AST_INTEGER);

    extra_int* e = n->extra;
    fprintf(f, "\tmov rax, %i\n", e->val);
}

void ast_char_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 24, "n != NULL", n != 0);
    my_assert("writer/driver.c", 25, "n->type == AST_CHAR", n->type == AST_CHAR);

    extra_char* e = n->extra;
    fprintf(f, "\tmov rax, %i\n", e->val);
}

void ast_var_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 32, "n != NULL", n != 0);
    my_assert("writer/driver.c", 33, "n->type == AST_VARIABLE", n->type == AST_VARIABLE);

    extra_var* e = (extra_var*) n->extra;
    var_info* v = env_get_info(E, e->name);

    char* s = e->name;

    char* mov_str;
    int var_size = type_get_size(E, v->lang_t);
    0;
    if (var_size == 1) {
        mov_str = "movzx rax, byte";
    } else {
        mov_str = "mov rax, qword";
    }

    if (v->type == VAR_GLOBAL) {
        fprintf(f, "\t%s [g%i]\n", mov_str, v->index);
    } else if (v->type == VAR_ARG) {
        fprintf(f, "\t%s [rbp+%i]\n", mov_str, v->index + 8);
    } else if (v->type == VAR_LOCAL) {
        fprintf(f, "\t%s [rbp-%i]\n", mov_str, v->index + 8);
    } else if (v->type == VAR_CONST) {
        fprintf(f, "\tmov rax, %i\n", v->index);
    }
}

void ast_string_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 61, "n != NULL", n != 0);
    my_assert("writer/driver.c", 62, "n->type == AST_STRING", n->type == AST_STRING);

    extra_string* e = (extra_string*) n->extra;
    int index = env_get_string(E, e->s);
    fprintf(f, "\tmov rax, _string_%i\n", index);
}

void ast_call_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 70, "n != NULL", n != 0);
    my_assert("writer/driver.c", 71, "n->type == AST_FN_CALL", n->type == AST_FN_CALL);

    extra_call* e = (extra_call*) n->extra;

    int arg_num = 0;
    while (!node_call_empty(n)) {
        ast_write(f, node_call_deq(n), E);
        emit(f, "push rax");
        arg_num++;
    }
    for (int i = arg_num-1; i >= 0; i--) {
        fprintf(f, "\tpop %s\n", arg_registers[i]);
    }

    emit(f, "mov al, 0");
    fprintf(f, "\tcall _%s\n", e->fn_name);
}

void ast_sizeof_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 90, "n != NULL", n != 0);
    my_assert("writer/driver.c", 91, "n->type == AST_SIZEOF", n->type == AST_SIZEOF);

    extra_sizeof* e = (extra_sizeof*) n->extra;
    var_type* t = e->type;
    while (t->base == LANG_UNDET || t->base == LANG_UNDET_STRUCT)
        t = env_get_type(E, t->extra);
    int size = type_get_size(E, t);
    fprintf(f, "\tmov rax, %d\n", size);
}

void ast_arrow_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 102, "n != NULL", n != 0);
    my_assert("writer/driver.c", 103, "n->type == AST_ARROW", n->type == AST_ARROW);

    extra_arrow* e = (extra_arrow*) n->extra;
    var_type* t = env_ast_type(E, e->inner);
    if (t->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer\n");
        exit(1);
    }

    var_type* s = (var_type*) t->extra;
    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }
    if (s->base != LANG_STRUCT) {
        printf("Attempted to arrow non-struct-pointer %i\n", s->base);
        exit(1);
    }
    t_struct_field* field = type_get_field(s, e->field);
    if (field == 0) {
        printf("Field %s not found in struct %s\n", e->field, ((t_struct_extra*)(s->extra))->name);
    }
    int index = field->index;

    ast_write(f, e->inner, E);
    fprintf(f, "\tmov rax, [rax+%i]\n", index*8);
}

void ast_array_sub_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 131, "n != NULL", n != 0);
    my_assert("writer/driver.c", 132, "n->type == AST_ARRAY_SUB", n->type == AST_ARRAY_SUB);

    extra_binop* e = (extra_binop*) n->extra;
    var_type* t = env_ast_type(E, e->left);
    if (t->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer\n");
        exit(1);
    }
    var_type* s = (var_type*) t->extra;
    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }

    ast_write(f, e->right, E);
    fprintf(f, "\timul rax, %i\n", type_get_size(E, s));
    emit(f, "push rax");
    ast_write(f, e->left, E);
    emit(f, "pop rcx");
    emit(f, "add rax, rcx");
    if (type_get_size(E, s) == 1) {
        emit(f, "xor rcx, rcx");
        emit(f, "mov cl, [rax]");
        emit(f, "mov rax, rcx");
    }
    else emit(f, "mov rax, [rax]");
}

void ast_cast_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 160, "n != NULL", n != 0);
    my_assert("writer/driver.c", 161, "n->type == AST_CAST", n->type == AST_CAST);

    extra_cast* e = n->extra;
    ast_write(f, e->inner, E);
}

void ast_increment_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 168, "n != NULL", n != 0);
    my_assert("writer/driver.c", 169, "n->type == AST_INCREMENT", n->type == AST_INCREMENT);

    extra_unop* e = n->extra;

    ast_lvalue_write(f, e->inner, E);
    emit(f, "mov rcx, [rax]");
    emit(f, "add qword [rax], 1");
    emit(f, "mov rax, rcx");
}

void ast_decrement_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 180, "n != NULL", n != 0);
    my_assert("writer/driver.c", 181, "n->type == AST_DECREMENT", n->type == AST_DECREMENT);

    extra_unop* e = n->extra;

    ast_lvalue_write(f, e->inner, E);
    emit(f, "mov rcx, [rax]");
    emit(f, "sub qword [rax], 1");
    emit(f, "mov rax, rcx");
}

void ast_negative_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 192, "n != NULL", n != 0);
    my_assert("writer/driver.c", 193, "n->type == AST_NEGATIVE", n->type == AST_NEGATIVE);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);
    emit(f, "neg rax");
}


void ast_address_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 202, "n != NULL", n != 0);
    my_assert("writer/driver.c", 203, "n->type == AST_ADDRESS", n->type == AST_ADDRESS);

    extra_unop* u = (extra_unop*) n->extra;

    ast_lvalue_write(f, u->inner, E);
}

void ast_dereference_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 211, "n != NULL", n != 0);
    my_assert("writer/driver.c", 212, "n->type == AST_DEREFERENCE", n->type == AST_DEREFERENCE);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);

    int var_size = type_get_size(E, env_ast_type(E, n));
    if (var_size == 1) {
        emit(f, "xor rcx, rcx");
        emit(f, "mov cl, [rax]");
        emit(f, "mov rax, rcx");
    }
    else {
        emit(f, "mov rax, [rax]");
    }
}

void ast_logical_not_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 229, "n != NULL", n != 0);
    my_assert("writer/driver.c", 230, "n->type == AST_LOGICAL_NOT", n->type == AST_LOGICAL_NOT);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);
    emit(f, "test rax, rax");
    emit(f, "setz cl");
    emit(f, "movzx rax, cl");
}

void ast_binop_write(void* f, node* n, env* E, char* op) {
    my_assert("writer/driver.c", 240, "n != NULL", n != 0);

    extra_binop* e = (extra_binop*)n->extra;

    ast_write(f, e->right, E);
    emit(f, "push rax");
    ast_write(f, e->left, E);
    emit(f, "pop rcx");
    emit(f, op);
}

void ast_add_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 252, "n != NULL", n != 0);
    my_assert("writer/driver.c", 253, "n->type == AST_ADDITION", n->type == AST_ADDITION);

    ast_binop_write(f, n, E, "add rax, rcx");
}

void ast_sub_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 259, "n != NULL", n != 0);
    my_assert("writer/driver.c", 260, "n->type == AST_SUBTRACTION", n->type == AST_SUBTRACTION);

    ast_binop_write(f, n, E, "sub rax, rcx");
}

void ast_mul_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 266, "n != NULL", n != 0);
    my_assert("writer/driver.c", 267, "n->type == AST_MULTIPLICATION", n->type == AST_MULTIPLICATION);

    ast_binop_write(f, n, E, "mul rcx");
}

void ast_div_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 273, "n != NULL", n != 0);
    my_assert("writer/driver.c", 274, "n->type == AST_DIVISION", n->type == AST_DIVISION);

    ast_binop_write(f, n, E, "cqo\n\tdiv rcx");
}

void ast_lt_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 280, "n != NULL", n != 0);
    my_assert("writer/driver.c", 281, "n->type == AST_LT", n->type == AST_LT);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetl al\n\tmovzx rax, al");
}

void ast_lte_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 287, "n != NULL", n != 0);
    my_assert("writer/driver.c", 288, "n->type == AST_LTE", n->type == AST_LTE);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetle al\n\tmovzx rax, al");
}

void ast_gt_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 294, "n != NULL", n != 0);
    my_assert("writer/driver.c", 295, "n->type == AST_GT", n->type == AST_GT);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetg al\n\tmovzx rax, al");
}

void ast_gte_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 301, "n != NULL", n != 0);
    my_assert("writer/driver.c", 302, "n->type == AST_GTE", n->type == AST_GTE);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetge al\n\tmovzx rax, al");
}

void ast_eq_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 308, "n != NULL", n != 0);
    my_assert("writer/driver.c", 309, "n->type == AST_EQ", n->type == AST_EQ);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsete al\n\tmovzx rax, al");
}

void ast_neq_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 315, "n != NULL", n != 0);
    my_assert("writer/driver.c", 316, "n->type == AST_NEQ", n->type == AST_NEQ);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetne al\n\tmovzx rax, al");
}

void ast_lvalue_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 322, "n != NULL", n != 0);

    if (n->type == AST_VARIABLE) {
        extra_var* e = (extra_var*) n->extra;
        var_info* v = env_get_info(E, e->name);
        if (v->type == VAR_GLOBAL) {
            fprintf(f, "\tmov rax, g%i\n", v->index);
        } else if (v->type == VAR_ARG) {
            fprintf(f, "\tlea rax, [rbp+%i]\n", v->index + 8);
        } else if (v->type == VAR_LOCAL) {
            fprintf(f, "\tlea rax, [rbp-%i]\n", v->index + 8);
        }
    }
    else if (n->type == AST_DEREFERENCE) {
        ast_write(f, ((extra_unop*)(n->extra))->inner, E);
    } else if (n->type == AST_ARROW) {
        extra_arrow* e = n->extra;
        ast_write(f, e->inner, E);
        var_type* s = env_ast_type(E, e->inner);
        if (s->base != LANG_POINTER) {
            printf("Attempted to dereference non-pointer type %i", s->base);
            exit(1);
        }
        s = s->extra;
        int index = env_get_field(E, s, e->field)->index;
        fprintf(f, "\tadd rax, %i\n", index*8);
    } else if (n->type == AST_ARRAY_SUB) {
        extra_binop* e = (extra_binop*) n->extra;
        var_type* t = env_ast_type(E, e->left);
        if (t->base != LANG_POINTER) {
            printf("Attempted to dereference non-pointer\n");
            exit(1);
        }
        var_type* s = (var_type*) t->extra;
        while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
            s = env_get_type(E, s->extra);
        }

        ast_write(f, e->right, E);
        fprintf(f, "\timul rax, %i\n", type_get_size(E, s));
        emit(f, "push rax");
        ast_write(f, e->left, E);
        emit(f, "pop rcx");
        emit(f, "add rax, rcx");
    }
}

void ast_logical_and_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 370, "n != NULL", n != 0);
    my_assert("writer/driver.c", 371, "n->type == AST_LOGICAL_AND", n->type == AST_LOGICAL_AND);

    int end_label = env_get_label(E);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->left, E);
    emit(f, "test rax, rax");
    fprintf(f, "\tjz label_%i\n", end_label);
    ast_write(f, e->right, E);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_logical_or_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 384, "n != NULL", n != 0);
    my_assert("writer/driver.c", 385, "n->type == AST_LOGICAL_OR", n->type == AST_LOGICAL_OR);

    int end_label = env_get_label(E);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->left, E);
    emit(f, "test rax, rax");
    fprintf(f, "\tjnz label_%i\n", end_label);
    ast_write(f, e->right, E);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_ternary_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 398, "n != NULL", n != 0);
    my_assert("writer/driver.c", 399, "n->type == AST_TERNARY", n->type == AST_TERNARY);

    int else_label = env_get_label(E);
    int end_label = env_get_label(E);

    extra_ternary* e = (extra_ternary*) n->extra;
    ast_write(f, e->left, E);
    emit(f, "test rax, rax");
    fprintf(f, "\tjz label_%i\n", else_label);
    ast_write(f, e->middle, E);
    fprintf(f, "\tjmp label_%i\n", end_label);
    fprintf(f, "label_%i:\n", else_label);
    ast_write(f, e->right, E);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_assign_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 416, "n != NULL", n != 0);
    my_assert("writer/driver.c", 417, "n->type == AST_ASSIGN", n->type == AST_ASSIGN);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->right, E);

    if (e->left->type == AST_VARIABLE) {
        extra_var* ev = (extra_var*) (e->left->extra);
        var_info* v = env_get_info(E, ev->name);
        if (v->type == VAR_GLOBAL) {
            fprintf(f, "\tmov [g%i], ", v->index);
        } else if (v->type == VAR_ARG) {
            fprintf(f, "\tmov [rbp+%i], ", v->index + 8);
        } else if (v->type == VAR_LOCAL) {
            fprintf(f, "\tmov [rbp-%i], ", v->index + 8);
        }
        int type_size = type_get_size(E, v->lang_t);
        if (type_size == 1) fprintf(f, "al\n");
        else fprintf(f, "rax\n");
    }
    else {
        emit(f, "push rax");
        ast_lvalue_write(f, e->left, E);
        emit(f, "pop rcx");

        int type_size = type_get_size(E, env_ast_type(E, e->left));
        if (type_size == 1) emit(f, "mov [rax], cl");
        else emit(f, "mov [rax], rcx");
    }
}


void ast_statement_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 449, "n != NULL", n != 0);
    my_assert("writer/driver.c", 450, "n->type == AST_STATEMENT", n->type == AST_STATEMENT);

    extra_statement* e = (extra_statement*) n->extra;
    ast_write(f, e->expr, E);
}

void ast_if_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 457, "n != NULL", n != 0);
    my_assert("writer/driver.c", 458, "n->type == AST_IF", n->type == AST_IF);

    int end_label = env_get_label(E);

    extra_if* e = (extra_if*) n->extra;
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);

    if (e->else_body == 0) {
        fprintf(f, "label_%i:\n", end_label);
    } else {
        int real_end_label = env_get_label(E);
        fprintf(f, "\tjmp label_%i\n", real_end_label);
        fprintf(f, "label_%i:\n", end_label);
        ast_write(f, e->else_body, E);
        fprintf(f, "label_%i:\n", real_end_label);
    }
}

void ast_while_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 480, "n != NULL", n != 0);
    my_assert("writer/driver.c", 481, "n->type == AST_WHILE", n->type == AST_WHILE);

    int cond_label = env_get_label(E);
    int end_label = env_get_label(E);

    env_register_end(E, end_label);

    extra_while* e = (extra_while*) n->extra;
    fprintf(f, "label_%i:\n", cond_label);
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);
    fprintf(f, "\tjmp label_%i\n", cond_label);
    fprintf(f, "label_%i:\n", end_label);

    env_deregister_end(E);
}

void ast_for_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 501, "n != NULL", n != 0);
    my_assert("writer/driver.c", 502, "n->type == AST_FOR", n->type == AST_FOR);

    int cond_label = env_get_label(E);
    int end_label = env_get_label(E);

    env_register_end(E, end_label);

    extra_for* e = n->extra;

    env_register_scope(E, e->sc);

    ast_write(f, e->init, E);
    fprintf(f, "label_%i:\n", cond_label);
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);
    ast_write(f, e->end, E);
    fprintf(f, "\tjmp label_%i\n", cond_label);
    fprintf(f, "label_%i:\n", end_label);

    env_deregister_end(E);
    env_deregister_scope(E);
}

void ast_return_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 528, "n != NULL", n != 0);
    my_assert("writer/driver.c", 529, "n->type == AST_RETURN", n->type == AST_RETURN);

    extra_unop* e = (extra_unop*) n->extra;
    ast_write(f, e->inner, E);

    emit(f, "mov rsp, rbp");
    emit(f, "pop rbp");
    fprintf(f, "\tadd rsp, %i\n", env_get_args_size(E));

    emit(f, "ret");
}

void ast_break_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 542, "n != NULL", n != 0);
    my_assert("writer/driver.c", 543, "n->type == AST_BREAK", n->type == AST_BREAK);

    int end_label = env_last_end(E);
    fprintf(f, "\tjmp label_%i\n", end_label);
}

void ast_declaration_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 550, "n != NULL", n != 0);
    my_assert("writer/driver.c", 551, "n->type == AST_LOCAL_DECLARATION", n->type == AST_LOCAL_DECLARATION);

    extra_declaration* e = (extra_declaration*) n->extra;

    if (e->init == 0) return;
    var_info* v = env_get_info(E, e->name);
    ast_write(f, e->init, E);
    fprintf(f, "\tmov [rbp-%i], rax\n", v->index + 8);
}

void ast_sequence_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 562, "n != NULL", n != 0);
    my_assert("writer/driver.c", 563, "n->type == AST_SEQUENCE", n->type == AST_SEQUENCE);

    extra_sequence* e = n->extra;

    env_register_scope(E, e->sc);

    while (!sequence_empty(n)) {
        ast_write(f, sequence_deq(n), E);
    }

    env_deregister_scope(E);
}

void ast_switch_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 577, "n != NULL", n != 0);
    my_assert("writer/driver.c", 578, "n->type == AST_SWITCH", n->type == AST_SWITCH);

    extra_switch* e = n->extra;

    ast_write(f, e->cond, E);

    int switchn = env_register_switch(E, e->length, e->cases);
    int endl = env_get_label(E);
    env_register_end(E, endl);

    env_register_scope(E, e->sc);
# 600 "writer/driver.c"
    for (int i = 0; i < e->length; i++) {
        if (e->cases[i] != 0) {
            fprintf(f, "\tcmp rax, %i\n", e->cases[i]->val);
            fprintf(f, "\tje switch_%i_case_%i\n", switchn, i);
        }
    }
    fprintf(f, "\tjmp switch_%i_default\n", switchn);

    for (int i = 0; i < e->length; i++) {
        if (e->cases[i]) {
            fprintf(f, "switch_%i_case_%i:\n", switchn, i);
            ast_write(f, e->cases[i]->body, E);
        }
    }

    fprintf(f, "switch_%i_default:\n", switchn);
    ast_write(f, e->n_default, E);

    fprintf(f, "label_%i:\n", endl);
    env_deregister_end(E);
    env_deregister_scope(E);
}

void ast_function_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 624, "n != NULL", n != 0);
    my_assert("writer/driver.c", 625, "n->type == AST_FUNCTION", n->type == AST_FUNCTION);

    extra_function* e = (extra_function*) n->extra;
    if (e->body == 0) {
        env_reg_fn(E, e->name, e->ret);


        return;
    }

    ast_construct_scope(n);

    env_add_fn(E, e->name, e->ret, e->sc);
    for (int i = 0; i < e->argc; i++) {
        env_add_fn_arg(E, e->name, e->args[i]->type, e->args[i]->name);
    }





    env_set_fn(E, e->name);

    fprintf(f, "_%s:\n", e->name);
    if ((e->argc / 2) * 2 != e->argc)
        fprintf(f, "\tsub rsp, %i\n", 8);
    for (int i = e->argc-1; i >= 0; i--) {
        fprintf(f, "\tpush %s\n", arg_registers[i]);
    }

    emit(f, "push rbp");
    emit(f, "mov rbp, rsp");

    env_register_scope(E, e->sc);

    int local_size = env_get_local_size(E);
    fprintf(f, "\tsub rsp, %i\n", local_size);
    emit(f, "and rsp, -16");
    ast_write(f, e->body, E);

    emit(f, "mov rsp, rbp");
    emit(f, "pop rbp");
    fprintf(f, "\tadd rsp, %i\n", env_get_args_size(E));

    emit(f, "ret");

    env_clear_fn(E);
}

void ast_global_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 675, "n != NULL", n != 0);
    my_assert("writer/driver.c", 676, "n->type == AST_GLOBAL_DECLARATION", n->type == AST_GLOBAL_DECLARATION);

    extra_declaration* e = (extra_declaration*) n->extra;
    env_add_global(E, e->type, e->name);
}

void ast_struct_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 683, "n != NULL", n != 0);
    my_assert("writer/driver.c", 684, "n->type == AST_STRUCT_DECLARATION", n->type == AST_STRUCT_DECLARATION);

    extra_struct* e = (extra_struct*) n->extra;
    env_register_struct(E, e->name, e->decl);
}

void ast_typedef_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 691, "n != NULL", n != 0);
    my_assert("writer/driver.c", 692, "n->type == AST_TYPEDEF", n->type == AST_TYPEDEF);

    extra_typedef* e = (extra_typedef*) n->extra;
    env_register_typedef(E, e->name, e->type);
}

void ast_enum_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 699, "n != NULL", n != 0);
    my_assert("writer/driver.c", 700, "n->type == AST_ENUM", n->type == AST_ENUM);

    extra_enum* e = n->extra;

    env_register_typedef(E, e->name, type_new_base(LANG_INT));

    int i = 0;
    while (!queue_empty(e->vals)) {
        env_add_enum_value(E, deq(e->vals), i);
        i++;
    }
}

void ast_write(void* f, node* n, env* E) {
    my_assert("writer/driver.c", 714, "n != NULL", n != 0);

    switch(n->type) {
        case AST_INTEGER:
            ast_int_write(f, n, E);
            break;
        case AST_CHAR:
            ast_char_write(f, n, E);
            break;
        case AST_VARIABLE:
            ast_var_write(f, n, E);
            break;
        case AST_STRING:
            ast_string_write(f, n, E);
            break;
        case AST_FN_CALL:
            ast_call_write(f, n, E);
            break;
        case AST_SIZEOF:
            ast_sizeof_write(f, n, E);
            break;
        case AST_CAST:
            ast_cast_write(f, n, E);
            break;
        case AST_ARROW:
            ast_arrow_write(f, n, E);
            break;
        case AST_ARRAY_SUB:
            ast_array_sub_write(f, n, E);
            break;
        case AST_INCREMENT:
            ast_increment_write(f, n, E);
            break;
        case AST_DECREMENT:
            ast_decrement_write(f, n, E);
            break;
        case AST_NEGATIVE:
            ast_negative_write(f, n, E);
            break;
        case AST_ADDRESS:
            ast_address_write(f, n, E);
            break;
        case AST_DEREFERENCE:
            ast_dereference_write(f, n, E);
            break;
        case AST_LOGICAL_NOT:
            ast_logical_not_write(f, n, E);
            break;
        case AST_ADDITION:
            ast_add_write(f, n, E);
            break;
        case AST_SUBTRACTION:
            ast_sub_write(f, n, E);
            break;
        case AST_MULTIPLICATION:
            ast_mul_write(f, n, E);
            break;
        case AST_DIVISION:
            ast_div_write(f, n, E);
            break;
        case AST_LT:
            ast_lt_write(f, n, E);
            break;
        case AST_LTE:
            ast_lte_write(f, n, E);
            break;
        case AST_GT:
            ast_gt_write(f, n, E);
            break;
        case AST_GTE:
            ast_gte_write(f, n, E);
            break;
        case AST_EQ:
            ast_eq_write(f, n, E);
            break;
        case AST_NEQ:
            ast_neq_write(f, n, E);
            break;
        case AST_LOGICAL_AND:
            ast_logical_and_write(f, n, E);
            break;
        case AST_LOGICAL_OR:
            ast_logical_or_write(f, n, E);
            break;
        case AST_TERNARY:
            ast_ternary_write(f, n, E);
            break;
        case AST_ASSIGN:
            ast_assign_write(f, n, E);
            break;
        case AST_LOCAL_DECLARATION:
            ast_declaration_write(f, n, E);
            break;
        case AST_STATEMENT:
            ast_statement_write(f, n, E);
            break;
        case AST_IF:
            ast_if_write(f, n, E);
            break;
        case AST_WHILE:
            ast_while_write(f, n, E);
            break;
        case AST_RETURN:
            ast_return_write(f, n, E);
            break;
        case AST_FOR:
            ast_for_write(f, n, E);
            break;
        case AST_BREAK:
            ast_break_write(f, n, E);
            break;
        case AST_SWITCH:
            ast_switch_write(f, n, E);
            break;
        case AST_SEQUENCE:
            ast_sequence_write(f, n, E);
            break;
        case AST_FUNCTION:
            ast_function_write(f, n, E);
            break;
        case AST_GLOBAL_DECLARATION:
            ast_global_write(f, n, E);
            break;
        case AST_STRUCT_DECLARATION:
            ast_struct_write(f, n, E);
            break;
        case AST_TYPEDEF:
            ast_typedef_write(f, n, E);
            break;
        case AST_ENUM:
            ast_enum_write(f, n, E);
            break;
        default:
            fprintf(f, "; unknown instruction %i\n", n->type);
            break;
    }
}

void write_header(void* f) {
    arg_registers = malloc(sizeof(char*) * 6);
    arg_registers[0] = "rdi";
    arg_registers[1] = "rsi";
    arg_registers[2] = "rdx";
    arg_registers[3] = "rcx";
    arg_registers[4] = "r8";
    arg_registers[5] = "r9";

    fprintf(f, "default rel\n");
    fprintf(f, "section .text\n");
    fprintf(f, "\n");
}

void write_var(void* vf, char* name, var_info* v) {
    if (v->type == VAR_CONST) return;
    void* f = (void*) vf;
    fprintf(f, "\tg%i: %s 0\n", v->index, "dq");
}

void write_string(void* vf, char* name, int index) {
    void* f = (void*) vf;
    fprintf(f, "\t_string_%i: db ", index);
    while (*name != '\0') {
        fprintf(f, "%i, ", (int)(*name));
        name++;
    }
    fprintf(f, "0\n");
}

void write_fn_info(void* f, char* name, fn_info* fn) {
    if (fn->local_size == -1) fprintf(f, "extern _%s\n", name);
    else fprintf(f, "global _%s\n", name);
}
void write_switch(void* f, switch_info* s, int switchn) {
    fprintf(f, "switch_table_%i:\n", switchn);
    for (int i = 0; i < s->max; i++) {
        fprintf(f, "\tdq switch_%i_case_%i\n", switchn, i);
    }
}



void write_env_vars(env* E, void* f) {
    hash* H = E->vars;
    my_assert("writer/driver.c", 897, "H != NULL", H != 0);

    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != 0) {
            write_var(f, c->key, c->value);
            c = c->next;
        }
    }
}

void write_env_strings(env* E, void* f) {
    hash* H = E->strings;
    my_assert("writer/driver.c", 910, "H != NULL", H != 0);

    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != 0) {
            write_string(f, c->key, (int)c->value);
            c = c->next;
        }
    }
}

void write_env_fns(env* E, void* f) {
    hash* H = E->fns;
    my_assert("writer/driver.c", 923, "H != NULL", H != 0);

    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != 0) {
            write_fn_info(f, c->key, c->value);
            c = c->next;
        }
    }

}


void write_footer(void* f, env* E) {
    emit(f, "");
    fprintf(f, "section .data\n");
    emit(f, "dummy: dw 16");
    write_env_vars(E, f);
    write_env_strings(E, f);
    write_env_fns(E, f);

}
