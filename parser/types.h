#pragma once

typedef enum lang_type_e lang_type;
enum lang_type_e {
    LANG_INT,
    LANG_VOID,
    LANG_POINTER,
    LANG_FN
};

typedef struct var_type_s var_type;
struct var_type_s {
    lang_type base;
    void* extra;
};

typedef struct t_fn_extra_s t_fn_extra;
struct t_fn_extra_s {
    var_type* ret;
    queue* args;
};


var_type* type_new_base(lang_type t);
var_type* type_new_pointer(var_type* t);
var_type* type_new_fn(var_type* ret);