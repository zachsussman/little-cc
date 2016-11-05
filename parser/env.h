#pragma once

#include "../util/stack.h"
#include "../util/hash.h"
#include "ast.h"
#include "types.h"

typedef enum scope_type_e scope_type;
enum scope_type_e {
    VAR_GLOBAL,
    VAR_ARG,
    VAR_LOCAL,
    VAR_CONST
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

typedef struct switch_info_s switch_info;
struct switch_info_s {
    int switchn;
    int max;
    int* addrs;
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

    hash* typedefs;

    int label_count;

    stack* ends;

    queue* switches;
    int switchn;
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
void env_do_over_vars(env* E, void* info, void *f);
void env_do_over_strings(env* E, void* info, void *f);
void env_do_over_fns(env* E, void* info, void* f);

void env_register_struct(env* E, char* name, var_type* decl);
t_struct_field* env_get_field(env* E, var_type* s, char* field);
var_type* env_get_type(env* E, char* name);

void env_register_typedef(env* E, char* name, var_type* type);

var_type* env_ast_type(env* E, node* n);
int type_get_size(env* E, var_type* t);

int env_get_label(env* E);

void env_register_end(env* E, int end);
int env_last_end(env* E);
void env_deregister_end(env* E);

int env_register_switch(env* E, int max, extra_case** cases);
void env_do_over_switches(env* E, FILE* file, void *f);

void env_add_enum_value(env* E, char* name, int val);
