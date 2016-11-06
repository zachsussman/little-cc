# 1 "parser/ast.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/ast.c" 2
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
# 2 "parser/ast.c" 2
# 1 "parser/../vars.h" 1
# 3 "parser/ast.c" 2
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
# 4 "parser/ast.c" 2

# 1 "parser/ast.h" 1





# 1 "parser/types.h" 1



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
# 6 "parser/ast.c" 2

bool is_node(node* n) {
    return n != 0 && (n->type == AST_BREAK || n->extra != 0);
}

node* new_node_var(char* name) {
    0;

    node* n = malloc(sizeof(node));
    extra_var* e = malloc(sizeof(extra_var));
    e->name = strndup(name, 80);
    n->extra = (void*)e;
    n->type = AST_VARIABLE;

    0;
    return n;
}


node* new_node_int(char* repr) {
    0;

    char* end;
    int val = strtol(repr, &end, 10);
    0;

    node* n = malloc(sizeof(node));
    extra_int* e = malloc(sizeof(extra_int));
    e->val = val;
    n->extra = (void*)e;
    n->type = AST_INTEGER;

    0;
    return n;

}


node* new_node_char(char val) {
    node* n = malloc(sizeof(node));
    extra_char* e = malloc(sizeof(extra_char));
    e->val = val;
    n->extra = (void*) e;
    n->type = AST_CHAR;

    0;
    return n;
}

node* new_node_string(char* s) {
    0;

    node* n = malloc(sizeof(node));
    extra_string* e = malloc(sizeof(extra_string));
    e->s = strdup(s);
    n->extra = (void*)e;
    n->type = AST_STRING;

    0;
    return n;
}

node* new_node_call(char* fn_name) {
    0;

    node* n = malloc(sizeof(node));
    extra_call* e = malloc(sizeof(extra_call));
    e->fn_name = strndup(fn_name, 80);
    e->args = queue_new();
    n->extra = (void*)e;
    n->type = AST_FN_CALL;

    0;
    return n;
}

void node_call_enq(node* call, node* arg) {
    0;
    0;
    0;

    extra_call* e = call->extra;

    enq(e->args, (void*)arg);
}

bool node_call_empty(node* call) {
    0;
    0;

    extra_call* e = call->extra;

    return queue_empty(e->args);
}

node* node_call_deq(node* call) {
    0;
    0;
    0;

    extra_call* e = call->extra;

    return (node*) deq(e->args);
}


node* new_node_sizeof(var_type* type) {
    node* n = malloc(sizeof(node));
    extra_sizeof* e = malloc(sizeof(extra_sizeof));
    e->type = type;
    n->extra = (void*) e;
    n->type = AST_SIZEOF;

    0;
    return n;
}

node* new_node_cast(var_type* type, node* inner) {
    0;

    node* n = malloc(sizeof(node));
    extra_cast* e = malloc(sizeof(extra_cast));
    e->type = type;
    e->inner = inner;
    n->extra = (void*) e;
    n->type = AST_CAST;

    0;
    return n;
}

node* new_node_arrow(node* inner, char* field) {
    0;
    0;

    node* n = malloc(sizeof(node));
    extra_arrow* e = malloc(sizeof(extra_arrow));
    e->inner = inner;
    e->field = strdup(field);
    n->extra = (void*) e;
    n->type = AST_ARROW;

    0;
    return n;
}


node* new_node_binop(node_type type, node* left, node* right) {
    0;
    0;

    node* n = malloc(sizeof(node));
    extra_binop* e = malloc(sizeof(extra_binop));
    e->left = left;
    e->right = right;
    n->extra = (void*)e;
    n->type = type;

    0;
    return n;
}

node* new_node_unop(node_type type, node* inner) {
    0;

    node* n = malloc(sizeof(node));
    extra_unop* e = malloc(sizeof(extra_unop));
    e->inner = inner;
    n->extra = (void*) e;
    n->type = type;

    0;
    return n;
}

node* new_node_declaration(node_type scope, var_type* t, char* name, node* init) {
    0;

    node* n = malloc(sizeof(node));
    extra_declaration* e = malloc(sizeof(extra_declaration));
    e->type = t;
    e->name = strndup(name, 80);
    e->init = init;

    n->type = scope;
    n->extra = (void*) e;

    0;
    return n;
}

