#include <stdio.h>

int main(void)
{
    int a = 1;
    int b = 2;
    int c = 0;

    c = 1 + 4;
    c = a + b;
    c = a + 4;

    printf("The variable c is: %i\n", c);

    c = a / b;

    float f = 0.0;
    f = a / b;

    printf("The variable c is: %i\n", c);
    printf("The variable c stored as float: %f\n", f);

    f = 1.0 / 2.0;
    printf("The variable c stored as float: %f\n", f);

    f = a / 2.0;
    printf("The variable c stored as float: %f\n", f);

    // Type-casting (type) varname
    f = (float)a / (float)b;
    printf("The variable c stored as float: %f\n", f);

    return 0;
}