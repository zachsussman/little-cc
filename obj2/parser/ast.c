# 1 "parser/ast.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/ast.c" 2
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
# 6 "parser/ast.c" 2

bool is_node(node* n) {
    return n != 0 && (n->type == AST_BREAK || n->extra != 0);
}

node* new_node_var(char* name) {
    my_assert("parser/ast.c", 12, "name != NULL", name != 0);

    node* n = malloc(sizeof(node));
    extra_var* e = malloc(sizeof(extra_var));
    e->name = strdup(name);
    n->extra = (void*)e;
    n->type = AST_VARIABLE;

    my_assert("parser/ast.c", 20, "e != NULL", e != 0);
    my_assert("parser/ast.c", 21, "e->name != NULL", e->name != 0);

    my_assert("parser/ast.c", 23, "is_node(n)", is_node(n));
    return n;
}

int my_strtol(char* repr) {
    int n = 0;
    for (int i = 0; repr[i] != '\0'; i++) {
        n = n*10 + (repr[i] - '0');
    }
    return n;
}

node* new_node_int(char* repr) {
    my_assert("parser/ast.c", 36, "repr != NULL", repr != 0);

    (printf("%s:%d \t", "parser/ast.c", 38) && (printf("Before strtol")+1) && printf("\n"));
    int val = my_strtol(repr);
    (printf("%s:%d \t", "parser/ast.c", 40) && (printf("After strtol")+1) && printf("\n"));

    node* n = malloc(sizeof(node));
    extra_int* e = malloc(sizeof(extra_int));
    e->val = val;
    n->extra = (void*)e;
    n->type = AST_INTEGER;

    my_assert("parser/ast.c", 48, "is_node(n)", is_node(n));
    return n;

}


node* new_node_char(char val) {
    node* n = malloc(sizeof(node));
    extra_char* e = malloc(sizeof(extra_char));
    e->val = val;
    n->extra = (void*) e;
    n->type = AST_CHAR;

    my_assert("parser/ast.c", 61, "is_node(n)", is_node(n));
    return n;
}

node* new_node_string(char* s) {
    my_assert("parser/ast.c", 66, "s != NULL", s != 0);

    node* n = malloc(sizeof(node));
    extra_string* e = malloc(sizeof(extra_string));
    e->s = strdup(s);
    n->extra = (void*)e;
    n->type = AST_STRING;

    my_assert("parser/ast.c", 74, "is_node(n)", is_node(n));
    return n;
}

node* new_node_call(char* fn_name) {
    my_assert("parser/ast.c", 79, "fn_name != NULL", fn_name != 0);

    node* n = malloc(sizeof(node));
    extra_call* e = malloc(sizeof(extra_call));
    e->fn_name = strndup(fn_name, 80);
    e->args = queue_new();
    n->extra = (void*)e;
    n->type = AST_FN_CALL;

    my_assert("parser/ast.c", 88, "is_node(n)", is_node(n));
    return n;
}

void node_call_enq(node* call, node* arg) {
    my_assert("parser/ast.c", 93, "is_node(call)", is_node(call));
    my_assert("parser/ast.c", 94, "is_node(arg)", is_node(arg));
    my_assert("parser/ast.c", 95, "call->type == AST_FN_CALL", call->type == AST_FN_CALL);

    extra_call* e = call->extra;

    enq(e->args, (void*)arg);
}

bool node_call_empty(node* call) {
    my_assert("parser/ast.c", 103, "is_node(call)", is_node(call));
    my_assert("parser/ast.c", 104, "call->type == AST_FN_CALL", call->type == AST_FN_CALL);

    extra_call* e = call->extra;

    return queue_empty(e->args);
}

node* node_call_deq(node* call) {
    my_assert("parser/ast.c", 112, "is_node(call)", is_node(call));
    my_assert("parser/ast.c", 113, "call->type == AST_FN_CALL", call->type == AST_FN_CALL);
    my_assert("parser/ast.c", 114, "!node_call_empty(call)", !node_call_empty(call));

    extra_call* e = call->extra;

    return (node*) deq(e->args);
}


node* new_node_sizeof(var_type* type) {
    node* n = malloc(sizeof(node));
    extra_sizeof* e = malloc(sizeof(extra_sizeof));
    e->type = type;
    n->extra = (void*) e;
    n->type = AST_SIZEOF;

    my_assert("parser/ast.c", 129, "is_node(n)", is_node(n));
    return n;
}

node* new_node_cast(var_type* type, node* inner) {
    my_assert("parser/ast.c", 134, "is_node(inner)", is_node(inner));

    node* n = malloc(sizeof(node));
    extra_cast* e = malloc(sizeof(extra_cast));
    e->type = type;
    e->inner = inner;
    n->extra = (void*) e;
    n->type = AST_CAST;

    my_assert("parser/ast.c", 143, "is_node(n)", is_node(n));
    return n;
}