node* new_node_statement(node* expr) {
    0;

    node* n = malloc(sizeof(node));
    extra_statement* e = malloc(sizeof(extra_statement));
    e->expr = expr;
    n->extra = (void*) e;
    n->type = AST_STATEMENT;

    0;
    return n;
}

node* new_node_if(node* cond, node* body, node* else_body) {
    0;
    0;

    node* n = malloc(sizeof(node));
    extra_if* e = malloc(sizeof(extra_if));
    e->cond = cond;
    e->body = body;
    e->else_body = else_body;
    n->extra = (void*) e;
    n->type = AST_IF;

    0;
    return n;
}

node* new_node_while(node* cond, node* body) {
    0;
    0;

    node* n = malloc(sizeof(node));
    extra_while* e = malloc(sizeof(extra_while));
    e->cond = cond;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_WHILE;

    0;
    return n;
}

node* new_node_for(node* init, node* cond, node* end, node* body) {
    0;
    0;
    0;
    0;

    node* n = malloc(sizeof(node));
    extra_for* e = malloc(sizeof(extra_for));
    e->init = init;
    e->cond = cond;
    e->end = end;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_FOR;

    0;
    return n;
}

node* new_node_break() {
    node* n = malloc(sizeof(node));
    n->type = AST_BREAK;
    n->extra = 0;

    0;
    return n;
}

extra_case* new_node_case(int val, node* body) {
    extra_case* e = malloc(sizeof(extra_case));
    e->val = val;
    e->body = body;
    return e;
}

node* new_node_switch(node* cond, queue* cases, node* n_default) {
    node* n = malloc(sizeof(node));
    extra_switch* e = malloc(sizeof(extra_switch));

    int maxn = 0;
    queue* q = queue_readonly(cases);
    while(!queue_empty(q)) {
        extra_case* c = deq(q);
        if (c->val > maxn) maxn = c->val;
    }

    e->cond = cond;
    e->cases = calloc((maxn+1), sizeof(extra_case*));
    q = queue_readonly(cases);
    while (!queue_empty(q)) {
        extra_case* ca = deq(q);
        e->cases[ca->val] = ca;
    }
    e->n_default = n_default;
    e->length = maxn+1;

    n->type = AST_SWITCH;
    n->extra = e;

    0;
    return n;
}


node* new_node_sequence() {
    node* n = malloc(sizeof(node));
    extra_sequence* e = malloc(sizeof(extra_sequence));
    e->Q = queue_new();
    n->extra = (void*) e;
    n->type = AST_SEQUENCE;

    0;
    return n;
}

bool sequence_empty(node* seq) {
    0;
    0;

    extra_sequence* e = seq->extra;

    return queue_empty(e->Q);
}

void sequence_enq(node* seq, node* n) {
    0;
    0;
    0;

    extra_sequence* e = seq->extra;

    enq(e->Q, (void*)n);
}

node* sequence_deq(node* seq) {
    0;
    0;
    0;

    extra_sequence* e = seq->extra;

    return (node*) deq(e->Q);
}

node* sequence_peek(node* seq) {
    0;
    0;
    0;

    extra_sequence* e = seq->extra;

    return (node*) peek(e->Q);
}

extra_fn_arg* new_node_fn_arg(var_type* type, char* name) {
    extra_fn_arg* e = malloc(sizeof(extra_fn_arg));
    e->type = type;
    e->name = strdup(name);
    return e;
}

node* new_node_function(var_type* ret, char* name, queue* args, node* body) {
    node* n = malloc(sizeof(node));
    extra_function* e = malloc(sizeof(extra_function));
    e->ret = ret;
    e->name = strdup(name);

    e->argc = queue_length(args);
    e->args = malloc(sizeof(extra_fn_arg*) * e->argc);
    for (int i = 0; i < e->argc; i++) {
        e->args[i] = (extra_fn_arg*) deq(args);
    }

    e->body = body;
    n->extra = (void*) e;
    n->type = AST_FUNCTION;
    return n;
}

node* new_node_struct(char* name, var_type* decl) {
    node* n = malloc(sizeof(node));
    extra_struct* e = malloc(sizeof(extra_struct));

    e->name = name;
    e->decl = decl;
    n->extra = (void*) e;
    n->type = AST_STRUCT_DECLARATION;
    return n;
}

