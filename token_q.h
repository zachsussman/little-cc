#pragma once

#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include "tokenizer/tokens.h"
#include "util/queue.h"

void token_enq(queue* Q, token* d);
token* token_peek(queue* Q);
token* token_deq(queue* Q);
