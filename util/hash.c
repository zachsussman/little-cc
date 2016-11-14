#include "../diff.h"

#include "hash.h"


long hash_str(char *str)
{
    long h = 5381;
    int c;
    int i = 0;

    for (int i = 0; str[i] != 0; i++) {
        c = str[i];
        h = h * 33 + c; /* hash * 33 + c */
    }

    return h;
}

int key_index(hash* H, char* key) {
    assert(H != NULL);

    long h = hash_str(key);
    if (h < 0) h = -h;
    return h - (h / H->capacity) * H->capacity;
}


bool are_chains_valid(hash* H) {
    int size = 0;
    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != NULL) {
            if (key_index(H, c->key) != i) {
                return false;
            }
            c = c->next;
            size++;
        }
    }
    return size == H->size;
}

bool is_hash(hash* H) { 
    return H != NULL && are_chains_valid(H);
}

hash* hash_new(int cap) {
    assert(cap > 0);


    hash* H = malloc(sizeof(hash));
    assert(H != NULL);
    H->size = 0;
    H->capacity = cap;
    H->chains = (hash_chain**) malloc(cap * sizeof(hash_chain*));
    for (int i = 0; i < cap; i++) H->chains[i] = NULL;
    assert(is_hash(H));
    return H;
}

void hash_insert(hash* H, char* key, void* value) {
    assert(is_hash(H));

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != NULL; c = c->next) {
        if (strcmp(key, c->key) == 0) {
            c->value = value;
            return;
        }
    }

    hash_chain* c = malloc(sizeof(hash_chain));
    c->key = key;
    c->value = value;
    c->next = H->chains[i];
    H->chains[i] = c;

    H->size++;

    assert(is_hash(H));
}

bool hash_in(hash* H, char* key) {
    assert(is_hash(H));

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != NULL; c = c->next) {
        if (strcmp(key, c->key) == 0) {
            assert(is_hash(H));
            return true;
        }
    }

    assert(is_hash(H));
    return false;
}



void* hash_get(hash* H, char* key) {
    assert(is_hash(H));

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != NULL; c = c->next) {
        if (strcmp(key, c->key) == 0) {
            assert(is_hash(H));
            return c->value;
        }
    }

    assert(is_hash(H));
    return NULL;
}

#ifndef MY_CC
typedef void foo(void*, void*, void*);

void hash_do_over(hash* H, void* info, void* f) {
    assert(is_hash(H));

    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != NULL) {
            (*((foo*)f))(info, c->key, c->value);
            c = c->next;
        }
    }

    assert(is_hash(H));
}

#endif
