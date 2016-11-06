# 1 "util/hash.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "util/hash.c" 2
# 1 "util/../diff.h" 1
# 17 "util/../diff.h"
typedef int bool;



typedef int size_t;


void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
void* fopen();
# 2 "util/hash.c" 2

# 1 "util/hash.h" 1



typedef struct hash_chain_s hash_chain;
struct hash_chain_s {
    char* key;
    void* value;
    hash_chain* next;
};

typedef struct hash_s hash;
struct hash_s {
    int size;
    int capacity;
    hash_chain** chains;
};


int hash_str(char *str);
hash* hash_new(int capacity);
bool hash_in(hash* H, char* k);
void hash_insert(hash* H, char* k, void* v);
void* hash_get(hash* H, char* k);
void hash_do_over(hash* H, void* info, void* f);
# 4 "util/hash.c" 2


int hash_str(char *str)
{
    int h = 5381;
    int c;

    while ((c = *(str++)))
        h = h * 33 + c;

    return h;
}

int key_index(hash* H, char* key) {
    0;

    int h = hash_str(key);
    if (h < 0) h = -h;
    return h - (h / H->capacity) * H->capacity;
}


bool are_chains_valid(hash* H) {
    int size = 0;
    for (int i = 0; i < H->capacity; i++) {
        hash_chain* c = H->chains[i];
        while (c != 0) {
            if (key_index(H, c->key) != i) {
                return 0;
            }
            c = c->next;
            size++;
        }
    }
    return size == H->size;
}

bool is_hash(hash* H) {
    return H != 0 && are_chains_valid(H);
}

hash* hash_new(int cap) {
    0;


    hash* H = malloc(sizeof(hash));
    0;
    H->size = 0;
    H->capacity = cap;
    H->chains = (hash_chain**) malloc(cap * sizeof(hash_chain*));
    for (int i = 0; i < cap; i++) H->chains[i] = 0;
    0;
    return H;
}

void hash_insert(hash* H, char* key, void* value) {
    0;

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != 0; c = c->next) {
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

    0;
}

bool hash_in(hash* H, char* key) {
    0;

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != 0; c = c->next) {
        if (strcmp(key, c->key) == 0) {
            0;
            return 1;
        }
    }

    0;
    return 0;
}



void* hash_get(hash* H, char* key) {
    0;

    int i = key_index(H, key);
    for (hash_chain* c = H->chains[i]; c != 0; c = c->next) {
        if (strcmp(key, c->key) == 0) {
            0;
            return c->value;
        }
    }

    0;
    return 0;
}
