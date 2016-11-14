# 1 "tokenizer/tokenize.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 329 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "tokenizer/tokenize.c" 2
# 1 "tokenizer/../diff.h" 1
# 20 "tokenizer/../diff.h"
typedef int bool;
typedef int long;



typedef int size_t;

void my_assert();

void exit(int a);
void printf(char* b);
void* malloc(int size);
void free(void* p);
void* calloc(int n, int size);
int strcmp(char* a, char* b);
int strncmp(char* a, char* b, int n);
void getline();
void* fopen();
char* strndup();
int strtol();
char* strdup();
void fprintf(void* f, char* b);
void fclose(void* f);
# 2 "tokenizer/tokenize.c" 2
# 1 "tokenizer/../token_q.h" 1



# 1 "tokenizer/../tokenizer/tokens.h" 1


enum token_type_e {
    NAME,
    NUMBER,
    STRING,
    CHARACTER,

    OPEN_BRACE,
    CLOSED_BRACE,

    SEMICOLON,

    OP_PLUS,
    OP_MINUS,
    OP_MUL,
    OP_DIV,
    OP_SINGLE_AND,
    OP_SINGLE_OR,
    OP_BOOL_AND,
    OP_BOOL_OR,
    OP_ASSIGN,
    OP_EQ,
    OP_NOT_BANG,
    OP_NOT_TILDE,
    OP_NEQ,

    OP_LT,
    OP_GT,
    OP_LTE,
    OP_GTE,
    OP_ARROW,
    OP_DOT,

    OP_INC,
    OP_DEC,

    OP_COLON,
    OP_QUESTION,

    OP_COMMA,

    OPEN_PAREN,
    CLOSED_PAREN,
    OPEN_BRACKET,
    CLOSED_BRACKET,

    KW_INT,
    KW_IF,
    KW_WHILE,
    KW_RETURN,
    KW_VOID,
    KW_ELSE,
    KW_STRUCT,
    KW_SIZEOF,
    KW_TYPEDEF,
    KW_CHAR,
    KW_FOR,
    KW_SWITCH,
    KW_CASE,
    KW_DEFAULT,
    KW_BREAK,
    KW_ENUM,

    OTHER
};
typedef enum token_type_e token_type;

typedef struct token_s token;
struct token_s {
    token_type type;
    char* repr;
};

token* token_new(token_type t, char* r);
void token_delete(token* t);
char* str_token_type(token* t);
# 5 "tokenizer/../token_q.h" 2
# 1 "tokenizer/../util/queue.h" 1




# 1 "tokenizer/../util/list.h" 1




typedef struct list_s list;
struct list_s {
    void* data;
    list* next;
};

bool is_segment(list* a, list* b);
# 6 "tokenizer/../util/queue.h" 2

typedef struct queue_s queue;
struct queue_s {
    list* front;
    list* back;
};

queue* queue_new();
bool queue_empty(queue* Q);
void enq(queue* Q, void* d);
void* peek(queue* Q);
void* deq(queue* Q);
queue* queue_readonly(queue* Q);
int queue_length(queue* Q);
void queue_free(queue* Q);

void queue_test();
# 6 "tokenizer/../token_q.h" 2

void token_enq(queue* Q, token* d);
token* token_peek(queue* Q);
token* token_deq(queue* Q);
# 3 "tokenizer/tokenize.c" 2

# 1 "tokenizer/../vars.h" 1
# 5 "tokenizer/tokenize.c" 2

# 1 "tokenizer/tokenize.h" 1






int parse_line(queue* Q, void* f);
# 7 "tokenizer/tokenize.c" 2

bool is_whitespace(char c) {
    return c == ' ' || c == '\t' || c == '\n';
}

bool is_char_in_range(char c, char bottom, char top) {
    return bottom <= c && c <= top;
}

bool is_beginning_name_char(char c) {
    return ('_' == c)
        || is_char_in_range(c, 'a', 'z')
        || is_char_in_range(c, 'A', 'Z');
}

