#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "../util/hash.h"
#include "env.h"
#include "ast.h"


var_info* new_global_var(env* E, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_GLOBAL;
    v->index = E->global_count++;
    return v;
}

var_info* new_arg_var(fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_ARG;
    v->index = f->argc;
    f->argc += type_get_size(t);
    return v;
}

var_info* new_local_var(fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_LOCAL;
    v->index = f->local_size;
    f->local_size += type_get_size(t);
    return v;
}

fn_info* new_fn_info(var_type* ret) {
    fn_info* v = malloc(sizeof(fn_info));
    v->ret = ret;
    v->args = hash_new(5); // Guess?
    v->locals = hash_new(5);
    v->argc = 0;
    v->local_size = 0;
    return v;
}

bool is_env(env* E) {
    return E != NULL && E->vars != NULL;
}

env* env_new() {
    env* E = malloc(sizeof(env));
    E->vars = hash_new(30); // Fudged value, not really sure
    E->strings = hash_new(30);
    E->fns = hash_new(30);
    E->structs = hash_new(30);
    E->label_count = 0;
    E->global_count = 0;
    E->string_count = 0;
    E->curr_fn = NULL;

    assert(is_env(E));
    return E;
}

int env_get_string(env* E, char* s) {
    assert(is_env(E));

    if (hash_get(E->strings, s) == NULL) {
        char* new_s = strdup(s);
        hash_insert(E->strings, new_s, (void*)(E->string_count)++);
    }

    return (int)hash_get(E->strings, s);
}

void env_add_global(env* E, var_type* t, char* name) {
    assert(is_env(E));

    char* new_name = strdup(name);
    var_info* v = new_global_var(E, t);
    hash_insert(E->vars, new_name, v);

    assert(is_env(E));
}

var_info* env_get_info(env* E, char* name) {
    assert(is_env(E));
    if (E->curr_fn && hash_get(E->curr_fn->args, name)) {
        return (var_info*) hash_get(E->curr_fn->args, name);
    } else if (E->curr_fn && hash_get(E->curr_fn->locals, name)) {
        return (var_info*) hash_get(E->curr_fn->locals, name);
    } else if (hash_get(E->vars, name)) {
        return (var_info*) hash_get(E->vars, name);
    } else {
        printf("Variable '%s' not found\n", name);
        assert(false);
    }
    
}

void env_set_fn(env* E, char* name) {
    assert(is_env(E));
    fn_info* f = hash_get(E->fns, name);
    if (f == NULL) {
        printf("Function %s not found\n", name);
        assert(false);
    }
    else {
        E->curr_fn = f;
    }
}

void env_clear_fn(env* E) {
    assert(is_env(E));
    E->curr_fn = NULL;
}

int env_num_args(env* E) {
    assert(is_env(E));
    if (E->curr_fn == NULL) return 0;
    else return E->curr_fn->argc;
}

void env_add_fn(env* E, char* name, var_type* ret) {
    assert(is_env(E));

    char* new_name = strdup(name);
    fn_info* f = new_fn_info(ret);
    hash_insert(E->fns, new_name, f);
}

void env_add_fn_arg(env* E, char* name, var_type* t, char* arg) {
    assert(is_env(E));

    char* new_arg = strdup(arg);
    fn_info* f = hash_get(E->fns, name);
    hash_insert(f->args, new_arg, new_arg_var(f, t));
}

void env_add_fn_locals(env* E, char* name, queue* locals) {
    assert(is_env(E));
    assert(locals != NULL);

    fn_info* f = hash_get(E->fns, name);
    queue* Q = queue_readonly(locals);

    int index = 0;
    while (!queue_empty(Q)) {
        extra_declaration* e = deq(Q);
        char* new_name = strdup(e->name);
        var_info* v = new_local_var(f, e->type);
        hash_insert(f->locals, new_name, v);
    }
}

var_type* env_get_return_type(env* E, char* fn) {
    assert(is_env(E));
    fn_info* f = hash_get(E->fns, fn);
    if (f == NULL) return NULL;
    else return f->ret;
}

int env_get_local_size(env* E) {
    assert(is_env(E));

    if (E->curr_fn) return E->curr_fn->local_size;
    else assert(false);
}

int env_get_args_size(env* E) {
    assert(is_env(E));
    if (E->curr_fn) return E->curr_fn->argc;
    else assert(false);
}

void env_register_struct(env* E, char* name, var_type* decl) {
    assert(is_env(E));

    hash_insert(E->structs, strdup(name), decl);
}

t_struct_field* env_get_field(env* E, var_type* s, char* field) {
    assert(is_env(E));
    assert(s != NULL);
    assert(field != NULL);

    if (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
        s = env_get_type(E, s->extra);
    }

    if (s == NULL || s->base != LANG_STRUCT) {
        printf("Attempted to get field from non-struct (env_get_field) ");
        if (s != NULL) printf("%i", s->base);
        printf("\n");
        exit(1);
    }

    t_struct_extra* e = s->extra;
    return hash_get(e->fields, field);
}

var_type* env_get_type(env* E, char* name) {
    assert(is_env(E));

    if (hash_get(E->structs, name)) return hash_get(E->structs, name);
    else return NULL;
}

// Yes, this shouldn't be here.  Well, fuck you too.
var_type* env_ast_type(env* E, node* n) {
    assert(n != NULL);
    assert(is_env(E));

    var_type* type;

    node_type t = n->type;
    if (t == AST_VARIABLE) {
        var_info* v = env_get_info(E, ((extra_var*)(n->extra))->name);
        if (v == NULL) type = NULL;
        type = v->lang_t;
    } else if (t == AST_INTEGER) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_FN_CALL) {
        type = env_get_return_type(E, ((extra_call*)(n->extra))->fn_name);
    } else if (t == AST_ARROW) {
        extra_arrow* e = (extra_arrow*)n->extra;
        type = type_get_field(env_ast_type(E, e->inner), e->field)->type;
    } else {
        type = NULL;
    }
    if (type != NULL && type->base == LANG_UNDET_STRUCT) {
        type = env_get_type(E, type->extra);
    }
    return type;
}

void env_do_over_vars(env* E, void* info, void (*f)(void*, char*, var_info*)) {
    assert(is_env(E));
    hash_do_over(E->vars, info, (void (*)(void*, char *, void*))f);
}

void env_do_over_strings(env* E, void* info, void (*f)(void*, char*, int)) {
    assert(is_env(E));
    hash_do_over(E->strings, info, (void (*)(void*, char *, void*))f);
}

int env_get_label(env* E) {
    return (E->label_count)++;
}
