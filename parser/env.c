#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "../util/hash.h"
#include "env.h"


var_info* new_global_var(env* E, lang_type t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_GLOBAL;
    v->index = E->global_count++;
    return v;
}

var_info* new_arg_var(fn_info* f, lang_type t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_ARG;
    v->index = f->argc++;
    return v;
}

fn_info* new_fn_info(lang_type ret) {
    fn_info* v = malloc(sizeof(fn_info));
    v->ret = ret;
    v->args = hash_new(5); // Guess?
    v->argc = 0;
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
    E->label_count = 0;
    E->curr_fn = NULL;

    assert(is_env(E));
    return E;
}

int env_get_string(env* E, char* s) {
    if (hash_get(E->strings, s) == NULL) {
        char* new_s = strdup(s);
        hash_insert(E->strings, new_s, (void*)(E->string_count)++);
    }
    return (int)hash_get(E->strings, s);
}

void env_add_global(env* E, lang_type t, char* name) {
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
    }
    else if (hash_get(E->vars, name)) {
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

void env_add_fn(env* E, char* name, lang_type ret) {
    assert(is_env(E));
    char* new_name = strdup(name);
    fn_info* f = new_fn_info(ret);
    hash_insert(E->fns, new_name, f);
}

void env_add_fn_arg(env* E, char* name, lang_type t, char* arg) {
    assert(is_env(E));

    char* new_arg = strdup(arg);
    fn_info* f = hash_get(E->fns, name);
    hash_insert(f->args, new_arg, new_arg_var(f, t));
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
