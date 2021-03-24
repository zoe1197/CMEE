#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    // This is a program to measure the number of bytes in
    // an integral type in c.

    long int ints[2];
    // Want this to look like so:
    // {0000...000, 11111...111};

    ints[0] = 0;
    ints[1] = ~0L;

    int nbytes;
    char *cptr;

    cptr = (char*)ints;

    while (cptr[nbytes] == 0){
        ++nbytes;
    }

    printf("Number of bytes in an integer: %i\n", nbytes);
    printf("Number of bits in an integer: %i\n", nbytes * 8);

    return 0;

}