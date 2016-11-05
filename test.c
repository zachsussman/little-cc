struct token_s {
    int type;
};
typedef struct token_s token;

token* token_new(int t) {
    token* T;
    T->type = t;
}