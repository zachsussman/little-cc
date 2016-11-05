#include "../diff.h"

#include "../parser/ast.h"
#include "driver.h"
#include "../parser/env.h"

char** arg_registers;

void ast_lvalue_write(FILE* f, node* n, env* E);

void emit(FILE* f, char* s) {
    fprintf(f, "\t%s\n", s);
}

void ast_int_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_INTEGER);

    extra_int* e = n->extra;
    fprintf(f, "\tmov rax, %i\n", e->val);
}

void ast_char_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_CHAR);

    extra_char* e = n->extra;
    fprintf(f, "\tmov rax, %i\n", e->val);
}

void ast_var_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_VARIABLE);

    extra_var* e = (extra_var*) n->extra;
    var_info* v = env_get_info(E, e->name);

    char* mov_str;
    int var_size = type_get_size(E, v->lang_t);
    if (var_size == 1) {
        mov_str = "movzx rax, byte";
    } else {
        mov_str = "mov rax, qword";
    }

    if (v->type == VAR_GLOBAL) {
        fprintf(f, "\t%s [g%i]\n", mov_str, v->index);
    } else if (v->type == VAR_ARG) {
        fprintf(f, "\t%s [rbp+%i]\n", mov_str, v->index + 8);
    } else if (v->type == VAR_LOCAL) {
        fprintf(f, "\t%s [rbp-%i]\n", mov_str, v->index + 8);
    } else if (v->type == VAR_CONST) {
        fprintf(f, "\tmov rax, %i\n", v->index);
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
    while (t->base == LANG_UNDET || t->base == LANG_UNDET_STRUCT)
        t = env_get_type(E, t->extra);
    int size = type_get_size(E, t);
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
    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
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

void ast_array_sub_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ARRAY_SUB);

    extra_binop* e = (extra_binop*) n->extra;
    var_type* t = env_ast_type(E, e->left);
    if (t->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer\n");
        exit(1);
    }
    var_type* s = (var_type*) t->extra;
    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }

    ast_write(f, e->right, E);
    fprintf(f, "\timul rax, %i\n", type_get_size(E, s));
    emit(f, "push rax");
    ast_write(f, e->left, E);
    emit(f, "pop rcx");
    emit(f, "add rax, rcx");
    if (type_get_size(E, s) == 1) {
        emit(f, "xor rcx, rcx");
        emit(f, "mov cl, [rax]");
        emit(f, "mov rax, rcx");
    }
    else emit(f, "mov rax, [rax]");
}

void ast_cast_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_CAST);

    extra_cast* e = n->extra;
    ast_write(f, e->inner, E);
}

void ast_increment_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_INCREMENT);

    extra_unop* e = n->extra;

    ast_lvalue_write(f, e->inner, E);
    emit(f, "mov rcx, [rax]");
    emit(f, "add qword [rax], 1");
    emit(f, "mov rax, rcx");
}

void ast_decrement_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_DECREMENT);

    extra_unop* e = n->extra;

    ast_lvalue_write(f, e->inner, E);
    emit(f, "mov rcx, [rax]");
    emit(f, "sub qword [rax], 1");
    emit(f, "mov rax, rcx");
}

void ast_negative_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_NEGATIVE);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);
    emit(f, "neg rax");
}


void ast_address_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ADDRESS);

    extra_unop* u = (extra_unop*) n->extra;

    ast_lvalue_write(f, u->inner, E);
}

void ast_dereference_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_DEREFERENCE);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);

    int var_size = type_get_size(E, env_ast_type(E, n));
    if (var_size == 1) {
        emit(f, "xor rcx, rcx");
        emit(f, "mov cl, [rax]");
        emit(f, "mov rax, rcx");
    }
    else {
        emit(f, "mov rax, [rax]");
    }
}

void ast_logical_not_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LOGICAL_NOT);

    extra_unop* u = (extra_unop*) n->extra;
    ast_write(f, u->inner, E);
    emit(f, "test rax, rax");
    emit(f, "setz cl");
    emit(f, "movzx rax, cl");
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
            fprintf(f, "\tlea rax, [rbp+%i]\n", v->index + 8);
        } else if (v->type == VAR_LOCAL) {
            fprintf(f, "\tlea rax, [rbp-%i]\n", v->index + 8);
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
    } else if (n->type == AST_ARRAY_SUB) {
        extra_binop* e = (extra_binop*) n->extra;
        var_type* t = env_ast_type(E, e->left);
        if (t->base != LANG_POINTER) {
            printf("Attempted to dereference non-pointer\n");
            exit(1);
        }
        var_type* s = (var_type*) t->extra;
        while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
            s = env_get_type(E, s->extra);
        }

        ast_write(f, e->right, E);
        fprintf(f, "\timul rax, %i\n", type_get_size(E, s));
        emit(f, "push rax");
        ast_write(f, e->left, E);
        emit(f, "pop rcx");
        emit(f, "add rax, rcx");
    }
}

