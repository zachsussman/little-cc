#pragma once

#include "../util/hash.h"
#include "ast.h"

typedef enum scope_type_e scope_type;
enum scope_type_e {
    VAR_GLOBAL,
    VAR_LOCAL
};

typedef struct var_info_s var_info;
struct var_info_s {
    lang_type lang_t;
    scope_type type;
    int index;
};

typedef struct fn_info_s fn_info;
struct fn_info_s {
    int argc;
    lang_type ret;
    hash* args;
};

typedef struct env_s env;
struct env_s {
    fn_info* curr_fn;

    int global_count;
    hash* vars;

    int string_count;
    hash* strings;

    hash* fns;

    int label_count;

};

env* env_new();

void env_add_global(env* E, lang_type t, char* name);
var_info* env_get_info(env* E, char* name);

void env_add_fn(env* E, char* name, lang_type ret);
void env_add_fn_arg(env* E, char* name, lang_type t, char* arg);

int env_get_string(env* E, char* s);
void env_do_over_vars(env* E, void* info, void (*f)(void*, char*, var_info*));
void env_do_over_strings(env* E, void* info, void (*f)(void*, char*, int));

int env_get_label(env* E);