node* new_node_typedef(var_type* type, char* name) {
    node* n = malloc(sizeof(node));
    extra_typedef* e = malloc(sizeof(extra_typedef));

    e->name = name;
    e->type = type;
    n->extra = (void*) e;
    n->type = AST_TYPEDEF;
    return n;
}

node* new_node_enum(char* name) {
    node* n = malloc(sizeof(node));
    extra_enum* e = malloc(sizeof(extra_enum));

    e->name = name;
    e->vals = queue_new();
    n->extra = e;
    n->type = AST_ENUM;
    return n;
}

void enum_add_val(node* n, char* val) {
    enq(((extra_enum*)(n->extra))->vals, val);
}

void _print_node(node* n, int depth);

void print_binop_node(node* n, int depth) {
    extra_binop* b = (extra_binop*)(n->extra);
    _print_node(b->left, depth+1);
    _print_node(b->right, depth+1);
}

void print_unop_node(node* n, int depth) {
    extra_unop* e = (extra_unop*)(n->extra);
    _print_node(e->inner, depth+1);
}

void _print_n_tabs(int depth) {
    for (int i = 0; i < depth; i++) printf("\t");
}

void _print_node(node* n, int depth) {
    0;
    0;

    _print_n_tabs(depth);
    switch (n->type) {
        case AST_VARIABLE:
            printf("AST_VARIABLE %s\n", ((extra_var*)(n->extra))->name);
            break;
        case AST_INTEGER:
            printf("AST_INTEGER %i\n", ((extra_int*)(n->extra))->val);
            break;
        case AST_STRING:
            printf("AST_STRING \"%s\"\n", ((extra_string*)(n->extra))->s);
            break;
        case AST_FN_CALL:
            printf("AST_FN_CALL %s\n", ((extra_call*)(n->extra))->fn_name);
            queue* args = queue_readonly(((extra_call*)(n->extra))->args);
            while (!queue_empty(args)) _print_node((node*) deq(args), depth+1);
            break;
        case AST_SIZEOF:
            printf("AST_SIZEOF ");
            type_print(((extra_sizeof*)(n->extra))->type);
            printf("\n");
            break;
        case AST_CAST:
            printf("AST_CAST ");
            type_print(((extra_cast*)(n->extra))->type);
            printf("\n");
            _print_node(((extra_cast*)(n->extra))->inner, depth+1);
            break;
        case AST_ARROW:
            printf("AST_ARROW %s\n", ((extra_arrow*)(n->extra))->field);
            _print_node(((extra_arrow*)(n->extra))->inner, depth+1);
            break;
        case AST_ARRAY_SUB:
            printf("AST_ARRAY_SUB\n");
            print_binop_node(n, depth);
            break;
        case AST_INCREMENT:
            printf("AST_INCREMENT\n");
            print_unop_node(n, depth);
            break;
        case AST_DECREMENT:
            printf("AST_DECREMENT\n");
            print_unop_node(n, depth);
            break;
        case AST_ADDRESS:
            printf("AST_ADDRESS\n");
            print_unop_node(n, depth);
            break;
        case AST_DEREFERENCE:
            printf("AST_DEREFERENCE\n");
            print_unop_node(n, depth);
            break;
        case AST_ADDITION:
            printf("AST_ADDITION\n");
            print_binop_node(n, depth);
            break;
        case AST_SUBTRACTION:
            printf("AST_SUBTRACTION\n");
            print_binop_node(n, depth);
            break;
        case AST_MULTIPLICATION:
            printf("AST_MULTIPLICATION\n");
            print_binop_node(n, depth);
            break;
        case AST_DIVISION:
            printf("AST_DIVISION\n");
            print_binop_node(n, depth);
            break;
        case AST_LT:
            printf("AST_LT\n");
            print_binop_node(n, depth);
            break;
        case AST_LTE:
            printf("AST_LTE\n");
            print_binop_node(n, depth);
            break;
        case AST_GT:
            printf("AST_GT\n");
            print_binop_node(n, depth);
            break;
        case AST_GTE:
            printf("AST_GTE\n");
            print_binop_node(n, depth);
            break;
        case AST_EQ:
            printf("AST_EQ\n");
            print_binop_node(n, depth);
            break;
        case AST_NEQ:
            printf("AST_NEQ\n");
            print_binop_node(n, depth);
            break;
        case AST_ASSIGN:
            printf("AST_ASSIGN\n");
            print_binop_node(n, depth);
            break;
        case AST_LOCAL_DECLARATION:
            printf("AST_LOCAL_DECLARATION: ");
            type_print(((extra_declaration*)(n->extra))->type);
            printf(" %s\n", ((extra_declaration*)(n->extra))->name);
            if (((extra_declaration*)(n->extra))->init)
                _print_node(((extra_declaration*)(n->extra))->init, depth+1);
            break;
        case AST_STATEMENT:
            printf("AST_STATEMENT\n");
            _print_node(((extra_statement*)(n->extra))->expr, depth+1);
            break;
        case AST_IF:
            printf("AST_IF\n");
            extra_if* exif = (extra_if*) n->extra;
            _print_node(exif->cond, depth+1);
            _print_node(exif->body, depth+1);
            if (exif->else_body != 0) {
                _print_node(exif->else_body, depth+1);
            }
            break;
        case AST_WHILE:
            printf("AST_WHILE\n");
            _print_node(((extra_while*)(n->extra))->cond, depth+1);
            _print_node(((extra_while*)(n->extra))->body, depth+1);
            break;
        case AST_FOR:
            printf("AST_FOR\n");
            _print_node(((extra_for*)(n->extra))->init, depth+1);
            _print_node(((extra_for*)(n->extra))->cond, depth+1);
            _print_node(((extra_for*)(n->extra))->end, depth+1);
            _print_node(((extra_for*)(n->extra))->body, depth+1);
            break;
        case AST_RETURN:
            printf("AST_RETURN\n");
            print_unop_node(n, depth);
            break;
        case AST_SEQUENCE:
            printf("AST_SEQUENCE\n");
            queue* seq = queue_readonly(((extra_sequence*)(n->extra))->Q);
            while (!queue_empty(seq)) _print_node((node*) deq(seq), depth+1);
            break;
        case AST_FUNCTION:
            printf("AST_FUNCTION: ");
            extra_function* ex = (extra_function*) n->extra;
            type_print(ex->ret);
            printf(" %s\n", ex->name);
            for (int i = 0; i < ex->argc; i++) {
                _print_n_tabs(depth+1);
                printf("ARG %i: ", i);
                type_print(ex->args[i]->type);
                printf(" %s\n", ex->args[i]->name);
            }
            if (ex->body != 0) _print_node(ex->body, depth+1);
            break;
        default:
            printf("AST_UNKNOWN\n");
            break;
    }
}

