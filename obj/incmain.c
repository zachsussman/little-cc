# 1 "incmain.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "incmain.c" 2
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
# 2 "incmain.c" 2

# 1 "./util/queue.h" 1



# 1 "./util/../tokenizer/tokens.h" 1


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
# 5 "./util/queue.h" 2
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
# 4 "incmain.c" 2
# 1 "./tokenizer/tokenize.h" 1


# 1 "./util/../tokenizer/../token_q.h" 1






void token_enq(queue* Q, token* d);
token* token_peek(queue* Q);
token* token_deq(queue* Q);
# 4 "./tokenizer/tokenize.h" 2



int parse_line(queue* Q, void* f);
# 5 "incmain.c" 2
# 1 "./parser/parser.h" 1


# 1 "./parser/ast.h" 1





# 1 "./parser/types.h" 1



# 1 "./parser/../util/hash.h" 1



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
# 5 "./parser/types.h" 2

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
# 7 "./parser/ast.h" 2



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

queue* ast_locals(node* n);
void print_node(node* n);
# 4 "./parser/parser.h" 2


node* parse(queue* Q);
# 6 "incmain.c" 2

# 1 "./parser/env.h" 1


# 1 "./parser/../util/stack.h" 1





typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);
# 4 "./parser/env.h" 2




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

typedef struct fn_info_s fn_info;
struct fn_info_s {
    int argc;
    var_type* ret;
    hash* args;
    hash* locals;
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

void env_add_fn(env* E, char* name, var_type* ret);
void env_add_fn_arg(env* E, char* name, var_type* t, char* arg);

void env_set_fn(env* E, char* name);
void env_clear_fn(env* E);
int env_num_args(env* E);
int env_get_args_size(env* E);

void env_add_fn_locals(env* E, char* name, queue* locals);
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
# 8 "incmain.c" 2
# 1 "./writer/driver.h" 1





void write_header(void* f);
void ast_write(void* f, node* n, env* E);
void write_footer(void* f, env* E);
# 9 "incmain.c" 2



int main(int argc, char** argv);

int main(int argc, char** argv) {

    queue* token_queue = queue_new();

    int ok = 0;






    printf("Allocated e'rything\n");

    char* filename;
    if (argc > 1) filename = argv[1];
    else filename = "main.c";
    void* f = fopen(filename, "r");



    while (ok == 0) {
        ok = parse_line(token_queue, f);
    }

    while (!queue_empty(token_queue)) {
        node* n = parse(token_queue);
        print_node(n);
    }


    return 0;
}
