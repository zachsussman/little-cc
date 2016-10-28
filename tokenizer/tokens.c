#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

#include "tokens.h"

bool is_token(token* T) {
    return T != NULL && T->repr != NULL;
}

token* token_new(token_type type, char* r) {
    token* T = malloc(sizeof(token));
    T->type = type;
    T->repr = r;

    assert(is_token(T));
    return T;
}

bool is_dynamic_token(token* T) {
    return T->type == NAME || T->type == NUMBER || T->type == STRING ||
            T->type == CHARACTER || T->type == OTHER;
}

void token_delete(token* T) {
    assert(is_token(T));
    if (is_dynamic_token(T)) free(T->repr);
    free(T);
}

char* str_token_type(token* T) {
    assert(is_token(T));

    switch(T->type) {
        case NAME:
            return "NAME";
            break;

        case NUMBER:
            return "NUMBER";
            break;

        case KW_INT:
            return "KW";
            break;

        case OTHER: 
            return "OTHER";
            break;

        default:
            return "SYMBOL";
            break;
    }
}