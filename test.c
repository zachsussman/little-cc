{
    int x; int y; int z; int n;
    n = 10;
    x = 0;
    y = 1;
    while (n > 0) {
        z = y;
        y = y + x;
        x = z;
        n = n - 1;
    }
    printf("The 10th fibonacci number is: %i\n", y);
}