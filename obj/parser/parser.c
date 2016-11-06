# 1 "parser/parser.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "parser/parser.c" 2
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
# 2 "parser/parser.c" 2

# 1 "parser/parser.h" 1


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
# 6 "parser/ast.h" 2
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
# 4 "parser/parser.h" 2
# 1 "parser/../token_q.h" 1






void token_enq(queue* Q, token* d);
token* token_peek(queue* Q);
token* token_deq(queue* Q);
# 5 "parser/parser.h" 2

node* parse(queue* Q);
# 4 "parser/parser.c" 2



# 1 "parser/../util/stack.h" 1





typedef struct stack_s stack;
struct stack_s {
    list* top;
    list* bottom;
};

stack* stack_new();
bool stack_empty(stack* S);
void push(stack* S, void* d);
void* pop(stack* S);
# 8 "parser/parser.c" 2



hash* h_type_names = 0;
hash* h_struct_names = 0;
hash* h_enum_vals = 0;

token* safe_deq(queue* Q) {
    if (queue_empty(Q)) {
        printf("Not enough tokens in queue for this operation");
        exit(1);
        return 0;
    }
    return token_deq(Q);
}

char* get_name(queue* Q, char* err) {
    token* t = safe_deq(Q);
    if (t->type != NAME) {
        printf("%s", err);
        exit(1);
    }
    return t->repr;
}
token* safe_peek(queue* Q) {
    if (queue_empty(Q)) {
        return 0;
    }
    return token_peek(Q);
}

token_type safe_peek_type(queue* Q) {
    if (queue_empty(Q)) {
        return OTHER;
    } else {
        return safe_peek(Q)->type;
    }
}

void expect(queue* Q, token_type t, char* repr) {
    token* tok = safe_deq(Q);
    0;
    if (tok->type != t) {
        printf("%s expected, found %s\n", repr, tok->repr);
        exit(1);
    } else {
        token_delete(tok);
    }
}

void expect_semicolon(queue* Q) {
    expect(Q, SEMICOLON, ";");
}

node* parse_expr(queue* Q);

bool is_lvalue(node* n) {
    return n->type == AST_VARIABLE || n->type == AST_DEREFERENCE ||
           n->type == AST_ARROW || n->type == AST_ARRAY_SUB;
}

node* check_is_lvalue(node* n) {
    if (!is_lvalue(n)) {
        printf("Expected an lvalue\n");
        exit(1);
    }
    return n;
}





bool can_parse_type(queue* Q) {
    token_type t = safe_peek_type(Q);
    token* tok = safe_peek(Q);
    return t == KW_INT || t == KW_VOID || t == KW_STRUCT || t == KW_CHAR || t == KW_ENUM ||
           (t == NAME && hash_get(h_type_names, tok->repr) != 0);
}

var_type* parse_type(queue* Q) {
    token_type t = safe_peek_type(Q);
    var_type* type;
    if (t == KW_INT) type = type_new_base(LANG_INT);
    else if (t == KW_VOID) type = type_new_base(LANG_VOID);
    else if (t == KW_CHAR) type = type_new_base(LANG_CHAR);
    else if (t == KW_ENUM) {
        safe_deq(Q);
        type = type_new_base(LANG_INT);
    }
    else if (t == KW_STRUCT) {
        safe_deq(Q);
        type = type_new_undet_struct(safe_peek(Q)->repr);
    }
    else {
        type = type_new_undet(safe_peek(Q)->repr);
    }
    safe_deq(Q);

    while (safe_peek_type(Q) == OP_MUL) {
        expect(Q, OP_MUL, "*");
        type = type_new_pointer(type);
    }
    return type;
}

node* parse_unary_prefix(queue* Q);

