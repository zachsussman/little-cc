#pragma once

#include "ast.h"
#include "../token_q.h"

node* parse_statement(queue* Q);
node* parse_expr(queue* Q);
node* parse(queue* Q);