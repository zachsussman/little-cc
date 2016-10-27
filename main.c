#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "util/queue.h"
#include "tokenizer/tokenize.h"
#include "parser/parser.h"
#include "parser/ast.h"
#include "parser/env.h"
#include "writer/driver.h"

#include "util/hash.h"

int main(int argc, char** argv) {

    queue* token_queue = queue_new();

    int ok = 0;
    FILE* f = fopen("test.asm", "w");
    write_header(f);
    env* E = env_new();
    printf("Allocated e'rything\n");

    while (ok == 0) {
        ok = parse_line(token_queue);
    }

    while (!queue_empty(token_queue)) {
        node* n = parse(token_queue);
        print_node(n);
        ast_write(f, n, E);
    }
    write_footer(f, E);
    fclose(f);
    return 0;
}