#include "token_q.h"
#include "tokenizer/tokens.h"
#include "util/queue.h"
#include <stdio.h>

void token_enq(queue* Q, token* t) {
    enq(Q, (void*) t);
}

token* token_deq(queue* Q) {
    token* t = (token*) deq(Q);
    printf("%s %i ", t->repr, t->type);
    return t;
}

token* token_peek(queue* Q) {
    return (token*) peek(Q);
}