node* new_node_arrow(node* inner, char* field) {
    my_assert("parser/ast.c", 148, "is_node(inner)", is_node(inner));
    my_assert("parser/ast.c", 149, "field != NULL", field != 0);

    node* n = malloc(sizeof(node));
    extra_arrow* e = malloc(sizeof(extra_arrow));
    e->inner = inner;
    e->field = strdup(field);
    n->extra = (void*) e;
    n->type = AST_ARROW;

    my_assert("parser/ast.c", 158, "is_node(n)", is_node(n));
    return n;
}


node* new_node_binop(node_type type, node* left, node* right) {
    my_assert("parser/ast.c", 164, "is_node(left)", is_node(left));
    my_assert("parser/ast.c", 165, "is_node(right)", is_node(right));

    node* n = malloc(sizeof(node));
    extra_binop* e = malloc(sizeof(extra_binop));
    e->left = left;
    e->right = right;
    n->extra = (void*)e;
    n->type = type;

    my_assert("parser/ast.c", 174, "is_node(n)", is_node(n));
    return n;
}


node* new_node_ternary(node_type type, node* left, node* middle, node* right) {
    my_assert("parser/ast.c", 180, "is_node(left)", is_node(left));
    my_assert("parser/ast.c", 181, "is_node(middle)", is_node(middle));
    my_assert("parser/ast.c", 182, "is_node(right)", is_node(right));

    node* n = malloc(sizeof(node));
    extra_ternary* e = malloc(sizeof(extra_ternary));
    e->left = left;
    e->middle = middle;
    e->right = right;
    n->extra = (void*)e;
    n->type = type;

    my_assert("parser/ast.c", 192, "is_node(n)", is_node(n));
    return n;
}

node* new_node_unop(node_type type, node* inner) {
    my_assert("parser/ast.c", 197, "is_node(inner)", is_node(inner));

    node* n = malloc(sizeof(node));
    extra_unop* e = malloc(sizeof(extra_unop));
    e->inner = inner;
    n->extra = (void*) e;
    n->type = type;

    my_assert("parser/ast.c", 205, "is_node(n)", is_node(n));
    return n;
}

node* new_node_declaration(node_type scope, var_type* t, char* name, node* init) {
    my_assert("parser/ast.c", 210, "name != NULL", name != 0);

    node* n = malloc(sizeof(node));
    extra_declaration* e = malloc(sizeof(extra_declaration));
    e->type = t;
    e->name = strndup(name, 80);
    e->init = init;

    n->type = scope;
    n->extra = (void*) e;

    my_assert("parser/ast.c", 221, "is_node(n)", is_node(n));
    return n;
}

node* new_node_statement(node* expr) {
    my_assert("parser/ast.c", 226, "is_node(expr)", is_node(expr));

    node* n = malloc(sizeof(node));
    extra_statement* e = malloc(sizeof(extra_statement));
    e->expr = expr;
    n->extra = (void*) e;
    n->type = AST_STATEMENT;

    my_assert("parser/ast.c", 234, "is_node(n)", is_node(n));
    return n;
}

node* new_node_if(node* cond, node* body, node* else_body) {
    my_assert("parser/ast.c", 239, "is_node(cond)", is_node(cond));
    my_assert("parser/ast.c", 240, "is_node(body)", is_node(body));

    node* n = malloc(sizeof(node));
    extra_if* e = malloc(sizeof(extra_if));
    e->cond = cond;
    e->body = body;
    e->else_body = else_body;
    n->extra = (void*) e;
    n->type = AST_IF;

    my_assert("parser/ast.c", 250, "is_node(n)", is_node(n));
    return n;
}

node* new_node_while(node* cond, node* body) {
    my_assert("parser/ast.c", 255, "is_node(cond)", is_node(cond));
    my_assert("parser/ast.c", 256, "is_node(body)", is_node(body));

    node* n = malloc(sizeof(node));
    extra_while* e = malloc(sizeof(extra_while));
    e->cond = cond;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_WHILE;

    my_assert("parser/ast.c", 265, "is_node(n)", is_node(n));
    return n;
}

node* new_node_for(node* init, node* cond, node* end, node* body) {
    my_assert("parser/ast.c", 270, "is_node(init)", is_node(init));
    my_assert("parser/ast.c", 271, "is_node(cond)", is_node(cond));
    my_assert("parser/ast.c", 272, "is_node(end)", is_node(end));
    my_assert("parser/ast.c", 273, "is_node(body)", is_node(body));

    node* n = malloc(sizeof(node));
    extra_for* e = malloc(sizeof(extra_for));
    e->init = init;
    e->cond = cond;
    e->end = end;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_FOR;

    my_assert("parser/ast.c", 284, "is_node(n)", is_node(n));
    return n;
}

