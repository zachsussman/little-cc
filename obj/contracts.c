# 1 "contracts.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "contracts.c" 2
# 1 "./diff.h" 1
# 20 "./diff.h"
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
# 2 "contracts.c" 2

void my_assert(char* file, int line, char* cond, bool c) {
    if (!c) {
        printf("%s:%d assertion failed: %s\n", file, line, cond);
        exit(1);
    }
}
