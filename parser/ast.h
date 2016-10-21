#pragma once

typedef enum node_type_e node_type;
enum node_type_e {
    AST_NONE,
    AST_VARIABLE,
    AST_INTEGER,

    AST_ADDITION,
    AST_SUBTRACTION,
    AST_MULTIPLICATION,
    AST_DIVISION,
    AST_MODULUS
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

typedef struct extra_int_s extra_int;
struct extra_int_s {
    int val;
};

typedef struct extra_binop_s extra_binop;
struct extra_binop_s {
    node* left;
    node* right;
};

node* new_node_var(char* name);
node* new_node_int(char* repr);
node* new_node_binop(node_type n, node* left, node* right);


void print_node(node* n);