#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    float        fpi  = 3.14159265358979323846264338327950288419716939937510;
    double       dpi  = 3.14159265358979323846264338327950288419716939937510;
    long double  ldpi = 3.14159265358979323846264338327950288419716939937510;

    printf("Pi                      3.14159265358979323846264338327950288419716939937510\n");
    printf("Pi as float:            %.50f\n", fpi);
    printf("Pi as double:           %.50f\n", dpi);
    printf("Pi as long double:      %.50Lf\n", ldpi);

    printf("Size of float on this system: %lU bytes\n", sizeof(float));
    printf("Size of double on this system: %lU bytes\n", sizeof(double));
    printf("Size of long double on this system: %lU bytes\n", sizeof(long double));

    return 0;
}