#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "token_q.h"
#include "tokenizer/tokenize.h"


int main(int argc, char** argv) {
    printf("Hello, world!\n");

    queue* token_queue = queue_new();

    int ok = 0;
    while (ok == 0) {
        ok = parse_line(token_queue);

        while (!queue_empty(token_queue)) {
            token* tok = deq(token_queue);
            printf("%s %s\n", str_token_type(tok), tok->repr);
            token_delete(tok);
        }
        printf("\n");
    }
    return 0;
}