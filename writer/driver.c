#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

#include "../parser/ast.h"
#include "driver.h"

void emit(FILE* f, char* s) {
    fprintf(f, "\t%s\n", s);
}

void ast_int_write(FILE* f, node* n) {
    assert(n != NULL);
    assert(n->type == AST_INTEGER);

    extra_int* e = (extra_int*)n->extra;
    fprintf(f, "\tmov eax, %i\n", e->val);
}


void ast_binop_write(FILE* f, node* n, char* op) {
    assert(n != NULL);

    extra_binop* e = (extra_binop*)n->extra;

    ast_write(f, e->left);
    ast_write(f, e->right);
    emit(f, "pop rbx");
    emit(f, "pop rax");
    emit(f, op);
    emit(f, "push rax");
}

void ast_add_write(FILE* f, node* n) {
    assert(n != NULL);
    assert(n->type == AST_ADDITION);

    ast_binop_write(f, n, "add rax, rbx");
}

void ast_sub_write(FILE* f, node* n) {
    assert(n != NULL);
    assert(n->type == AST_SUBTRACTION);

    ast_binop_write(f, n, "sub rax, rbx");
}

void ast_mul_write(FILE* f, node* n) {
    assert(n != NULL);
    assert(n->type == AST_MULTIPLICATION);

    ast_binop_write(f, n, "mul rbx");
}

void ast_div_write(FILE* f, node* n) {
    assert(n != NULL);
    assert(n->type == AST_DIVISION);

    ast_binop_write(f, n, "cqo\n\tdiv ebx");
}




void ast_write(FILE* f, node* n) {
    assert(n != NULL);
    switch(n->type) {
        case AST_INTEGER:
            ast_int_write(f, n);
            break;
        case AST_ADDITION:
            ast_add_write(f, n);
            break;
        case AST_SUBTRACTION:
            ast_sub_write(f, n);
            break;
        case AST_MULTIPLICATION:
            ast_mul_write(f, n);
            break;
        case AST_DIVISION:
            ast_div_write(f, n);
            break;
        default:
            emit(f, "; unknown instruction");
            break;
    }
}