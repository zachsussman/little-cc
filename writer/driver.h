#pragma once
#include <stdlib.h>
#include <stdio.h>
#include "../parser/ast.h"

void ast_write(FILE* f, node* n);