#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

#include "../parser/ast.h"
#include "driver.h"
#include "../parser/env.h"

char** arg_registers;

void emit(FILE* f, char* s) {
    fprintf(f, "\t%s\n", s);
}

void ast_int_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_INTEGER);

    extra_int* e = (extra_int*)n->extra;
    fprintf(f, "\tmov rax, %i\n", e->val);
}

void ast_var_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_VARIABLE);

    extra_var* e = (extra_var*) n->extra;
    var_info* v = env_get_info(E, e->name);
    if (v->type == VAR_GLOBAL) {
        fprintf(f, "\tmov rax, qword [g%i]\n", v->index);
    } else if (v->type == VAR_ARG) {
        int local_size = env_get_local_size(E);
        fprintf(f, "\tmov rax, qword [rbp+%i]\n", local_size + v->index + 8);
    } else if (v->type == VAR_LOCAL) {
        fprintf(f, "\tmov rax, qword [rbp+%i]\n", v->index + 8);
    }
}

void ast_string_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_STRING);

    extra_string* e = (extra_string*) n->extra;
    int index = env_get_string(E, e->s);
    fprintf(f, "\tmov rax, _string_%i\n", index);
}

void ast_call_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_FN_CALL);

    extra_call* e = (extra_call*) n->extra;

    int arg_num = 0;
    while (!node_call_empty(n)) {
        ast_write(f, node_call_deq(n), E);
        emit(f, "push rax");
        arg_num++;
    }
    for (int i = arg_num-1; i >= 0; i--) {
        fprintf(f, "\tpop %s\n", arg_registers[i]);
    }

    emit(f, "mov al, 0");
    fprintf(f, "\tcall _%s\n", e->fn_name);
}

void ast_sizeof_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_SIZEOF);

    extra_sizeof* e = (extra_sizeof*) n->extra;
    var_type* t = e->type;
    if (t->base == LANG_UNDET || t->base == LANG_UNDET_STRUCT)
        t = env_get_type(E, t->extra);

    int size = type_get_size(t);
    fprintf(f, "\tmov rax, %d\n", size);
}

void ast_arrow_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ARROW);

    extra_arrow* e = (extra_arrow*) n->extra;
    var_type* t = env_ast_type(E, e->inner);
    if (t->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer\n");
        exit(1);
    }
    var_type* s = (var_type*) t->extra;
    if (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }
    if (s->base != LANG_STRUCT) {
        printf("Attempted to arrow non-struct-pointer %i\n", s->base);
        exit(1);
    }
    int index = type_get_field(s, e->field)->index;

    ast_write(f, e->inner, E);
    fprintf(f, "\tmov rax, [rax+%i]\n", index*8);
}

void ast_address_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ADDRESS);

    extra_unop* u = (extra_unop*) n->extra;
    assert(u->inner->type == AST_VARIABLE);
    extra_var* e = (extra_var*) u->inner->extra;
    var_info* v = env_get_info(E, e->name);
    if (v->type == VAR_GLOBAL) {
        fprintf(f, "\tmov rax, g%i\n", v->index);
    }
}

void ast_dereference_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_DEREFERENCE);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);
    emit(f, "mov rax, [rax]");
}

void ast_binop_write(FILE* f, node* n, env* E, char* op) {
    assert(n != NULL);

    extra_binop* e = (extra_binop*)n->extra;

    ast_write(f, e->right, E);
    emit(f, "push rax");
    ast_write(f, e->left, E);
    emit(f, "pop rcx");
    emit(f, op);
}

void ast_add_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ADDITION);

    ast_binop_write(f, n, E, "add rax, rcx");
}

void ast_sub_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_SUBTRACTION);

    ast_binop_write(f, n, E, "sub rax, rcx");
}

void ast_mul_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_MULTIPLICATION);

    ast_binop_write(f, n, E, "mul rcx");
}

void ast_div_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_DIVISION);

    ast_binop_write(f, n, E, "cqo\n\tdiv rcx");
}

void ast_lt_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LT);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetl al\n\tmovzx rax, al");
}

void ast_lte_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LTE);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetle al\n\tmovzx rax, al");
}

void ast_gt_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_GT);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetg al\n\tmovzx rax, al");
}

