#pragma once

#ifndef MY_CC

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#define mark(...) 0

#else

#define assert(e) 0
#define FILE void
typedef int bool;
#define NULL 0
#define false 0
#define true 1
typedef int size_t;
#define stdin 0

void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
FILE* fopen();

#define mark(...) printf(__VA_ARGS__)

#endif

#define DEBUGGING false