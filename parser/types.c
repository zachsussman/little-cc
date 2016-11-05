#include "../diff.h"

#include "types.h"
 
var_type* VAR_INT = NULL;
var_type* VAR_VOID = NULL;
var_type* VAR_CHAR = NULL;
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
    if (VAR_CHAR == NULL) {
        VAR_CHAR = malloc(sizeof(var_type));
        VAR_CHAR->base = LANG_CHAR;
        VAR_CHAR->extra = NULL;
    }

    if (t == LANG_INT) return VAR_INT;
    else if (t == LANG_VOID) return VAR_VOID;
    else if (t == LANG_CHAR) return VAR_CHAR;
    else {
        printf("Unknown type %i\n", t);
        exit(1);
    }
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

var_type* type_new_struct() {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_STRUCT;
    t_struct_extra* e = malloc(sizeof(t_struct_extra));
    e->nfields = 0;
    e->size = 0;
    e->fields = hash_new(5);
    v->extra = (void*) e;
    return v;
}

void type_add_field(var_type* s, char* name, var_type* type) {
    assert(s != NULL);
    assert(s->base == LANG_STRUCT);

    t_struct_extra* e = (t_struct_extra*) s->extra;
    t_struct_field* f = malloc(sizeof(t_struct_field));
    f->type = type;
    f->index = e->nfields;
    (e->nfields)++;
    (e->size) += 8;

    hash_insert(e->fields, strdup(name), f);
}

t_struct_field* type_get_field(var_type* s, char* name) {
    assert(s != NULL);
    assert(s->base == LANG_STRUCT);

    t_struct_extra* e = (t_struct_extra*) s->extra;
    return (t_struct_field*) hash_get(e->fields, name);
}


var_type* type_new_undet_struct(char* name) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_UNDET_STRUCT;
    v->extra = (void*) strdup(name);
    return v;
}

var_type* type_new_undet(char* name) {
    var_type* v = malloc(sizeof(var_type));
    v->base = LANG_UNDET;
    v->extra = (void*) strdup(name);
    return v;
}


void type_print(var_type* v) {
    assert(v != NULL);

    switch (v->base) {
        case LANG_INT:
            printf("int");
            break;
        case LANG_VOID:
            printf("void");
            break;
        case LANG_CHAR:
            printf("char");
            break;
        case LANG_POINTER:
            type_print(type_pointer_inner(v));
            printf("*");
            break;
        case LANG_UNDET_STRUCT:
            printf("struct %s", v->extra);
            break;
        case LANG_UNDET:
            printf("%s", v->extra);
            break;
        default:
            printf("TYPE_UNKNOWN");
            break;
    }
}