#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "../vars.h"

#include "ast.h"

bool is_node(node* n) {
    return n != NULL && n->extra != NULL;
}

node* new_node_var(char* name) {
    assert(name != NULL);

    node* n = malloc(sizeof(node));
    extra_var* e = malloc(sizeof(extra_var));
    e->name = strndup(name, MAX_TOKEN_LENGTH);
    n->extra = (void*)e;
    n->type = AST_VARIABLE;

    assert(is_node(n));
    return n;
}


node* new_node_int(char* repr) {
    assert(repr != NULL);

    char* end;
    int val = strtol(repr, &end, 10);
    assert(*end == 0);

    node* n = malloc(sizeof(node));
    extra_int* e = malloc(sizeof(extra_int));
    e->val = val;
    n->extra = (void*)e;
    n->type = AST_INTEGER;

    assert(is_node(n));
    return n;

}
node* new_node_binop(node_type type, node* left, node* right) {
    assert(is_node(left));
    assert(is_node(right));

    node* n = malloc(sizeof(node));
    extra_binop* e = malloc(sizeof(extra_binop));
    e->left = left;
    e->right = right;
    n->extra = (void*)e;
    n->type = type;

    assert(is_node(n));
    return n;
}

void _print_node(node* n, int depth);

void print_binop_node(node* n, int depth) {
    extra_binop* b = (extra_binop*)(n->extra);
    _print_node(b->left, depth+1);
    _print_node(b->right, depth+1);
}

void _print_node(node* n, int depth) {
    assert(is_node(n));
    assert(0 <= depth);

    for (int i = 0; i < depth; i++) printf("\t");
    switch (n->type) {
        case AST_VARIABLE:
            printf("AST_VARIABLE %s\n", ((extra_var*)(n->extra))->name);
            break;
        case AST_INTEGER:
            printf("AST_INTEGER %i\n", ((extra_int*)(n->extra))->val);
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
        default:
            printf("AST_UNKNOWN\n");
            break;
    }
}
void print_node(node* n) {
    _print_node(n, 0);
}