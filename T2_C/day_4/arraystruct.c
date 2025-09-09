#include <stdio.h>
#include <stdlib.h>
#include "arraystruct.h"

void set_element(int indata, unsigned int index, int_array* a)
{
    if (index < a->nelems) {
        a->data[index] = indata;
    }
}

int get_element(unsigned int index, struct int_array* a)
{
    if (index < a->nelems) {
        return( a->data[index]);
    }
    printf("Attempt to read out of bounds!\n");
    exit(1); // Quits the program anywhere
}

void init_int_array(int_array*a, int nelems)
{
    a->nelems = nelems;
    a->data = malloc(nelems * sizeof(int));
    if (a->data == NULL) {
        printf("Error: unable to allocate memory for array\n");
    }
}

int length(int_array *a)
{
    return a->nelems;
}
