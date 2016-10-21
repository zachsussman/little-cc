#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "../token_q.h"
#include "tokens.h"
#include "../vars.h"

#include "tokenize.h"

typedef bool classifier(char c);


bool is_whitespace(char c) {
    return c == ' ' || c == '\t' || c == '\n';
}

bool is_char_in_range(char c, char bottom, char top) {
    return bottom <= c && c <= top;
}

bool is_beginning_name_char(char c) {
    return ('_' == c) 
        || is_char_in_range(c, 'a', 'z')
        || is_char_in_range(c, 'A', 'Z')
        || is_char_in_range(c, '0', '9');
}

bool is_number_char(char c) {
    return is_char_in_range(c, '0', '9');
}

bool is_name_char(char c) {
    return is_beginning_name_char(c) || is_number_char(c);
}



void parse_long(queue* Q, char** pline, token_type type, classifier* f) {
    int len = 0;
    // Find the length of the token by scanning 
    while(len < MAX_TOKEN_LENGTH 
            && (*pline)[len] != 0
            && (*f)((*pline)[len])) {
        len++;
    }

    char* repr = calloc(len, sizeof(char));
    for (int i = 0; i < len && **pline != 0 && (*f)(**pline); i++) {
        repr[i] = **pline;
        (*pline)++;
    }

    token* tok = token_new(type, repr);
    enq(Q, tok);
}

void parse_name(queue* Q, char** pline) {
    parse_long(Q, pline, NAME, &is_name_char);
}

void parse_number(queue* Q, char** pline) {
    parse_long(Q, pline, NUMBER, &is_number_char);
}

void parse_symbol(queue* Q, char** pline) {
    token_type type;
    char* repr;
    switch(**pline) {
        case '+':
            type = OP_PLUS;
            repr = "+";
            break;
        case '*':
            type = OP_MUL;
            repr = "*";
            break;
        case '/':
            type = OP_DIV;
            repr = "/";
            break;
        case '{':
            type = OPEN_BRACE;
            repr = "{";
            break;
        case '}':
            type = CLOSED_BRACE;
            repr = "}";
            break;
        case ';':
            type = SEMICOLON;
            repr = ";";
            break;
        case '.':
            type = OP_DOT;
            repr = ".";
            break;
        case '-':
            if ((*pline)[1] == '>') {
                type = OP_ARROW;
                repr = "->";
                (*pline)++;
            }
            else {
                type = OP_MINUS;
                repr = "-";
            }
            break;
        case '&':
            if ((*pline)[1] == '&') {
                type = OP_BOOL_AND;
                repr = "&&";
                (*pline)++;
            }
            else {
                type = OP_SINGLE_AND;
                repr = "&";
            }
            break;
        case '|':
            if ((*pline)[1] == '|') {
                type = OP_BOOL_OR;
                repr = "||";
                (*pline)++;
            }
            else {
                type = OP_SINGLE_OR;
                repr = "|";
            }
            break;
        case '=':
            if ((*pline)[1] == '=') {
                type = OP_EQUALS;
                repr = "==";
                (*pline)++;
            }
            else {
                type = OP_ASSIGN;
                repr = "=";
            }
            break;
        case '!':
            if ((*pline)[1] == '=') {
                type = OP_NOT_EQUALS;
                repr = "!=";
                (*pline)++;
            }
            else {
                type = OP_NOT_BANG;
                repr = "!";
            }
            break;
        default:
            repr = calloc(sizeof(char), 2);
            repr[0] = **pline;
            type = OTHER;
    }

    (*pline)++;
    token* tok = token_new(type, repr);
    enq(Q, tok);
}

void skip_whitespace(char** pline) {
    while (is_whitespace(**pline)) (*pline)++;
}

bool next_token(queue* Q, char** pline) {
    skip_whitespace(pline);
    if (**pline == 0) return true;

    char c = **pline;
    if (is_beginning_name_char(c)) parse_name(Q, pline);
    else if (is_number_char(c)) parse_number(Q, pline);
    else parse_symbol(Q, pline);
    return false;
}

int parse_line(queue* Q) {
    size_t n;
    char* buf = NULL;
    int read = getline(&buf, &n, stdin);
    if (-1 == read) return -1;

    char* line = buf;
    while (!next_token(Q, &line));
    free(buf); line = NULL; buf = NULL;

    return 0;
}