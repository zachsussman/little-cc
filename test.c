int printf();

typedef enum types_e types;
enum types_e {
    INT,
    VOID,
    CHAR,
    POINTER
};

int type_get_size(types t) {
    switch(t) {
        case INT:
        case VOID:
        case POINTER:
            return 8;
        case CHAR:
            return 1;
    }
}

int main() {
    printf("%d\n", type_get_size(INT));
}