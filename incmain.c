#include "diff.h"

#include "util/queue.h"
#include "tokenizer/tokenize.h"
#include "parser/parser.h"
#include "parser/ast.h"
#include "parser/env.h"
#include "writer/driver.h"

#include "util/hash.h"

int main(int argc, char** argv);

void test_hashes() {
    mark("Let's run regression tests");
    hash* test_hash = hash_new(30);
    mark("Hash initialized");
    hash_insert(test_hash, "a", "apples");
    mark("Inserted apples");
    hash_insert(test_hash, "b", "baseballs");
    printf("%s\n", hash_get(test_hash, "apples"));
    mark("Apples searched");
    printf("%s\n", hash_get(test_hash, "baseballs"));
    printf("%d\n", hash_get(test_hash, "candy"));
    mark("Candy searched");
}

int main(int argc, char** argv) {
    // test_hashes();
    mark("Let's begin.");
    test_hashes();

    queue* token_queue = queue_new();

    int ok = 0;
    // char* filename;
    // if (argc > 1) filename = argv[1];
    // else filename = "test.asm";
    // FILE* f = fopen(filename, "w");
    // write_header(f);
    // env* E = env_new();

    char* filename;
    if (argc > 1) filename = argv[1];
    else filename = "obj/main.c";
    char* outfilename;
    if (argc > 2) outfilename = argv[2];
    else outfilename = "test.asm";

    FILE* f = fopen(filename, "r");
    if (f == NULL) {
        printf("File not found\n");
        exit(1);
    }

    FILE* out = fopen(outfilename, "w");
    write_header(out);
    env* E = env_new();





    while (ok == 0) {
        ok = parse_line(token_queue, f);
    }

    mark("All tokens parsed");

    while (!queue_empty(token_queue)) {
            node* n = parse(token_queue);
            print_node(n);
            ast_write(out, n, E);
    }


    write_footer(out, E);
    fclose(out);

    mark("End of incmain\n");
    return 0;
}