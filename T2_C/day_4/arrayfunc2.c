#include <stdio.h>
#include <stdlib.h>

// The bad way
/*int* get_intarray(int size)
{
    int intarray[size];
    int i;

    return intarray;
}*/

/*The good way*/
// void* malloc(size_t s);
// void* calloc(size_t nelems, size_t size);
int *get_intarray(int nelemes)
{
    int *ret = NULL;

//    ret = malloc(nelemes * sizeof(int));
//    free(ret); // Avoid memory bug
    ret = calloc(nelemes, sizeof(int)); // A bit slower but runs
    if (ret == NULL) {
        printf("Warning: insufficient memory for operation!\n");
    }

    return ret;
}

void* safe_malloc(const size_t size)
{
    void *ret = NULL;

    ret = malloc(size);
    if (ret == NULL) {
        printf("Insufficient memory for operation!\n");
//        exit(1); // Quits program.
    }

    return ret;
}

void safe_free(void **p)
{
    if (*p != NULL) {
        free(*p);
        *p = NULL;
    }
}

int main(void)
{
    int size = 20;
    int* intarray = NULL;

//    intarray = get_intarray(size);
    intarray = safe_malloc(size * sizeof(int));

    int i = 0;
    for (i = 0; i < size; ++i) {
        intarray[i] = i;
    //    printf("%i \n", intarray[i]);
    }

    for (i = 0; i < size; ++i) {
        printf("%i \n", intarray[i]);
    }

    safe_free((void**)&intarray);
    intarray = NULL; // remove the pointer

    return 0;
}