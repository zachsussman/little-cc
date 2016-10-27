#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "hash.h"


int hash_str(char *str)
{
    int h = 5381;
    int c;

    while ((c = *str++))
        h = ((h << 5) + h) + c; /* hash * 33 + c */

    return h;
}

int key_index(hash* H, char* key) {
    assert(H != NULL);

    int i;
    i = hash_str(key) % H->capacity;

    return i < 0 ? -(i+1) : i;
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

    hash* H = malloc(sizeof(H));
    H->size = 0;
    H->capacity = cap;
    H->chains = calloc(sizeof(hash_chain*), cap);
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

void hash_do_over(hash* H, void* info, void (*f)(void*, char*, void*)) {
    assert(is_hash(H));

    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != NULL) {
            (*f)(info, c->key, c->value);
            c = c->next;
        }
    }

    assert(is_hash(H));
}
