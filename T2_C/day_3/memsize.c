#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // This is a program to measure the number of bytes in
    // any integral type in c.

    long int ints[2];
    // Want this to look like so:
    // {0000...000, 11111...111};

    ints[0] = 0;
    ints[1] = -1;

    int nbytes;
    char* cptr;

    cptr = (char*)ints;

    cptr[0];
    cptr[1];

    printf("%i\n", cptr[0]);
    printf("%i\n", cptr[1]);

    while (cptr[nbytes] == 0) {
        ++nbytes;
    }
    
    printf("Number of bytes in a long integer: %i\n", nbytes);

    return 0;
}