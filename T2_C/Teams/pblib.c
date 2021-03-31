#include <stdio.h>
#define MAXBIT 32

void print_bits(const unsigned int b)
{
    int i;
    int x;

    for (i = MAXBIT-1; i >= 0; --i) {
        x = 0;
        x = (b & (1 << i));       
        if (x != 0) {
            printf("%i", 1);
        } else {
            printf("%i", 0);
        }
    }
    printf("\n");
}

