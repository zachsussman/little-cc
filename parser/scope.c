#include "../diff.h"
#include "scope.h"
#include "types.h"

bool is_scope(scope* s) {
    return s != NULL && s->locals != NULL &&
           s->nown == s->locals->size*8 && s->nall >= s->nown;
}

scope* scope_new(scope* parent) {
    assert(is_scope(parent) || parent == NULL);

    scope* s = malloc(sizeof(scope));
    s->locals = hash_new(10);
    s->nown = 0;
    s->nall = 0;
    s->parent = parent;

    return s;
}

int scope_get_next_index(scope* s) {
    if (s == NULL) return 0;
    else return scope_get_next_index(s->parent) + s->nown;
}

void scope_add_count(scope* s, int c) {
    while (s != NULL) {
        s->nall = s->nall + c;
        s = s->parent;
    }
}

void scope_add_local(scope* s, char* name, var_type* t) {
    if (hash_get(s->locals, name) != NULL) return;
    
    var_info* v = malloc(sizeof(var_info));
    v->lang_t = t;
    v->type = VAR_LOCAL;
    v->index = scope_get_next_index(s);

    hash_insert(s->locals, strdup(name), v);
    int size = 8; // WRONG, WRONG, WRONG
    s->nown = s->nown + size;
    scope_add_count(s, size);
}

var_info* scope_find_local(scope* s, char* name) {
    if (s == NULL) return NULL;

    var_info* v = hash_get(s->locals, name);
    if (v == NULL)  return scope_find_local(s->parent, name);
    else return v;
}