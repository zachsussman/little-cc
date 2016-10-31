struct local {
    int x;
    int y;
};

int main(int argc) {
    struct local* q;
    q = malloc(sizeof(struct local));
    q->x = 10;
    q->y = 20;
    printf("%i\n", q->x + q->y);
}