void ast_logical_and_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LOGICAL_AND);

    int end_label = env_get_label(E);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->left, E);
    emit(f, "test rax, rax");
    fprintf(f, "\tjz label_%i\n", end_label);
    ast_write(f, e->right, E);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_logical_or_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LOGICAL_OR);

    int end_label = env_get_label(E);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->left, E);
    emit(f, "test rax, rax");
    fprintf(f, "\tjnz label_%i\n", end_label);
    ast_write(f, e->right, E);
    fprintf(f, "label_%i:\n", end_label);
}

void ast_assign_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ASSIGN);

    extra_binop* e = (extra_binop*) n->extra;
    ast_write(f, e->right, E);

    emit(f, "push rax");
    ast_lvalue_write(f, e->left, E);
    emit(f, "pop rcx");

    int type_size = type_get_size(E, env_ast_type(E, e->left));
    if (type_size == 1) emit(f, "mov [rax], cl");
    else emit(f, "mov [rax], rcx");
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

    env_register_end(E, end_label);

    extra_while* e = (extra_while*) n->extra;
    fprintf(f, "label_%i:\n", cond_label);
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);
    fprintf(f, "\tjmp label_%i\n", cond_label);
    fprintf(f, "label_%i:\n", end_label);

    env_deregister_end(E);
}

void ast_for_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_FOR);

    int cond_label = env_get_label(E);
    int end_label = env_get_label(E);

    env_register_end(E, end_label);

    extra_for* e = n->extra;
    ast_write(f, e->init, E);
    fprintf(f, "label_%i:\n", cond_label);
    ast_write(f, e->cond, E);
    emit(f, "cmp rax, 0");
    fprintf(f, "\tje label_%i\n", end_label);
    ast_write(f, e->body, E);
    ast_write(f, e->end, E);
    fprintf(f, "\tjmp label_%i\n", cond_label);
    fprintf(f, "label_%i:\n", end_label);

    env_deregister_end(E);
}

void ast_return_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_RETURN);

    extra_unop* e = (extra_unop*) n->extra;
    ast_write(f, e->inner, E);


    fprintf(f, "\tadd rsp, %i\n", env_get_local_size(E));
    emit(f, "pop rbp");
    fprintf(f, "\tadd rsp, %i\n", env_get_args_size(E));

    emit(f, "ret");
}

void ast_break_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_BREAK);

    int end_label = env_last_end(E);
    fprintf(f, "\tjmp label_%i\n", end_label);
}

void ast_declaration_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_LOCAL_DECLARATION);

    extra_declaration* e = (extra_declaration*) n->extra;

    if (e->init == NULL) return;
    var_info* v = env_get_info(E, e->name);
    ast_write(f, e->init, E);
    fprintf(f, "\tmov [rbp-%i], rax\n", v->index + 8);
}

void ast_sequence_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_SEQUENCE);

    while (!sequence_empty(n)) {
        ast_write(f, sequence_deq(n), E);
    }
}

void ast_switch_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_SWITCH);

    extra_switch* e = n->extra;

    ast_write(f, e->cond, E);

    int switchn = env_register_switch(E, e->length, e->cases);
    int endl = env_get_label(E);
    env_register_end(E, endl);

    // emit(f, "cmp rax, 0");
    // fprintf(f, "\tjl switch_%i_default\n", switchn);
    // fprintf(f, "\tcmp rax, %i\n", e->length);
    // fprintf(f, "\tjge switch_%i_default\n", switchn);

    // Fuck this. If I can figure this out later I will, but it's 1:00 AM
    // emit(f, "imul rax, 8");
    // fprintf(f, "\tmov rcx, qword [switch_table_%i+rax]\n", switchn);
    // emit(f, "jmp rcx");
    // fprintf(f, "switch_%i_base:\n", switchn);
    for (int i = 0; i < e->length; i++) {
        if (e->cases[i] != NULL) {
            fprintf(f, "\tcmp rax, %i\n", i);
            fprintf(f, "\tje switch_%i_case_%i\n", switchn, i);
        }
    }
    fprintf(f, "\tjmp switch_%i_default\n", switchn);

    for (int i = 0; i < e->length; i++) {
        if (e->cases[i]) {
            fprintf(f, "switch_%i_case_%i:\n", switchn, i);
            ast_write(f, e->cases[i]->body, E);
        }
    }

    fprintf(f, "switch_%i_default:\n", switchn);
    ast_write(f, e->n_default, E);

    fprintf(f, "label_%i:\n", endl);
    env_deregister_end(E);
}

