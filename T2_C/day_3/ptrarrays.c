#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    float mydata[] = {22.1, 32.55, 64.8, 12.0};
    float* fltptr = NULL;
    float* fltptr2 = NULL;
    float f = 25.6;

//    fltptr = &f; // This point to the float f

    fltptr = mydata; // This now points to mydata (i.e. first element of mydata)

//    *fltptr;

//    fltptr = &mydata[2];

//    *fltptr;

//    fltptr = mydata;

    printf("Check this out: %f\n", fltptr[1]);
    printf("Technically correct: %f\n", *(fltptr + 1));

    // Can assign between pointers
    fltptr2 = fltptr;

    int i;
    for (i = 0; i < 4; ++i) {
        printf("%f ", *fltptr2);
        fltptr2++;
    }

    // Looping with only pointer arithmetic
    printf("\n\n");
    fltptr2 = &mydata[3];
    for (fltptr = mydata; fltptr <= fltptr2; ++fltptr) {
        printf("%f ", *fltptr);
    }

    return 0;
}