void _ast_locals(queue* locals, node* n) {
    if (n == 0) return;

    if (n->type == AST_SEQUENCE) {
        queue* Q = queue_readonly(((extra_sequence*)(n->extra))->Q);
        while (!queue_empty(Q)) _ast_locals(locals, deq(Q));
    } else if (n->type == AST_LOCAL_DECLARATION) {
        enq(locals, n->extra);
    } else if (n->type == AST_FUNCTION) {
        struct extra_function_s* e_fn = n->extra;
        node* body = e_fn->body;
        _ast_locals(locals, body);
    } else if (n->type == AST_IF) {
        extra_if* e_if = n->extra;
        _ast_locals(locals, e_if->body);
        _ast_locals(locals, e_if->else_body);
    } else if (n->type == AST_WHILE) {
        _ast_locals(locals, ((extra_while*)(n->extra))->body);
    } else if (n->type == AST_FOR) {
        extra_for* e_for = n->extra;
        _ast_locals(locals, e_for->init);
        _ast_locals(locals, e_for->body);
    } else if (n->type == AST_SWITCH) {
        extra_switch* e_switch = n->extra;
        for (int i = 0; i < e_switch->length; i++) {
            if (e_switch->cases[i] != 0)
                _ast_locals(locals, (e_switch->cases[i])->body);
        }
        _ast_locals(locals, e_switch->n_default);
    }
}

queue* ast_locals(node* n) {
    queue* locals = queue_new();
    _ast_locals(locals, n);
    return locals;
}

void print_node(node* n) {
    _print_node(n, 0);
}
