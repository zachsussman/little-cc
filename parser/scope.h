#pragma once
#include "../diff.h"
#include "types.h"
#include "../util/hash.h"

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


typedef struct scope_s scope;
struct scope_s {
    hash* locals;
    scope* parent;
    int nown;
    int nall;
};

bool is_scope(scope* s);
scope* scope_new(scope* parent);
void scope_add_local(scope* s, char* name, var_type* t);
var_info* scope_find_local(scope* s, char* name);