void ast_gte_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_GTE);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetge al\n\tmovzx rax, al");
}

void ast_eq_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_EQ);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsete al\n\tmovzx rax, al");
}

void ast_neq_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_NEQ);

    ast_binop_write(f, n, E, "cmp rax, rcx\n\tsetne al\n\tmovzx rax, al");
}

void ast_lvalue_write(FILE* f, node* n, env* E) {
    assert(n != NULL);

    if (n->type == AST_VARIABLE) {
        extra_var* e = (extra_var*) n->extra;
        var_info* v = env_get_info(E, e->name);
        if (v->type == VAR_GLOBAL) {
            fprintf(f, "\tmov rax, g%i\n", v->index);
        } else if (v->type == VAR_ARG) {
            fprintf(f, "\tlea rax, [rbp+%i]\n", env_get_local_size(E) + v->index + 8);
        } else if (v->type == VAR_LOCAL) {
            fprintf(f, "\tlea rax, [rbp+%i]\n", v->index + 8);
        }
    }
    else if (n->type == AST_DEREFERENCE) {
        ast_write(f, ((extra_unop*)(n->extra))->inner, E);
    } else if (n->type == AST_ARROW) {
        extra_arrow* e = n->extra;
        ast_write(f, e->inner, E);
        var_type* s = env_ast_type(E, e->inner);
        if (s->base != LANG_POINTER) {
            printf("Attempted to dereference non-pointer type %i", s->base);
            exit(1);
        }
        s = s->extra;
        int index = env_get_field(E, s, e->field)->index;
        fprintf(f, "\tadd rax, %i\n", index*8);
    }
}

void ast_assign_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ASSIGN);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->right, E);

    emit(f, "push rax");
    ast_lvalue_write(f, e->left, E);
    emit(f, "pop rcx");
    emit(f, "mov [rax], rcx");
}  
    

void ast_statement_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_STATEMENT);

    extra_statement* e = (extra_statement*) n->extra;
    ast_write(f, e->expr, E);
}

void ast_if_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_IF);

    int end_label = env_get_label(E);

    extra_if* e = (extra_if*) n->extra;
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);

    if (e->else_body == NULL) {
        fprintf(f, "label_%i:\n", end_label);
    } else {
        int real_end_label = env_get_label(E);
        fprintf(f, "\tjmp label_%i\n", real_end_label);
        fprintf(f, "label_%i:\n", end_label);
        ast_write(f, e->else_body, E);
        fprintf(f, "label_%i:\n", real_end_label);
    }
}

void ast_while_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_WHILE);

    int cond_label = env_get_label(E);
    int end_label = env_get_label(E);

    extra_while* e = (extra_while*) n->extra;
    fprintf(f, "label_%i:\n", cond_label);
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);
    fprintf(f, "\tjmp label_%i\n", cond_label);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_return_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_RETURN);

    extra_unop* e = (extra_unop*) n->extra;
    ast_write(f, e->inner, E);


    emit(f, "pop rbp");
    fprintf(f, "\tadd rsp, %i\n", env_get_local_size(E) + env_get_args_size(E));
    emit(f, "ret");
}

void ast_declaration_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LOCAL_DECLARATION);

    // Do nothing, lookahead does this for us

    // extra_declaration* e = (extra_declaration*) n->extra;
    // env_add_global(E, e->type, e->name);
}

void ast_sequence_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_SEQUENCE);

    while (!sequence_empty(n)) {
        ast_write(f, sequence_deq(n), E);
    }
}

void ast_function_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_FUNCTION);

    extra_function* e = (extra_function*) n->extra;
    env_add_fn(E, e->name, e->ret);
    for (int i = 0; i < e->argc; i++) {
        env_add_fn_arg(E, e->name, e->args[i]->type, e->args[i]->name);
    }

    env_add_fn_locals(E, e->name, ast_locals(n));
    if (e->body == NULL) return;

    fprintf(f, "_%s:\n", e->name);
    for (int i = e->argc-1; i >= 0; i--) {
        fprintf(f, "\tpush %s\n", arg_registers[i]);
    }

    emit(f, "push rbp");
    emit(f, "mov rbp, rsp");

    env_set_fn(E, e->name);

    fprintf(f, "\tsub rsp, %i\n", env_get_local_size(E));
    ast_write(f, e->body, E);

    fprintf(f, "\tadd rsp, %i\n", env_get_local_size(E));
    emit(f, "pop rbp");
    fprintf(f, "\tadd rsp, %i\n", env_get_args_size(E));

    emit(f, "ret");

    env_clear_fn(E);
}

