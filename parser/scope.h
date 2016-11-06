#include "../diff.h"

#include "../util/hash.h"

typedef struct var_env_s var_env;

typedef struct scope_s scope;
struct scope_s {
    hash* locals;
    scope* parent;
}