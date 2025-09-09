#include <stdio.h>

int main(void)
{
    int x = 0;
    int y = 0;
    int z = 0;

    x = x + 1;

    ++x;//Prefix increment
    // At this point x will be 1;
    x++;//Postfix increment
    // At this point x is 2;

    x = 0;
    y = ++x;// Incrementx, then evaluate x
    x = 0;
    z = x++;// Evaluate x, then increment

    printf("value of y: %i\n", y);
    printf("value of z: %i\n", z);
    printf("value of x: %i\n", x);

    // Decrement operators:
    x--;
    --x;

    // Self assignment:
    x = x + x;
    x += x;
    x += y; // x = x + y;

    return 0;
}