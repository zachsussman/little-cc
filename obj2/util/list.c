# 1 "util/list.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "util/list.c" 2
# 1 "util/../diff.h" 1
# 20 "util/../diff.h"
typedef int bool;
typedef int long;



typedef int size_t;

void my_assert();

void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
void* fopen();
char* strndup();
int strtol();
char* strdup();
void fprintf(void* f, char* b);
void fclose(void* f);
# 2 "util/list.c" 2
# 1 "util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 3 "util/list.c" 2

bool is_segment(list* a, list* b) {
    if (a == 0) return 0;
    if (a == b) return 1;
    return is_segment(a->next, b);
}