node* parse_parens(queue* Q) {
    if (!safe_peek(Q)) {
        printf("Uh oh! ran out of input");
        exit(1);
    }

    token* t = safe_deq(Q);
    node* n = 0;

    if (t->type == NAME) {

        if (safe_peek_type(Q) == OPEN_PAREN) {
            n = new_node_call(t->repr);

            expect(Q, OPEN_PAREN, "(");
            while (safe_peek_type(Q) != CLOSED_PAREN) {
                node_call_enq(n, parse_expr(Q));
                if (safe_peek_type(Q) == OP_COMMA) expect(Q, OP_COMMA, ",");
            }
            expect(Q, CLOSED_PAREN, ")");
        } else {
            n = new_node_var(t->repr);
        }
    }
    else if (t->type == NUMBER) {
        n = new_node_int(t->repr);
    }
    else if (t->type == CHARACTER) {
        n = new_node_char(t->repr[0]);
    }
    else if (t->type == OPEN_PAREN) {

        if (can_parse_type(Q)) {
            var_type* t = parse_type(Q);
            expect(Q, CLOSED_PAREN, ")");
            node* inner = parse_unary_prefix(Q);
            n = new_node_cast(t, inner);
        }
        else {
            n = parse_expr(Q);
            expect(Q, CLOSED_PAREN, ")");
        }
    }
    else if (t->type == STRING) {
        n = new_node_string(t->repr);
    }
    else if (t->type == KW_SIZEOF) {
        expect(Q, OPEN_PAREN, "(");
        n = new_node_sizeof(parse_type(Q));
        expect(Q, CLOSED_PAREN, ")");
    }
    else {
        printf("Ay no! expected a name or number");
        exit(1);
    }
    token_delete(t);
    return n;
}


node* parse_unary_postfix(queue* Q) {
    node* inner = parse_parens(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_ARROW || type == OPEN_BRACKET || type == OP_DEC || type == OP_INC) {
        if (type == OP_ARROW) {
            expect(Q, OP_ARROW, "->");
            token* f = safe_deq(Q);
            if (f->type != NAME) {
                printf("Expected name for field, found type %i\n", f->type);
                exit(1);
            }
            inner = new_node_arrow(inner, f->repr);
        } else if (type == OPEN_BRACKET) {
            expect(Q, OPEN_BRACKET, "[");
            node* sub = parse_expr(Q);
            expect(Q, CLOSED_BRACKET, "]");
            inner = new_node_binop(AST_ARRAY_SUB, inner, sub);
        } else if (type == OP_DEC) {
            expect(Q, OP_DEC, "--");
            inner = new_node_unop(AST_DECREMENT, inner);
        } else if (type == OP_INC) {
            expect(Q, OP_INC, "++");
            inner = new_node_unop(AST_INCREMENT, inner);
        }
        type = safe_peek_type(Q);
    }
    return inner;
}


node* parse_unary_prefix(queue* Q) {
    token_type type = safe_peek_type(Q);
    if (type == OP_SINGLE_AND) {
        expect(Q, OP_SINGLE_AND, "&");
        return new_node_unop(AST_ADDRESS, check_is_lvalue(parse_unary_prefix(Q)));
    } else if (type == OP_MUL) {
        expect(Q, OP_MUL, "*");
        return new_node_unop(AST_DEREFERENCE, parse_unary_prefix(Q));
    } else if (type == OP_NOT_BANG) {
        expect(Q, OP_NOT_BANG, "!");
        return new_node_unop(AST_LOGICAL_NOT, parse_unary_prefix(Q));
    } else if (type == OP_MINUS) {
        expect(Q, OP_MINUS, "-");
        return new_node_unop(AST_NEGATIVE, parse_unary_prefix(Q));
    }
    else {
        return parse_unary_postfix(Q);
    }
}


