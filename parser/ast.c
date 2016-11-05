#include "../diff.h"
#include "../vars.h"
#include "../util/queue.h"

#include "ast.h"

bool is_node(node* n) {
    return n != NULL && (n->type == AST_BREAK || n->extra != NULL);
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


node* new_node_char(char val) {
    node* n = malloc(sizeof(node));
    extra_char* e = malloc(sizeof(extra_char));
    e->val = val;
    n->extra = (void*) e;
    n->type = AST_CHAR;

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


node* new_node_sizeof(var_type* type) {
    node* n = malloc(sizeof(node));
    extra_sizeof* e = malloc(sizeof(extra_sizeof));
    e->type = type;
    n->extra = (void*) e;
    n->type = AST_SIZEOF;

    assert(is_node(n));
    return n;
}

node* new_node_cast(var_type* type, node* inner) {
    assert(is_node(inner));

    node* n = malloc(sizeof(node));
    extra_cast* e = malloc(sizeof(extra_cast));
    e->type = type;
    e->inner = inner;
    n->extra = (void*) e;
    n->type = AST_CAST;

    assert(is_node(n));
    return n;
}

node* new_node_arrow(node* inner, char* field) {
    assert(is_node(inner));

    node* n = malloc(sizeof(node));
    extra_arrow* e = malloc(sizeof(extra_arrow));
    e->inner = inner;
    e->field = strdup(field);
    n->extra = (void*) e;
    n->type = AST_ARROW;

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

node* new_node_declaration(node_type scope, var_type*  t, char* name, node* init) {
    assert(name != NULL);

    node* n = malloc(sizeof(node));
    extra_declaration* e = malloc(sizeof(extra_declaration));
    e->type = t;
    e->name = strndup(name, MAX_TOKEN_LENGTH);
    e->init = init;

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

node* new_node_for(node* init, node* cond, node* end, node* body) {
    assert(is_node(init));
    assert(is_node(cond));
    assert(is_node(end));
    assert(is_node(body));

    node* n = malloc(sizeof(node));
    extra_for* e = malloc(sizeof(extra_for));
    e->init = init;
    e->cond = cond;
    e->end = end;
    e->body = body;
    n->extra = (void*) e;
    n->type = AST_FOR;

    assert(is_node(n));
    return n;
}

node* new_node_break() {
    node* n = malloc(sizeof(node));
    n->type = AST_BREAK;
    n->extra = NULL;

    assert(is_node(n));
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
            if (exif->else_body != NULL) {
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
            if (ex->body != NULL) _print_node(ex->body, depth+1);
            break;
        default:
            printf("AST_UNKNOWN\n");
            break;
    }
}

void _ast_locals(queue* locals, node* n) {
    if (n == NULL) return;

    if (n->type == AST_SEQUENCE) {
        queue* Q = queue_readonly(((extra_sequence*)(n->extra))->Q);
        while (!queue_empty(Q)) _ast_locals(locals, deq(Q));
    } else if (n->type == AST_LOCAL_DECLARATION) {
        enq(locals, n->extra);
    } else if (n->type == AST_FUNCTION) {
        _ast_locals(locals, ((extra_function*)(n->extra))->body);
    } else if (n->type == AST_IF) {
        extra_if* e = n->extra;
        _ast_locals(locals, e->body);
        _ast_locals(locals, e->else_body);
    } else if (n->type == AST_WHILE) {
        _ast_locals(locals, ((extra_while*)(n->extra))->body);
    } else if (n->type == AST_FOR) {
        extra_for* e = n->extra;
        _ast_locals(locals, e->init);
        _ast_locals(locals, e->body);
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