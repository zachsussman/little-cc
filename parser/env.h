#pragma once

#include "../util/hash.h"
#include "ast.h"
#include "types.h"

typedef enum scope_type_e scope_type;
enum scope_type_e {
    VAR_GLOBAL,
    VAR_ARG,
    VAR_LOCAL
};

typedef struct var_info_s var_info;
struct var_info_s {
    var_type* lang_t;
    scope_type type;
    int index;
};

typedef struct fn_info_s fn_info;
struct fn_info_s {
    int argc;
    var_type* ret;
    hash* args;
    hash* locals;
    int local_size;
};

typedef struct env_s env;
struct env_s {
    fn_info* curr_fn;

    int global_count;
    hash* vars;

    int string_count;
    hash* strings;

    hash* fns;

    hash* structs;

    int label_count;
};

env* env_new();

void env_add_global(env* E, var_type* t, char* name);
var_info* env_get_info(env* E, char* name);

void env_add_fn(env* E, char* name, var_type* ret);
void env_add_fn_arg(env* E, char* name, var_type* t, char* arg);

void env_set_fn(env* E, char* name);
void env_clear_fn(env* E);
int env_num_args(env* E);
int env_get_args_size(env* E);

void env_add_fn_locals(env* E, char* name, queue* locals);
int env_get_local_size(env* E);

int env_get_string(env* E, char* s);
void env_do_over_vars(env* E, void* info, void (*f)(void*, char*, var_info*));
void env_do_over_strings(env* E, void* info, void (*f)(void*, char*, int));

void env_register_struct(env* E, char* name, var_type* decl);
t_struct_field* env_get_field(env* E, var_type* s, char* field);
var_type* env_get_type(env* E, char* name);

var_type* env_ast_type(env* E, node* n);

int env_get_label(env* E);