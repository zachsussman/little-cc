#include "token_q.h"
#include <stdio.h>

bool is_segment_q(list* a, list* b) {
    if (a == NULL || b == NULL) return false;
    else if (a == b) return true;
    else return is_segment_q(a->next, b);
}


bool is_queue(queue* Q) {
    return Q != NULL && is_segment_q(Q->front, Q->back);
}

queue* queue_new() {
    queue* Q = malloc(sizeof(queue));
    Q->front = malloc(sizeof(list));
    Q->back = Q->front;
    Q->front->next = NULL;

    assert(is_queue(Q));
    return Q;
}

bool queue_empty(queue* Q) {
    assert(is_queue(Q));

    return Q->front == Q->back;
}

void enq(queue* Q, token* d) {
    assert(is_queue(Q));


    list* l = malloc(sizeof(list));

    assert(l != NULL);
    Q->back->data = (void*) d;
    Q->back->next = l;
    l->next = NULL;
    Q->back = l;
    assert(is_queue(Q));
}

token* peek(queue* Q) {
    assert(is_queue(Q));
    assert(!queue_empty(Q));

    return (token*)(Q->front->data);
}

token* deq(queue* Q) {
    assert(is_queue(Q));
    assert(!queue_empty(Q));

    token* d = (token*)(Q->front->data);
    Q->front = Q->front->next;

    assert(is_queue(Q));
    return d;
}