bool is_number_char(char c) {
    return is_char_in_range(c, '0', '9');
}

bool is_name_char(char c) {
    return is_beginning_name_char(c) || is_number_char(c);
}

void inspect_for_keywords(queue* Q) {
    my_assert("tokenizer/tokenize.c", 31, "!queue_empty(Q)", !queue_empty(Q));

    token* tok = peek(Q);
    if (tok->type != NAME) {
        return;
    }

}
# 60 "tokenizer/tokenize.c"
void parse_number(queue* Q, char** pline) {
    int len = 0;

    while(len < 80
            && (*pline)[len] != 0
            && is_number_char((*pline)[len])) {
        len++;
    }

    char* repr = calloc(len+1, sizeof(char));
    for (int i = 0; i < len && **pline != 0 && is_number_char(**pline); i++) {
        repr[i] = **pline;
        (*pline)++;
    }
    repr[len] = '\0';

    token* tok = token_new(NUMBER, repr);
    enq(Q, tok);
}


void parse_name(queue* Q, char** pline) {
    int len = 0;

    while(len < 80
            && (*pline)[len] != 0
            && is_name_char((*pline)[len])) {
        len++;
    }


    char* repr = calloc(len+1, sizeof(char));
    for (int i = 0; i < len && **pline != 0 && is_name_char(**pline); i++) {
        repr[i] = **pline;
        (*pline)++;
    }
    repr[len] = 0;


    if (!strncmp(repr, "int", 4)) {
        free(repr);
        enq(Q, token_new(KW_INT, "int"));
        return;
    }

    if (!strcmp(repr, "if")) {
        free(repr);
        enq(Q, token_new(KW_IF, "if"));
    } else if (!strcmp(repr, "while")) {
        free(repr);
        enq(Q, token_new(KW_WHILE, "while"));
    } else if (!strcmp(repr, "return")) {
        free(repr);
        enq(Q, token_new(KW_RETURN, "return"));
    } else if (!strcmp(repr, "void")) {
        free(repr);
        enq(Q, token_new(KW_VOID, "void"));
    } else if (!strcmp(repr, "else")) {
        free(repr);
        enq(Q, token_new(KW_ELSE, "else"));
    } else if (!strcmp(repr, "struct")) {
        free(repr);
        enq(Q, token_new(KW_STRUCT, "struct"));
    } else if (!strcmp(repr, "sizeof")) {
        free(repr);
        enq(Q, token_new(KW_SIZEOF, "sizeof"));
    } else if (!strcmp(repr, "typedef")) {
        free(repr);
        enq(Q, token_new(KW_TYPEDEF, "typedef"));
    } else if (!strcmp(repr, "for")) {
        free(repr);
        enq(Q, token_new(KW_FOR, "for"));
    } else if (!strcmp(repr, "switch")) {
        free(repr);
        enq(Q, token_new(KW_SWITCH, "switch"));
    } else if (!strcmp(repr, "case")) {
        free(repr);
        enq(Q, token_new(KW_CASE, "case"));
    } else if (!strcmp(repr, "default")) {
        free(repr);
        enq(Q, token_new(KW_DEFAULT, "default"));
    } else if (!strcmp(repr, "break")) {
        free(repr);
        enq(Q, token_new(KW_BREAK, "break"));
    } else if (!strcmp(repr, "char")) {
        free(repr);
        enq(Q, token_new(KW_CHAR, "char"));
    } else if (!strcmp(repr, "enum")) {
        free(repr);
        enq(Q, token_new(KW_ENUM, "enum"));
    }
    else {
        token* tok = token_new(NAME, repr);
        enq(Q, tok);
    }
}

char parse_string_advance(char** pline) {
    char c = 0;
    if (**pline == '\\') {
        (*pline)++;
        if (**pline == 'n') {
            c = '\n';
        } else if (**pline == 't') {
            c = '\t';
        } else if (**pline == '0') {
            c = '\0';
        } else {
            c = **pline;
        }
    } else {
        c = **pline;
    }
    (*pline)++;
    return c;
}

