#include <stdio.h>

void *malloc(size_t size);
void *calloc(size_t num_items, size_t size_of_elements);

int main(void)
{
    int * _20_ints = NULL;
    _20_ints = (int*)malloc(20 * sizeof(int));
    printf("Size of char: %zu bytes\n", sizeof(char));
    printf("Size of int: %zu bytes\n", sizeof(int));
    printf("%zu\n", sizeof(*_20_ints));

//    int * _20_ints = NULL;
    _20_ints = (int*)calloc(20, sizeof(int));
    printf("%zu\n", sizeof(*_20_ints));

    return 0;
}