#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "types.h"
 
var_type* VAR_INT = NULL;
var_type* VAR_VOID = NULL;
var_type* type_new_base(lang_type t) {
    if (VAR_INT == NULL) {
        VAR_INT = malloc(sizeof(var_type));
        VAR_INT->base = LANG_INT;
        VAR_INT->extra = NULL;
    }
    if (VAR_VOID == NULL) {
        VAR_VOID = malloc(sizeof(var_type));
        VAR_VOID->base = LANG_VOID;
        VAR_VOID->extra = NULL;
    }

    return (t == LANG_INT) ? VAR_INT : VAR_VOID;
}

var_type* type_new_pointer(var_type* inner) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_POINTER;
    v->extra = (void*) inner;
    return v;
}

var_type* type_pointer_inner(var_type* p) {
    return (var_type*) (p->extra);
}

var_type* type_new_fn(var_type* ret);

void type_print(var_type* v) {
    switch (v->base) {
        case LANG_INT:
            printf("int");
            break;
        case LANG_VOID:
            printf("void");
            break;
        case LANG_POINTER:
            type_print(type_pointer_inner(v));
            printf("*");
            break;
        default:
            printf("TYPE_UNKNOWN");
            break;
    }
}