void parse_string(queue* Q, char** pline) {
    int len = 0;

    char* temp_p = *pline;

    parse_string_advance(&temp_p);

    while(*temp_p != 0 && *temp_p != '"') {

        len++;
        parse_string_advance(&temp_p);
    }



    parse_string_advance(pline);

    char* repr = calloc(len+1, sizeof(char));
    for (int i = 0; i < len && **pline != 0 && **pline != '"'; i++) {
        repr[i] = parse_string_advance(pline);
    }
    repr[len] = '\0';

    parse_string_advance(pline);

    token* tok = token_new(STRING, repr);
    enq(Q, tok);

}

void parse_character(queue* Q, char** pline) {
    parse_string_advance(pline);

    char c = parse_string_advance(pline);
    parse_string_advance(pline);

    char* repr = malloc(sizeof(char)*2);
    repr[0] = c;
    repr[1] = '\0';

    token* tok = token_new(CHARACTER, repr);
    enq(Q, tok);

}

void parse_symbol(queue* Q, char** pline) {
    token_type type;
    char* repr;
    switch((char) **pline) {
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
        case '(':
            type = OPEN_PAREN;
            repr = "(";
            break;
        case ')':
            type = CLOSED_PAREN;
            repr = ")";
            break;
        case ',':
            type = OP_COMMA;
            repr = ",";
            break;
        case '[':
            type = OPEN_BRACKET;
            repr = "[";
            break;
        case ']':
            type = CLOSED_BRACKET;
            repr = "]";
            break;
        case ':':
            type = OP_COLON;
            repr = ":";
            break;
        case '?':
            type = OP_QUESTION;
            repr = "?";
            break;
        case '+':
            if ((*pline)[1] == '+') {
                type = OP_INC;
                repr = "++";
                (*pline)++;
            }
            else {
                type = OP_PLUS;
                repr = "+";
            }
            break;
        case '-':
            if ((*pline)[1] == '>') {
                type = OP_ARROW;
                repr = "->";
                (*pline)++;
            } else if ((*pline)[1] == '-') {
                type = OP_DEC;
                repr = "--";
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
                type = OP_EQ;
                repr = "==";
                (*pline)++;
            }
            else {
                type = OP_ASSIGN;
                repr = "=";
            }
            break;
        case '>':
            if ((*pline)[1] == '=') {
                type = OP_GTE;
                repr = ">=";
                (*pline)++;
            }
            else {
                type = OP_GT;
                repr = ">";
            }
            break;
        case '<':
            if ((*pline)[1] == '=') {
                type = OP_LTE;
                repr = "<=";
                (*pline)++;
            }
            else {
                type = OP_LT;
                repr = "<";
            }
            break;
        case '!':
            if ((*pline)[1] == '=') {
                type = OP_NEQ;
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
            *repr = **pline;
            type = OTHER;
    }

    (*pline)++;
    token* tok = token_new(type, repr);
    enq(Q, tok);
}

void skip_whitespace(char** pline) {

    while (is_whitespace(**pline)){
        (*pline)++;
    }
}

bool next_token(queue* Q, char** pline) {
    skip_whitespace(pline);
    if (**pline == 0) return 1;
    if (**pline == '/' && *(*pline+1) == '/') return 1;
    if (**pline == '#') return 1;

    char c = **pline;
    if (is_beginning_name_char(c)) parse_name(Q, pline);
    else if (is_number_char(c)) parse_number(Q, pline);
    else if (c == '"') parse_string(Q, pline);
    else if (c == '\'') parse_character(Q, pline);
    else parse_symbol(Q, pline);
    return 0;
}

int parse_line(queue* Q, void* f) {
    size_t n;
    char* buf = 0;
    int read = getline(&buf, &n, f);
    if (-1 == read) return -1;


    char* line = buf;
    while (!next_token(Q, &line)) {
    }
    free(buf); line = 0; buf = 0;

    return 0;
}
