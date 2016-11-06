#include "../diff.h"
#include "../util/hash.h"
#include "env.h"
#include "ast.h"


int max(int a, int b) {
    if (a > b) return a;
    else return b;
}

var_info* new_global_var(env* E, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_GLOBAL;
    v->index = E->global_count++;
    return v;
}

var_info* new_arg_var(env* E, fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_ARG;
    v->index = f->argc;
    f->argc += max(type_get_size(E, t), 8);
    return v;
}

var_info* new_local_var(env* E, fn_info* f, var_type* t) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_LOCAL;
    v->index = f->local_size;
    f->local_size += max(type_get_size(E, t), 8);
    return v;
}

var_info* new_const_var(env* E, int val) {
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = type_new_base(LANG_INT);
    v->type = VAR_CONST;
    v->index = val;
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


fn_info* new_fn_reg_info (var_type* ret) {
    fn_info* v = malloc(sizeof(fn_info));
    v->ret = ret;
    v->args = hash_new(5); // Guess?
    v->locals = hash_new(5);
    v->argc = 0;
    v->local_size = -1;
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
    E->typedefs = hash_new(30);
    E->ends = stack_new();
    E->switches = queue_new();
    E->switchn = 0;
    E->label_count = 1;
    E->global_count = 1;
    E->string_count = 1; // A terrible bug: returning NULL from hash_get is the same as returning 0
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

void env_reg_fn(env* E, char* name, var_type* ret) {
    assert(is_env(E));

    char* new_name = strdup(name);
    fn_info* f = new_fn_reg_info(ret);
    hash_insert(E->fns, new_name, f);
}

void env_add_fn(env* E, char* name, var_type* ret) {
    assert(is_env(E));

    if (hash_get(E->fns, name) == NULL) {
           char* new_name = strdup(name);
        fn_info* f = new_fn_info(ret);
        hash_insert(E->fns, new_name, f); 
    }
    else {
        fn_info* fn = hash_get(E->fns, name);
        fn->local_size = 0;
    }

}

void env_add_fn_arg(env* E, char* name, var_type* t, char* arg) {
    assert(is_env(E));

    char* new_arg = strdup(arg);
    fn_info* f = hash_get(E->fns, name);
    hash_insert(f->args, new_arg, new_arg_var(E, f, t));
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
        var_info* v = new_local_var(E, f, e->type);
        hash_insert(f->locals, new_name, v);
    }
}

var_type* env_get_return_type(env* E, char* fn) {
    assert(is_env(E));
    fn_info* f = hash_get(E->fns, fn);
    if (f == NULL) return NULL;
    else return f->ret;
}

int env_align(int s) {
    if (s % 16 == 0) return s;
    else return (s/16 + 1) * 16;
}

int env_get_local_size(env* E) {
    assert(is_env(E));

    if (E->curr_fn) return env_align(E->curr_fn->local_size);
    else assert(false);
}

int env_get_args_size(env* E) {
    assert(is_env(E));
    if (E->curr_fn) return env_align(E->curr_fn->argc);
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

    while (s->base == LANG_UNDET || s->base == LANG_UNDET_STRUCT) {
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

void env_register_typedef(env* E, char* name, var_type* type) {
    assert(is_env(E));

    hash_insert(E->typedefs, strdup(name), type);
}

var_type* env_get_type(env* E, char* name) {
    assert(is_env(E));

    if (hash_get(E->structs, name)) return hash_get(E->structs, name);
    else if (hash_get(E->typedefs, name)) return hash_get(E->typedefs, name);
    else return NULL;
}

var_type* _env_promote(var_type* a, var_type* b) {
    if (a->base == LANG_POINTER) return a;
    else if (b->base == LANG_POINTER) return b;
    else if (a->base == LANG_INT && b->base == LANG_INT) return type_new_base(LANG_INT);
    else if (a->base == LANG_CHAR && b->base == LANG_CHAR) return type_new_base(LANG_CHAR);
    else return a;
}

var_type* _env_ast_binop_type(env* E, node* n) {
    extra_binop* e = n->extra;
    return _env_promote(env_ast_type(E, e->left), env_ast_type(E, e->right));
}

var_type* _env_ast_unop_type(env* E, node* n) {
    extra_unop* e = n->extra;
    return env_ast_type(E, e->inner);
}

var_type* env_dereference_type(env* E, var_type* type) {
    while (type != NULL && (type->base == LANG_UNDET_STRUCT || type->base == LANG_UNDET)) 
        type = env_get_type(E, type->extra);
    if (type->base != LANG_POINTER) {
        printf("Attempted to dereference non-pointer type %i (env_ast_type)\n", type->base);
        exit(1);
    }
    return type->extra;
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
    } else if (t == AST_CHAR) {
        type = type_new_base(LANG_CHAR);
    } else if (t == AST_FN_CALL) {
        type = env_get_return_type(E, ((extra_call*)(n->extra))->fn_name);
    } else if (t == AST_CAST) {
        type = ((extra_cast*)(n->extra))->type;
    } else if (t == AST_SIZEOF) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_ARROW) {
        extra_arrow* e = (extra_arrow*)n->extra;
        var_type* st_t = env_dereference_type(E, env_ast_type(E, e->inner));
        while (st_t != NULL && (st_t->base == LANG_UNDET_STRUCT || st_t->base == LANG_UNDET)) 
            st_t = env_get_type(E, st_t->extra);
        if (st_t->base != LANG_STRUCT) {
            printf("Attempted to arrow non-struct, env ast type, %i\n", st_t->base);
            exit(1);
        }
        type = type_get_field(st_t, e->field)->type;
    } else if (t == AST_ARRAY_SUB) {
        type = env_dereference_type(E, env_ast_type(E, ((extra_binop*)(n->extra))->left));
    } else if (t == AST_ADDRESS) {
        type = type_new_pointer(_env_ast_unop_type(E, n));
    } else if (t == AST_DEREFERENCE) {
        type = env_dereference_type(E, _env_ast_unop_type(E, n));
    } else if (t == AST_INCREMENT || t == AST_DECREMENT) {
        type = _env_ast_unop_type(E, n);
    } else if (t == AST_ADDITION || t == AST_SUBTRACTION || t == AST_MULTIPLICATION || t == AST_DIVISION) {
        type = _env_ast_binop_type(E, n);
    } else if (t == AST_LOGICAL_NOT || t == AST_LOGICAL_AND || t == AST_LOGICAL_OR ||
               t == AST_EQ || t == AST_NEQ || t == AST_LT || t == AST_LTE || t == AST_GT ||
               t == AST_GTE) {
        type = type_new_base(LANG_INT);
    } else if (t == AST_ASSIGN) {
        type = env_ast_type(E, ((extra_binop*)(n->extra))->left);
    }
    else {
        type = NULL;
    }
    while (type != NULL && (type->base == LANG_UNDET_STRUCT || type->base == LANG_UNDET)) {
        type = env_get_type(E, type->extra);
    }
    return type;
}

void env_do_over_vars(env* E, void* info, void* f) {
    assert(is_env(E));
    hash_do_over(E->vars, info, (void (*)(void*, char *, void*))f);
}

void env_do_over_strings(env* E, void* info, void* f) {
    assert(is_env(E));
    hash_do_over(E->strings, info, (void (*)(void*, char *, void*))f);
}

void env_do_over_fns(env* E, void* info, void* f) {
    assert(is_env(E));
    hash_do_over(E->fns, info, (void (*)(void*, char *, void*))f);
}

int env_get_label(env* E) {
    return (E->label_count)++;
}

void env_register_end(env* E, int end) {
    push(E->ends, (void*) end);
}

int env_last_end(env* E) {
    int x = pop(E->ends);
    push(E->ends, x);
    return x;
}

void env_deregister_end(env* E) {
    pop(E->ends);
}


int env_register_switch(env* E, int max, extra_case** cases) {
    switch_info* s = malloc(sizeof(switch_info));
    s->switchn = (E->switchn)++;
    s->max = max;
    enq(E->switches, s);
    return s->switchn;
}

typedef void foo(void*, void*, void*);
void env_do_over_switches(env* E, FILE* file, void* f) {
    queue* q = queue_readonly(E->switches);
    int i = 0;
    while (!queue_empty(q)) {
        (*((foo*)f))(file, deq(q), i);
        i++;
    }
}

void env_add_enum_value(env* E, char* name, int val) {
    assert(is_env(E));

    char* new_name = strdup(name);
    hash_insert(E->vars, new_name, new_const_var(E, val));
}

int type_get_size(env* E, var_type* t) {
    assert(t != NULL);

    switch (t->base) {
        case LANG_VOID:
        case LANG_INT:
        case LANG_POINTER:
            return 8;
        case LANG_CHAR:
            return 1;
        case LANG_UNDET_STRUCT:
        case LANG_UNDET:
            return type_get_size(E, env_get_type(E, t->extra));
        case LANG_STRUCT:
            return ((t_struct_extra*)(t->extra))->size;
        default:
            printf("What is type %i?\n", t->base);
            exit(1);
    }
}