node* new_node_break() {
    node* n = malloc(sizeof(node));
    n->type = AST_BREAK;
    n->extra = 0;

    my_assert("parser/ast.c", 293, "is_node(n)", is_node(n));
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
        deq(q);
        maxn++;
    }

    e->cond = cond;
    e->cases = calloc(maxn, sizeof(extra_case*));
    q = queue_readonly(cases);
    for (int i = 0; i < maxn && !queue_empty(q); i++) {
        extra_case* ca = deq(q);
        e->cases[i] = ca;
    }
    e->n_default = n_default;
    e->length = maxn;

    n->type = AST_SWITCH;
    n->extra = e;

    my_assert("parser/ast.c", 328, "is_node(n)", is_node(n));
    return n;
}


node* new_node_sequence() {
    node* n = malloc(sizeof(node));
    extra_sequence* e = malloc(sizeof(extra_sequence));
    e->Q = queue_new();
    n->extra = (void*) e;
    n->type = AST_SEQUENCE;

    my_assert("parser/ast.c", 340, "is_node(n)", is_node(n));
    return n;
}

bool sequence_empty(node* seq) {
    my_assert("parser/ast.c", 345, "is_node(seq)", is_node(seq));
    my_assert("parser/ast.c", 346, "seq->type == AST_SEQUENCE", seq->type == AST_SEQUENCE);

    extra_sequence* e = seq->extra;

    return queue_empty(e->Q);
}

void sequence_enq(node* seq, node* n) {
    my_assert("parser/ast.c", 354, "is_node(seq)", is_node(seq));
    my_assert("parser/ast.c", 355, "is_node(n)", is_node(n));
    my_assert("parser/ast.c", 356, "seq->type == AST_SEQUENCE", seq->type == AST_SEQUENCE);

    extra_sequence* e = seq->extra;

    enq(e->Q, (void*)n);
}

node* sequence_deq(node* seq) {
    my_assert("parser/ast.c", 364, "is_node(seq)", is_node(seq));
    my_assert("parser/ast.c", 365, "seq->type == AST_SEQUENCE", seq->type == AST_SEQUENCE);
    my_assert("parser/ast.c", 366, "!sequence_empty(seq)", !sequence_empty(seq));

    extra_sequence* e = seq->extra;

    return (node*) deq(e->Q);
}

node* sequence_peek(node* seq) {
    my_assert("parser/ast.c", 374, "is_node(seq)", is_node(seq));
    my_assert("parser/ast.c", 375, "seq->type == AST_SEQUENCE", seq->type == AST_SEQUENCE);
    my_assert("parser/ast.c", 376, "!sequence_empty(seq)", !sequence_empty(seq));

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
    my_assert("parser/ast.c", 463, "is_node(n)", is_node(n));
    my_assert("parser/ast.c", 464, "0 <= depth", 0 <= depth);

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

void _ast_construct_scope(scope* parent, node* n) {
# 630 "parser/ast.c"
    if (n == 0) return;

    if (n->type == AST_SEQUENCE) {
        scope* sc = scope_new(parent);
        extra_sequence* e = n->extra;
        queue* Q = queue_readonly(e->Q);
        while (!queue_empty(Q)) _ast_construct_scope(sc, deq(Q));
        e->sc = sc;
    } else if (n->type == AST_LOCAL_DECLARATION) {
        extra_declaration* e = n->extra;
        scope_add_local(parent, e->name, e->type);
    } else if (n->type == AST_FUNCTION) {
        extra_function* e = n->extra;
        node* body = e->body;
        _ast_construct_scope(parent, body);
        e->sc = ((extra_sequence*)(body->extra))->sc;
    } else if (n->type == AST_IF) {
        extra_if* e_if = n->extra;
        _ast_construct_scope(parent, e_if->body);
        _ast_construct_scope(parent, e_if->else_body);
    } else if (n->type == AST_WHILE) {
        _ast_construct_scope(parent, ((extra_while*)(n->extra))->body);
    } else if (n->type == AST_FOR) {
        scope* sc = scope_new(parent);
        extra_for* e = n->extra;
        _ast_construct_scope(sc, e->init);
        _ast_construct_scope(sc, e->body);
        e->sc = sc;
    } else if (n->type == AST_SWITCH) {
        scope* sc = scope_new(parent);
        extra_switch* e = n->extra;
        for (int i = 0; i < e->length; i++) {
            if (e->cases[i] != 0)
                _ast_construct_scope(sc, e->cases[i]->body);
        }
        _ast_construct_scope(sc, e->n_default);
        e->sc = sc;
    }
}

void ast_construct_scope(node* n) {
    _ast_construct_scope(0, n);
}
# 712 "parser/ast.c"
void print_node(node* n) {
    _print_node(n, 0);
}
