#pragma once

#include "../diff.h"

#include "../util/queue.h"
#include "types.h"


//Using the precedence table from http://en.cppreference.com/w/c/language/operator_precedence:
typedef enum node_type_e node_type;
enum node_type_e {
    // Expression tree
    // Precedence 0: atoms
    AST_NONE,
    AST_VARIABLE,
    AST_INTEGER,
    AST_CHAR,
    AST_FN_CALL,
    AST_STRING,
    AST_CAST, // technically prec 2 but I want a LL(1) parser

    AST_SIZEOF,

    // Precedence 1
    AST_ARROW,
    AST_ARRAY_SUB,
    AST_INCREMENT,
    AST_DECREMENT,

    // Precedence 2
    AST_NEGATIVE,
    AST_ADDRESS,
    AST_DEREFERENCE,
    AST_LOGICAL_NOT,

    // Precedence 3
    AST_MULTIPLICATION,
    AST_DIVISION,

    // Precedence 4
    AST_ADDITION,
    AST_SUBTRACTION,

    // Precedence 6
    AST_LT,
    AST_LTE,
    AST_GT,
    AST_GTE,

    // Precedence 7
    AST_EQ,
    AST_NEQ,


    // Precedence 11
    AST_LOGICAL_AND,

    // Precedence 12
    AST_LOGICAL_OR,

    // Precedence 14
    AST_ASSIGN,

    // Statement types
    AST_LOCAL_DECLARATION,
    AST_STATEMENT,
    AST_IF,
    AST_WHILE,
    AST_RETURN,
    AST_FOR,
    AST_BREAK,
    AST_SWITCH,

    // Block {}
    AST_SEQUENCE,

    AST_FUNCTION,
    AST_GLOBAL_DECLARATION,
    AST_STRUCT_DECLARATION,
    AST_TYPEDEF,
    AST_ENUM,

    AST_FILE
};

// I really don't want to bother with unions, so let's go with this kludge
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
    var_type*  type;
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
    var_type*  type;
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
node* new_node_declaration(node_type scope, var_type*  type, char* name, node* init);
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

extra_fn_arg* new_node_fn_arg(var_type*  type, char* name);
node* new_node_function(var_type*  ret, char* name, queue* args, node* body);
node* new_node_struct(char* name, var_type* decl);
node* new_node_typedef(var_type* type, char* name);
node* new_node_enum(char* name);
void enum_add_val(node* n, char* val);

queue* ast_locals(node* n);
void print_node(node* n);