node* parse_mul(queue* Q) {
    node* left = parse_unary_prefix(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_MUL || type == OP_DIV) {
        token_delete(safe_deq(Q));
        node* right = parse_unary_prefix(Q);
        left = new_node_binop(type == OP_MUL ? AST_MULTIPLICATION : AST_DIVISION, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_add(queue* Q) {
    node* left = parse_mul(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_PLUS || type == OP_MINUS) {
        token_delete(safe_deq(Q));
        node* right = parse_mul(Q);
        left = new_node_binop(type == OP_PLUS ? AST_ADDITION : AST_SUBTRACTION, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_comparisons(queue* Q) {
    node* left = parse_add(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_LT || type == OP_LTE || type == OP_GT || type == OP_GTE) {
        token_delete(safe_deq(Q));
        node* right = parse_add(Q);

        node_type t;
        switch(type) {
            case OP_LT: t = AST_LT; break;
            case OP_LTE: t = AST_LTE; break;
            case OP_GT: t = AST_GT; break;
            case OP_GTE: t = AST_GTE; break;
            default: break;
        }

        left = new_node_binop(t, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_eqs(queue* Q) {
    node* left = parse_comparisons(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_EQ || type == OP_NEQ) {
        token_delete(safe_deq(Q));
        node* right = parse_add(Q);

        node_type t;
        switch(type) {
            case OP_EQ: t = AST_EQ; break;
            case OP_NEQ: t = AST_NEQ; break;
            default: break;
        }

        left = new_node_binop(t, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_logical_and(queue* Q) {
    node* left = parse_eqs(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_BOOL_AND) {
        token_delete(safe_deq(Q));
        node* right = parse_eqs(Q);

        node_type t = AST_LOGICAL_AND;

        left = new_node_binop(t, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_logical_or(queue* Q) {
    node* left = parse_logical_and(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_BOOL_OR) {
        token_delete(safe_deq(Q));
        node* right = parse_eqs(Q);

        node_type t = AST_LOGICAL_OR;

        left = new_node_binop(t, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}


node* parse_assign(queue* Q) {
    node* left = parse_logical_or(Q);

    token_type type = safe_peek_type(Q);
    if (type == OP_ASSIGN) {
        expect(Q, OP_ASSIGN, "=");
        if (!is_lvalue(left)) {
            printf("Expected lvalue\n");
            exit(1);
        }
        node* right = parse_assign(Q);
        left = new_node_binop(AST_ASSIGN, left, right);
    }
    return left;
}

node* parse_statement(queue* Q);

node* parse_declaration(queue* Q) {
    var_type* type = parse_type(Q);
    token* t = safe_deq(Q);
    char* name = strdup(t->repr);
    token_delete(t);
    node* init = 0;
    if (safe_peek_type(Q) == SEMICOLON)
        expect_semicolon(Q);
    else {
        expect(Q, OP_ASSIGN, "=");
        init = parse_expr(Q);
        expect_semicolon(Q);
    }
    return new_node_declaration(AST_LOCAL_DECLARATION, type, name, init);
}

node* parse_expr(queue* Q) {
    return parse_assign(Q);
}

node* parse_sequence(queue* Q) {
    expect(Q, OPEN_BRACE, "{");
    node* seq = new_node_sequence();
    while (safe_peek_type(Q) != CLOSED_BRACE) {
        node* n = parse_statement(Q);
        sequence_enq(seq, n);
    }
    expect(Q, CLOSED_BRACE, "}");
    return seq;
}

node* parse_if(queue* Q) {
    expect(Q, KW_IF, "if");
    expect(Q, OPEN_PAREN, "(");
    node* cond = parse_expr(Q);
    expect(Q, CLOSED_PAREN, ")");
    node* body = parse_statement(Q);
    node* else_body = 0;
    if (safe_peek_type(Q) == KW_ELSE) {
        expect(Q, KW_ELSE, "else");
        else_body = parse_statement(Q);
    }
    return new_node_if(cond, body, else_body);
}

node* parse_while(queue* Q) {
    expect(Q, KW_WHILE, "while");
    expect(Q, OPEN_PAREN, "(");
    node* cond = parse_expr(Q);
    expect(Q, CLOSED_PAREN, ")");
    node* body = parse_statement(Q);
    return new_node_while(cond, body);
}

node* parse_return(queue* Q) {
    expect(Q, KW_RETURN, "return");
    node* inner;
    if (safe_peek_type(Q) == SEMICOLON) {
        inner = new_node_int("0");
    } else {
        inner = parse_expr(Q);
    }
    expect(Q, SEMICOLON, ";");
    return new_node_unop(AST_RETURN, inner);
}

node* parse_for(queue* Q) {
    expect(Q, KW_FOR, "for");
    expect(Q, OPEN_PAREN, "(");
    node* init = parse_statement(Q);
    node* cond = parse_expr(Q);
    expect(Q, SEMICOLON, ";");
    node* end = parse_expr(Q);
    expect(Q, CLOSED_PAREN, ")");
    node* body = parse_statement(Q);
    return new_node_for(init, cond, end, body);
}

node* parse_break(queue* Q) {
    expect(Q, KW_BREAK, "break");
    expect_semicolon(Q);
    return new_node_break();
}


extra_case* parse_case(queue* Q) {
    expect(Q, KW_CASE, "case");
    node* cond = parse_expr(Q);
    int val = 0;
    if (cond->type == AST_INTEGER)
        val = ((extra_int*)(cond->extra))->val;
    else if (cond->type == AST_CHAR)
        val = ((extra_char*)(cond->extra))->val;
    else if (cond->type == AST_VARIABLE) {

        if (!hash_in(h_enum_vals, ((extra_var*)(cond->extra))->name))
            err("Only integers allowed as cases");
        else val = (int) hash_get(h_enum_vals, ((extra_var*)(cond->extra))->name);
    }
    else {
        err("Only integers allowed as cases\n");
    }

    expect(Q, OP_COLON, ":");

    node* seq = new_node_sequence();
    while (safe_peek_type(Q) != KW_CASE
            && safe_peek_type(Q) != KW_DEFAULT && safe_peek_type(Q) != CLOSED_BRACE)
        sequence_enq(seq, parse_statement(Q));
    return new_node_case(val, seq);
}

node* parse_switch(queue* Q) {
    expect(Q, KW_SWITCH, "switch");
    expect(Q, OPEN_PAREN, "(");
    node* cond = parse_expr(Q);
    expect(Q, CLOSED_PAREN, ")");
    expect(Q, OPEN_BRACE, "{");

    queue* cases = queue_new();
    while (safe_peek_type(Q) == KW_CASE) enq(cases, parse_case(Q));

    node* n_default = new_node_sequence();
    if (safe_peek_type(Q) == KW_DEFAULT) {
        expect(Q, KW_DEFAULT, "default");
        expect(Q, OP_COLON, ":");
        while (safe_peek_type(Q) != CLOSED_BRACE)
            sequence_enq(n_default, parse_statement(Q));
    }
    expect(Q, CLOSED_BRACE, "}");
    return new_node_switch(cond, cases, n_default);
}

node* parse_statement(queue* Q) {
    token_type t = safe_peek_type(Q);

    if (can_parse_type(Q)) {
        return parse_declaration(Q);
    }
    else if (t == OPEN_BRACE) {
        return parse_sequence(Q);
    } else if (t == KW_IF) {
        return parse_if(Q);
    } else if (t == KW_WHILE) {
        return parse_while(Q);
    } else if (t == KW_RETURN) {
        return parse_return(Q);
    } else if (t == KW_FOR) {
        return parse_for(Q);
    } else if (t == KW_BREAK) {
        return parse_break(Q);
    } else if (t == KW_SWITCH) {
        return parse_switch(Q);
    }
    else {
        node* n = parse_expr(Q);
        expect_semicolon(Q);
        return new_node_statement(n);
    }
}

queue* parse_args(queue* Q) {
    expect(Q, OPEN_PAREN, "(");
    queue* args = queue_new();
    while (safe_peek_type(Q) != CLOSED_PAREN) {
        var_type* arg_t = parse_type(Q);
        token* arg = safe_deq(Q);
        if (arg->type != NAME) {
            printf("Expected variable name\n");
            exit(1);
        }
        char* name = arg->repr;
        enq(args, new_node_fn_arg(arg_t, name));

        if (safe_peek_type(Q) == OP_COMMA) deq(Q);
    }
    expect(Q, CLOSED_PAREN, ")");
    return args;
}

node* parse_top_declaration(queue* Q) {
    var_type* type = parse_type(Q);
    token* t = safe_deq(Q);
    char* name = strdup(t->repr);
    token_delete(t);

    if (safe_peek_type(Q) == OPEN_PAREN) {

        queue* args = parse_args(Q);
        node* body = 0;
        if (safe_peek_type(Q) != SEMICOLON) body = parse_sequence(Q);
        else expect_semicolon(Q);
        return new_node_function(type, name, args, body);
    }

    else {
        node* init = 0;
        if (safe_peek_type(Q) == SEMICOLON)
            expect_semicolon(Q);
        else {
            expect(Q, OP_ASSIGN, "=");
            init = parse_expr(Q);
            expect_semicolon(Q);
        }
        node* n = new_node_declaration(AST_GLOBAL_DECLARATION, type, name, init);
        return n;
    }
}

node* parse_struct_declaration(queue* Q) {
    expect(Q, KW_STRUCT, "struct");
    char* name = strdup(safe_deq(Q)->repr);
    expect(Q, OPEN_BRACE, "{");
    var_type* s = type_new_struct();
    while (safe_peek_type(Q) != CLOSED_BRACE) {
        var_type* type = parse_type(Q);
        token* f = safe_deq(Q);
        if (f->type != NAME) {
            printf("Expected variable name\n");
            exit(1);
        }
        char* field = f->repr;
        type_add_field(s, field, type);
        expect(Q, SEMICOLON, ";");
    }
    expect(Q, CLOSED_BRACE, "}");
    expect(Q, SEMICOLON, ";");

    hash_insert(h_struct_names, name, name);

    return new_node_struct(name, s);
}

node* parse_typedef(queue* Q) {
    expect(Q, KW_TYPEDEF, "typedef");
    var_type* t = parse_type(Q);
    char* name = strdup(safe_deq(Q)->repr);
    expect(Q, SEMICOLON, ";");

    hash_insert(h_type_names, name, name);
    return new_node_typedef(t, name);
}

node* parse_enum(queue* Q) {
    expect(Q, KW_ENUM, "enum");
    char* name = get_name(Q, "Enum name must be valid");
    expect(Q, OPEN_BRACE, "{");

    node* n = new_node_enum(name);

    int i = 0;
    while (safe_peek_type(Q) != CLOSED_BRACE) {
        char* val = get_name(Q, "Enum val must be a name");
        enum_add_val(n, val);
        if (safe_peek_type(Q) == OP_COMMA) expect(Q, OP_COMMA, ",");
        hash_insert(h_enum_vals, strdup(val), (void*)i);
        i++;
    }

    expect(Q, CLOSED_BRACE, "}");
    expect_semicolon(Q);
    return n;
}

node* parse_top(queue* Q) {
    if (safe_peek_type(Q) == KW_STRUCT) return parse_struct_declaration(Q);
    else if (safe_peek_type(Q) == KW_TYPEDEF) return parse_typedef(Q);
    else if (safe_peek_type(Q) == KW_ENUM) return parse_enum(Q);
    else return parse_top_declaration(Q);
}


node* parse(queue* Q) {
    if (h_struct_names == 0) h_struct_names = hash_new(30);
    if (h_type_names == 0) h_type_names = hash_new(30);
    if (h_enum_vals == 0) h_enum_vals = hash_new(30);
    return parse_top(Q);
}
