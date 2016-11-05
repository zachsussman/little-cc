#pragma once
#include "../diff.h"
#include "../parser/ast.h"
#include "../parser/env.h"

void write_header(FILE* f);
void ast_write(FILE* f, node* n, env* E);
void write_footer(FILE* f, env* E);