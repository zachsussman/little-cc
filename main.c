#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "token_q.h"
#include "tokenizer/tokenize.h"
#include "parser/parser.h"
#include "parser/ast.h"
#include "writer/driver.h"


int main(int argc, char** argv) {

    queue* token_queue = queue_new();

    int ok = 0;
    while (ok == 0) {
        ok = parse_line(token_queue);

        while (!queue_empty(token_queue)) {
            ast_write(stdout, parse(token_queue));
            printf("\n");
        }
    }
    return 0;
}