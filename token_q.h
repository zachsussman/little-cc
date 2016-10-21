#pragma once

#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "tokenizer/tokens.h"
#include "util/list.h"

typedef struct queue_s queue;
struct queue_s {
    list* front;
    list* back;
};

queue* queue_new();
bool queue_empty(queue* Q);
void enq(queue* Q, token* d);
token* peek(queue* Q);
token* deq(queue* Q);

void queue_test();