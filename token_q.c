#include "token_q.h"
#include <stdio.h>

bool is_segment(list* a, list* b) {
    if (a == NULL || b == NULL) return false;
    else if (a == b) return true;
    else return is_segment(a->next, b);
}


bool is_queue(queue* Q) {
    return Q != NULL && is_segment(Q->front, Q->back);
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

void enq(queue* Q, list_data d) {
    assert(is_queue(Q));


    list* l = malloc(sizeof(list));

    assert(l != NULL);
    Q->back->data = d;
    Q->back->next = l;
    l->next = NULL;
    Q->back = l;
    assert(is_queue(Q));
}

list_data deq(queue* Q) {
    assert(is_queue(Q));
    assert(!queue_empty(Q));

    list_data d = Q->front->data;
    Q->front = Q->front->next;

    assert(is_queue(Q));
    return d;
}
