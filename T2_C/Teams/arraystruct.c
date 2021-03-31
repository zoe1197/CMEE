#include <stdio.h>
#include <stdlib.h>

struct int_array {
    int  nelems;
    int* data;
};

typedef struct int_array int_array;

void set_element(int indata, int index, struct int_array* a)
{
    if (index < a->nelems) {
        a->data[index] = indata;
    }
}

int get_element(int index, struct int_array* a)
{
}

int length(int_array *a)
{
    return a->nelems;
}

void init_int_array(int_array *a, int nelems)
{
    a->nelems = nelems;
    a->data = malloc(nelems * sizeof(int));
    if (a->data == NULL) {
        printf("Error: unable to allocate memory for array\n");
    }
}

int main(void)
{
    int nints = 5;
    int someints[20];
    int_array ints;
    init_int_array(&ints, nints);

    set_element(5, 0, ints);
    // analogous to: someints[0] = 5

    length(ints);

    return 0;
}
