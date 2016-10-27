#pragma once

#include <stdbool.h>

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
    AST_FN_CALL,
    AST_STRING,

    // Precedence 2
    AST_ADDRESS,
    AST_DEREFERENCE,

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

    // Precedence 14
    AST_ASSIGN,

    // Statement types
    AST_DECLARATION,
    AST_STATEMENT,
    AST_IF,
    AST_WHILE,

    // Block {}
    AST_SEQUENCE,

    AST_FUNCTION
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

typedef struct extra_call_s extra_call;
struct extra_call_s {
    char* fn_name;
    queue* args;
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
    lang_type type;
    char* name;
};

typedef struct extra_if_s extra_if;
struct extra_if_s {
    node* cond;
    node* body;
};

typedef struct extra_while_s extra_while;
struct extra_while_s {
    node* cond;
    node* body;
};

typedef struct extra_fn_arg_s extra_fn_arg;
struct extra_fn_arg_s {
    lang_type type;
    char* name;
}

typedef struct extra_function_s extra_function;
struct extra_function_s {
    lang_type ret;
    char* name;
    extra_fn_arg* args;
    node* body;
}

node* new_node_var(char* name);
node* new_node_int(char* repr);
node* new_node_string(char* s);
node* new_node_call(char* repr);
void node_call_enq(node* call, node* arg);
bool node_call_empty(node* call);
node* node_call_deq(node* call);
node* new_node_binop(node_type n, node* left, node* right);
node* new_node_unop(node_type n, node* inner);
node* new_node_statement(node* expr);
node* new_node_declaration(lang_type type, char* name);
node* new_node_if(node* cond, node* body);
node* new_node_while(node* cond, node* body);

node* new_node_sequence();
void sequence_enq(node* seq, node* next);
node* sequence_deq(node* seq);
bool sequence_empty(node* seq);

extra_fn_arg* new_node_fn_arg(lang_type type, char* name);
node* new_node_function(lang_type ret, char* name, int argc, queue* args);

void print_node(node* n);