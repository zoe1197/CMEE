#ifndef _ARRAYSTRUCT_H_
#define _ARRAYSTRUCT_H_

struct int_array {
    int nelems;
    int *data;
};

typedef struct int_array int_array;

void init_int_array(int_array *a, int nelems);
int  length(int_array *a);
int  get_element(unsigned int index, struct int_array* a);
void set_element(int indata, unsigned int index, struct int_array* a);
void init_int_array(int_array *a, int nelems);
#endif
