#include <stdio.h>

int main(void)
{
    // Three types:
    // while...
    // do... while...
    // for...

    //While:
    int x = 0;
    while (x < 10) {
        //This code executes
        printf("x is still less than 10\n");
        ++x;
    }

    x = 0;
    do {
        printf("x is %i\n", x);
        x++;
    } while (x < 5);

    for ( x = 0; x < 10; ++x){
        printf("x is %i\n", x);
    }
}