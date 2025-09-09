#include <stdio.h>
#include <stdlib.h>

int* get_intarray(int size)
{
    int intarray[size];
    int i = 0;

    for (i = 0; i < size; ++i) {
        intarray[i] = i;
    }

    return intarray;
}

int main(void)
{
    int size = 5;
    int* intarray = NULL;

    intarray = get_intarray(size);

    int i = 0;
    for (i = 0; i < size; ++i) {
        intarray[i] = i;
    }

    for (i = 0; i < size; ++i) {
        printf("%i \n", intarray[i]);
    }

    return 0;
}