void ast_function_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_FUNCTION);

    extra_function* e = (extra_function*) n->extra;
    if (e->body == NULL) {
        env_reg_fn(E, e->name, e->ret);
        // printf("Invisible function\n");
        // fprintf(f, "extern _%s\n", e->name);
        return;
    }
    env_add_fn(E, e->name, e->ret);
    for (int i = 0; i < e->argc; i++) {
        env_add_fn_arg(E, e->name, e->args[i]->type, e->args[i]->name);
    }

    env_add_fn_locals(E, e->name, ast_locals(n));

    env_set_fn(E, e->name);

    fprintf(f, "_%s:\n", e->name);
    if (e->argc % 2 != 0) 
        fprintf(f, "\tsub rsp, %i\n", 8);
    for (int i = e->argc-1; i >= 0; i--) {
        fprintf(f, "\tpush %s\n", arg_registers[i]);
    }

    emit(f, "push rbp");
    emit(f, "mov rbp, rsp");



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

void ast_typedef_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_TYPEDEF);

    extra_typedef* e = (extra_typedef*) n->extra;
    env_register_typedef(E, e->name, e->type);
}

void ast_enum_write(FILE* f, node* n, env* E) {
    assert(n != NULL);
    assert(n->type == AST_ENUM);

    extra_enum* e = n->extra;

    env_register_typedef(E, e->name, type_new_base(LANG_INT));

    int i = 0;
    while (!queue_empty(e->vals)) {
        env_add_enum_value(E, deq(e->vals), i);
        i++;
    }
}

void ast_write(FILE* f, node* n, env* E) {
    assert(n != NULL);

    switch(n->type) {
        case AST_INTEGER:
            ast_int_write(f, n, E);
            break;
        case AST_CHAR:
            ast_char_write(f, n, E);
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
        case AST_CAST:
            ast_cast_write(f, n, E);
            break;
        case AST_ARROW:
            ast_arrow_write(f, n, E);
            break;
        case AST_ARRAY_SUB:
            ast_array_sub_write(f, n, E);
            break;
        case AST_INCREMENT:
            ast_increment_write(f, n, E);
            break;
        case AST_DECREMENT:
            ast_decrement_write(f, n, E);
            break;
        case AST_NEGATIVE:
            ast_negative_write(f, n, E);
            break;
        case AST_ADDRESS:
            ast_address_write(f, n, E);
            break;
        case AST_DEREFERENCE:
            ast_dereference_write(f, n, E);
            break;
        case AST_LOGICAL_NOT:
            ast_logical_not_write(f, n, E);
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
        case AST_LOGICAL_AND:
            ast_logical_and_write(f, n, E);
            break;
        case AST_LOGICAL_OR:
            ast_logical_or_write(f, n, E);
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
        case AST_FOR:
            ast_for_write(f, n, E);
            break;
        case AST_BREAK:
            ast_break_write(f, n, E);
            break;
        case AST_SWITCH:
            ast_switch_write(f, n, E);
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
        case AST_TYPEDEF:
            ast_typedef_write(f, n, E);
            break;
        case AST_ENUM:
            ast_enum_write(f, n, E);
            break;
        default:
            fprintf(f, "; unknown instruction %i\n", n->type);
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
    fprintf(f, "section .text\n");
    fprintf(f, "\n");
}

void write_var(void* vf, char* name, var_info* v) {
    if (v->type == VAR_CONST) return;
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

void write_fn_info(FILE* f, char* name, fn_info* fn) {
    if (fn->local_size == -1) fprintf(f, "extern _%s\n", name);
    else fprintf(f, "global _%s\n", name);
}
void write_switch(FILE* f, switch_info* s, int switchn) {
    fprintf(f, "switch_table_%i:\n", switchn);
    for (int i = 0; i < s->max; i++) {
        fprintf(f, "\tdq switch_%i_case_%i\n", switchn, i);
    }
}

void write_footer(FILE* f, env* E) {
    emit(f, "");
    fprintf(f, "section .data\n");
    emit(f, "dummy: dw 16"); 
    env_do_over_vars(E, (void*) f, &write_var);
    env_do_over_strings(E, (void*) f, &write_string);
    env_do_over_fns(E, f, &write_fn_info);
    // env_do_over_switches(E, f, &write_switch);
}