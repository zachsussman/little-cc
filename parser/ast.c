#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "../vars.h"
#include "../util/queue.h"

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

node* new_node_string(char* s) {
    assert(s != NULL);

    node* n = malloc(sizeof(node));
    extra_string* e = malloc(sizeof(extra_string));
    e->s = strdup(s);
    n->extra = (void*)e;
    n->type = AST_STRING;

    assert(is_node(n));
    return n;
}

node* new_node_call(char* fn_name) {
    assert(fn_name != NULL);

    node* n = malloc(sizeof(node));
    extra_call* e = malloc(sizeof(extra_call));
    e->fn_name = strndup(fn_name, MAX_TOKEN_LENGTH);
    e->args = queue_new();
    n->extra = (void*)e;
    n->type = AST_FN_CALL;

    assert(is_node(n));
    return n;
}

void node_call_enq(node* call, node* arg) {
    assert(is_node(call));
    assert(is_node(arg));
    assert(call->type == AST_FN_CALL);

    extra_call* e = call->extra;

    enq(e->args, (void*)arg);
}

bool node_call_empty(node* call) {
    assert(is_node(call));
    assert(call->type == AST_FN_CALL);

    extra_call* e = call->extra;

    return queue_empty(e->args);
}

node* node_call_deq(node* call) {
    assert(is_node(call));
    assert(call->type == AST_FN_CALL);
    assert(!node_call_empty(call));

    extra_call* e = call->extra;

    return (node*) deq(e->args);
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

node* new_node_unop(node_type type, node* inner) {
    assert(is_node(inner));

    node* n = malloc(sizeof(node));
    extra_unop* e = malloc(sizeof(extra_unop));
    e->inner = inner;
    n->extra = (void*) e;
    n->type = type;

    assert(is_node(n));
    return n;
}

node* new_node_declaration(node_type scope, var_type*  t, char* name) {
    assert(name != NULL);

    node* n = malloc(sizeof(node));
    extra_declaration* e = malloc(sizeof(extra_declaration));
    e->type = t;
    e->name = strndup(name, MAX_TOKEN_LENGTH);

    n->type = scope;
    n->extra = (void*) e;

    assert(is_node(n));
    return n;
}

node* new_node_statement(node* expr) {
    assert(is_node(expr));

    node* n = malloc(sizeof(node));
    extra_statement* e = malloc(sizeof(extra_statement));
    e->expr = expr;
    n->extra = (void*) e;
    n->type = AST_STATEMENT;

    assert(is_node(n));
    return n;
}

node* new_node_if(node* cond, node* body, node* else_body) {
    assert(is_node(cond));
    assert(is_node(body));

    node* n = malloc(sizeof(node));
    extra_if* e = malloc(sizeof(extra_if));
    e->cond = cond;
    e->body = body;
    e->else_body = else_body;
    n->extra = (void*) e;
    n->type = AST_IF;

    assert(is_node(n));
    return n;
}

node* new_node_while(node* cond, node* body) {
    assert(is_node(cond));
    assert(is_node(body));

    node* n = malloc(sizeof(node));
    extra_while* e = malloc(sizeof(extra_while));
    e->cond = cond;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_WHILE;

    assert(is_node(n));
    return n;
}

node* new_node_sequence() {
    node* n = malloc(sizeof(node));
    extra_sequence* e = malloc(sizeof(extra_sequence));
    e->Q = queue_new();
    n->extra = (void*) e;
    n->type = AST_SEQUENCE;

    assert(is_node(n));
    return n;
}

bool sequence_empty(node* seq) {
    assert(is_node(seq));
    assert(seq->type == AST_SEQUENCE);

    extra_sequence* e = seq->extra;

    return queue_empty(e->Q);
}

void sequence_enq(node* seq, node* n) {
    assert(is_node(seq));
    assert(is_node(n));
    assert(seq->type == AST_SEQUENCE);

    extra_sequence* e = seq->extra;

    enq(e->Q, (void*)n);
}

node* sequence_deq(node* seq) {
    assert(is_node(seq));
    assert(seq->type == AST_SEQUENCE);
    assert(!sequence_empty(seq));

    extra_sequence* e = seq->extra;

    return (node*) deq(e->Q);
}

node* sequence_peek(node* seq) {
    assert(is_node(seq));
    assert(seq->type == AST_SEQUENCE);
    assert(!sequence_empty(seq));

    extra_sequence* e = seq->extra;

    return (node*) peek(e->Q);
}

extra_fn_arg* new_node_fn_arg(var_type*  type, char* name) {
    extra_fn_arg* e = malloc(sizeof(extra_fn_arg));
    e->type = type;
    e->name = strdup(name);
    return e;
}

node* new_node_function(var_type*  ret, char* name, queue* args, node* body) {
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
    assert(is_node(n));
    assert(0 <= depth);

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
            if (exif->else_body != NULL) {
                _print_node(exif->else_body, depth+1);
            }
            break;
        case AST_WHILE:
            printf("AST_WHILE\n");
            _print_node(((extra_if*)(n->extra))->cond, depth+1);
            _print_node(((extra_if*)(n->extra))->body, depth+1);
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
            _print_node(ex->body, depth+1);
            break;
        default:
            printf("AST_UNKNOWN\n");
            break;
    }
}
void print_node(node* n) {
    _print_node(n, 0);
}