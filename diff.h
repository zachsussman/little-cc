#ifndef MY_CC

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#else

#define assert(e) 0
#define FILE void
typedef int bool;
#define NULL 0

#endif