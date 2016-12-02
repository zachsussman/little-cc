#include "diff.h"

#include "util/queue.h"
#include "tokenizer/tokenize.h"
#include "parser/parser.h"
#include "parser/ast.h"
#include "parser/env.h"
#include "writer/driver.h"

#include "util/hash.h"

int main(int argc, char** argv) {
    queue* token_queue = queue_new();
    queue* node_queue = queue_new();

    int ok = 0;
    char* filename;
    if (argc > 1) filename = argv[1];
    else filename = "test.asm";
    FILE* f = fopen(filename, "w");
    env* E = env_new();

    while (ok == 0) {
        ok = parse_line(token_queue, stdin);
    }
    printf("Done tokenizing\n");

    while (!queue_empty(token_queue)) {
        node* n = parse(token_queue);
        enq(node_queue, n);
    }

    printf("Done parsing\n");
    write_header(f);

    while (!queue_empty(node_queue)) {
        node* n = (node*) deq(node_queue);
        if (DEBUGGING) print_node(n);
        ast_write(f, n, E);
    }

    write_footer(f, E);
    fclose(f);
    printf("Done writing\n");
    return 0;
}
