#pragma once

#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "tokenizer/tokens.h"

/* typedef ___* list_data */
typedef token* list_data;
typedef struct list_entry list;
struct list_entry {
    list_data data;
    list* next;
};

typedef struct queue_s queue;
struct queue_s {
    list* front;
    list* back;
};

queue* queue_new();
bool queue_empty(queue* Q);
void enq(queue* Q, list_data d);
list_data deq(queue* Q);

void queue_test();