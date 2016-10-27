int factorial(int n) {
    if (n < 2) {
        printf("Base case: %i\n", n);
        return 1;
    }
    if (n >= 2) {
        printf("Recursive: %i\n", n);
        return n*factorial(n-1);
    }
}

int main() {
    printf("factorial(10): %i\n", factorial(10));
}