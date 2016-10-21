#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "parser.h"
#include "../tokenizer/tokens.h"
#include "ast.h"
#include "../token_q.h"
#include "../util/stack.h"

token* safe_deq(queue* Q) {
    if (queue_empty(Q)) {
        printf("Not enough tokens in queue for this operation");
        exit(1);
        return NULL;
    }
    return deq(Q);
}

token* safe_peek(queue* Q) {
    if (queue_empty(Q)) {
        return NULL;
    }
    return peek(Q);
}

token_type safe_peek_type(queue* Q) {
    if (queue_empty(Q)) {
        return OTHER;
    } else {
        return peek(Q)->type;
    }
}

node* parse_parens(queue* Q) {
    if (!safe_peek(Q)) {
        printf("Uh oh! ran out of input");
        exit(1);
    }

    token* t = safe_deq(Q);
    node* n = NULL;

    if (t->type == NAME) {
        n = new_node_var(t->repr);
    }
    else if (t->type == NUMBER) {
        n = new_node_int(t->repr);
    }
    else {
        printf("Ay no! expected a name or number");
        exit(1);
    }
    token_delete(t);
    return n;
}

node* parse_mul(queue* Q) {
    node* left = parse_parens(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_MUL || type == OP_DIV) {
        token_delete(deq(Q));
        node* right = parse_parens(Q);
        left = new_node_binop(type == OP_MUL ? AST_MULTIPLICATION : AST_DIVISION, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}

node* parse_add(queue* Q) {
    node* left = parse_mul(Q);

    token_type type = safe_peek_type(Q);
    while (type == OP_PLUS || type == OP_MINUS) {
        token_delete(deq(Q));
        node* right = parse_mul(Q);
        left = new_node_binop(type == OP_PLUS ? AST_ADDITION : AST_SUBTRACTION, left, right);
        type = safe_peek_type(Q);
    }
    return left;
}

node* parse(queue* Q) {
    return parse_add(Q);
}