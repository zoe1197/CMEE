#include <stddef.h>
#include <stdlib.h>

typedef struct cvector {
    size_t nelems; // Number of elements
    size_t elemsz; // Size of each element
    void *data;
} cvector;

cvector* new_cvector(size_t nelems, size_t elemsize)
{
    cvector *newcv = NULL;

    newcv = calloc(1, sizeof(cvector));
    newcv->nelems = nelems;;
    newcv->elemsz = elemsize;

    newcv->data = calloc(nelems, elemsize)

    return newcv;
}

int main(void)
{
    
}
