#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

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
    return token_deq(Q);
}

token* safe_peek(queue* Q) {
    if (queue_empty(Q)) {
        return NULL;
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
    assert(tok != NULL);
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
    return n->type == AST_VARIABLE || n->type == AST_DEREFERENCE;
}

node* check_is_lvalue(node* n) {
    if (!is_lvalue(n)) {
        printf("Expected an lvalue\n");
        exit(1);
    }
    return n;
}

/* Types in C are complicated, I'll use the following grammar: 
 * type := "int" | "void" | type "*"
 */

var_type* parse_type(queue* Q) {
    token_type t = safe_peek_type(Q);
    var_type* type;
    if (t == KW_INT) type = type_new_base(LANG_INT);
    else if (t == KW_VOID) type = type_new_base(LANG_VOID);
    safe_deq(Q);

    while (safe_peek_type(Q) == OP_MUL) {
        expect(Q, OP_MUL, "*");
        type = type_new_pointer(type);
    }
    return type;
}

node* parse_parens(queue* Q) {
    if (!safe_peek(Q)) {
        printf("Uh oh! ran out of input");
        exit(1);
    }

    token* t = safe_deq(Q);
    node* n = NULL;

    if (t->type == NAME) {
        
        if (safe_peek_type(Q) == OPEN_PAREN) {
            // Oh shit, function call!
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
    else if (t->type == OPEN_PAREN) {
        n = parse_expr(Q);
        expect(Q, CLOSED_PAREN, ")");
    } else if (t->type == STRING) {
        n = new_node_string(t->repr);
    }
    else {
        printf("Ay no! expected a name or number");
        exit(1);
    }
    token_delete(t);
    return n;
}

// Level 1
node* parse_unary_postfix(queue* Q) {
    return parse_parens(Q);
}

// Level 2
node* parse_unary_prefix(queue* Q) {
    token_type type = safe_peek_type(Q);
    if (type == OP_SINGLE_AND) {
        expect(Q, OP_SINGLE_AND, "&");
        return new_node_unop(AST_ADDRESS, check_is_lvalue(parse_unary_prefix(Q)));
    } else if (type == OP_MUL) {
        expect(Q, OP_MUL, "*");
        return new_node_unop(AST_DEREFERENCE, parse_unary_prefix(Q));
    }
    else {
        return parse_unary_postfix(Q);
    }
}

// Level 3
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

// Level 4
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

// Level 6
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

// Level 7
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


// Level 14
node* parse_assign(queue* Q) {
    node* left = parse_eqs(Q);

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
    var_type*  type = parse_type(Q);
    token* t = safe_deq(Q);
    char* name = strdup(t->repr);
    token_delete(t);
    node* n = new_node_declaration(AST_LOCAL_DECLARATION, type, name);
    expect_semicolon(Q);
    return n;
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
    node* else_body = NULL;
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

node* parse_statement(queue* Q) {
    token_type t = safe_peek_type(Q);

    if (t == KW_INT) {
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
        // Function time! Oh baby
        queue* args = parse_args(Q);
        node* body = parse_sequence(Q);
        return new_node_function(type, name, args, body);
    }

    else {
        node* n = new_node_declaration(AST_GLOBAL_DECLARATION, type, name);
        expect_semicolon(Q);
        return n;
    }
}

// node* parse_struct_declaration(queue* Q) {
//     expect(Q, KW_STRUCT, "struct");
//     char* name = strdup(safe_deq(Q)->repr);
//     expect(Q, OPEN_BRACE, "{");
//     queue* fields = queue_new();
//     while (safe_peek_type(Q) != CLOSED_BRACE) {
//         var_type* type = parse_type(Q);
//         token* f = safe_deq(Q);
//         if (n->type != NAME) {
//             printf("Expected variable name\n");
//             exit(1);
//         }
//         char* field = arg->repr;
//     }
// }

node* parse(queue* Q) {
    return parse_top_declaration(Q);
}