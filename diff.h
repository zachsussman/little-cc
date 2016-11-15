#pragma once

#ifndef MY_CC

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#define mark(...) 0
#define mamark(...)  (printf("%s:%d \t", __FILE__, __LINE__) && (printf(__VA_ARGS__)+1) && printf("\n"))

#define DEBUGGING false

#else

#define assert(c) my_assert(__FILE__, __LINE__, #c, c)
#define FILE void
typedef int bool;
typedef int long;
#define NULL 0
#define false 0
#define true 1
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
FILE* fopen();
char* strndup();
int strtol();
char* strdup();
void fprintf(FILE* f, char* b);
void fclose(FILE* f);

// #define mark(...) (printf("%s:%d \t", __FILE__, __LINE__) && (printf(__VA_ARGS__)+1) && printf("\n"))
#define mark(...) 0
#define DEBUGGING false
#endif

