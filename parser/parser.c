#include "../diff.h"

#include "parser.h"
#include "../tokenizer/tokens.h"
#include "ast.h"
#include "../token_q.h"
#include "../util/stack.h"
#include "types.h"

// This is a terrible, kludgy workaround, and I apologize to myself and others.
hash* h_type_names = NULL;
hash* h_struct_names = NULL;

token* safe_deq(queue* Q) {
    if (queue_empty(Q)) {
        printf("Not enough tokens in queue for this operation");
        exit(1);
        return NULL;
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

/* Types in C are complicated, I'll use the following grammar: 
 * type := "int" | "void" | type "*"
 */

bool can_parse_type(queue* Q) {
    token_type t = safe_peek_type(Q);
    token* tok = safe_peek(Q);
    return t == KW_INT || t == KW_VOID || t == KW_STRUCT || t == KW_CHAR || t == KW_ENUM ||
           (t == NAME && hash_get(h_type_names, tok->repr) != NULL);
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
    node* n = NULL;

    if (t->type == NAME) {
        // Is this a variable or a function call?
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
        // Is this a cast or an expression?
        if (can_parse_type(Q)) {
            var_type* t = parse_type(Q);
            expect(Q, CLOSED_PAREN, ")");
            node* inner = parse_unary_prefix(Q); // Since cast has precedence 2
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

// Level 1
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

// Level 2
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

// Level 11
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

// Level 12
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

// Level 14
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
    node* init = NULL;
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
    int val;
    if (cond->type == AST_INTEGER) val = ((extra_int*)(cond->extra))->val;
    else {
        printf("Only integers allowed as cases\n");
        exit(1);
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
        // Function time! Oh baby
        queue* args = parse_args(Q);
        node* body = NULL;
        if (safe_peek_type(Q) != SEMICOLON) body = parse_sequence(Q);
        else expect_semicolon(Q);
        return new_node_function(type, name, args, body);
    }

    else {
        node* init = NULL;
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

    while (safe_peek_type(Q) != CLOSED_BRACE) {
        char* val = get_name(Q, "Enum val must be a name");
        enum_add_val(n, val);
        if (safe_peek_type(Q) == OP_COMMA) expect(Q, OP_COMMA, ",");
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
    if (h_struct_names == NULL) h_struct_names = hash_new(30);
    if (h_type_names == NULL) h_type_names = hash_new(30);
    return parse_top(Q);
}