void ast_struct_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_STRUCT_DECLARATION);

    extra_struct* e = (extra_struct*) n->extra;
    env_register_struct(E, e->name, e->decl);
}

void ast_write(FILE* f, node* n, env* E) {
    assert(n != NULL);

    switch(n->type) {
        case AST_INTEGER:
            ast_int_write(f, n, E);
            break;
        case AST_VARIABLE:
            ast_var_write(f, n, E);
            break;
        case AST_STRING:
            ast_string_write(f, n, E);
            break;
        case AST_FN_CALL:
            ast_call_write(f, n, E);
            break;
        case AST_SIZEOF:
            ast_sizeof_write(f, n, E);
            break;
        case AST_ARROW:
            ast_arrow_write(f, n, E);
            break;
        case AST_ADDRESS:
            ast_address_write(f, n, E);
            break;
        case AST_DEREFERENCE:
            ast_dereference_write(f, n, E);
            break;
        case AST_ADDITION:
            ast_add_write(f, n, E);
            break;
        case AST_SUBTRACTION:
            ast_sub_write(f, n, E);
            break;
        case AST_MULTIPLICATION:
            ast_mul_write(f, n, E);
            break;
        case AST_DIVISION:
            ast_div_write(f, n, E);
            break;
        case AST_LT:
            ast_lt_write(f, n, E);
            break;
        case AST_LTE:
            ast_lte_write(f, n, E);
            break;
        case AST_GT:
            ast_gt_write(f, n, E);
            break;
        case AST_GTE:
            ast_gte_write(f, n, E);
            break;
        case AST_EQ:
            ast_eq_write(f, n, E);
            break;
        case AST_NEQ:
            ast_neq_write(f, n, E);
            break;
        case AST_ASSIGN:
            ast_assign_write(f, n, E);
            break;
        case AST_LOCAL_DECLARATION:
            ast_declaration_write(f, n, E);
            break;
        case AST_STATEMENT:
            ast_statement_write(f, n, E);
            break;
        case AST_IF:
            ast_if_write(f, n, E);
            break;
        case AST_WHILE:
            ast_while_write(f, n, E);
            break;
        case AST_RETURN:
            ast_return_write(f, n, E);
            break;
        case AST_SEQUENCE:
            ast_sequence_write(f, n, E);
            break;
        case AST_FUNCTION:
            ast_function_write(f, n, E);
            break;
        case AST_STRUCT_DECLARATION:
            ast_struct_write(f, n, E);
            break;
        default:
            emit(f, "; unknown instruction");
            break;
    }
}

void write_header(FILE* f) {
    arg_registers = malloc(sizeof(char*) * 6);
    arg_registers[0] = "rdi";
    arg_registers[1] = "rsi";
    arg_registers[2] = "rdx";
    arg_registers[3] = "rcx";
    arg_registers[4] = "r8";
    arg_registers[5] = "r9";

    fprintf(f, "default rel\n");
    fprintf(f, "extern _exit\n");
    fprintf(f, "extern _printf\n");
    fprintf(f, "extern _malloc\n");
    fprintf(f, "section .text\n");
    fprintf(f, "global _main\n");
    fprintf(f, "\n");
}

void write_var(void* vf, char* name, var_info* v) {
    FILE* f = (FILE*) vf;
    fprintf(f, "\tg%i: %s 0\n", v->index, "dq");
}

void write_string(void* vf, char* name, int index) {
    FILE* f = (FILE*) vf;
    fprintf(f, "\t_string_%i: db ", index);
    while (*name != '\0') {
        fprintf(f, "%i, ", (int)(*name));
        name++;
    }
    fprintf(f, "0\n");
}

void write_footer(FILE* f, env* E) {
    emit(f, "");
    fprintf(f, "section .data\n");
    emit(f, "dummy: dw 16"); 
    env_do_over_vars(E, (void*) f, &write_var);
    env_do_over_strings(E, (void*) f, &write_string);
}