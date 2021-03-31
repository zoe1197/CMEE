#include <stdio.h>
#include "arraystruct.h"

int main(void)
{
    int nints = 5;
    int someints[5];
    int_array ints;
    init_int_array(&ints, nints);

    set_element(5, 0, &ints);
    // analogous to: someints[0] = 5
    
    int i;
    for (i = 0; i < 10; ++i) {
        printf("Element %i: %i\n", i, someints[i]);
    }
    for (i = 0; i < 10; ++i) {
        printf("Element %i: %i\n", i, get_element(i, &ints));
    }

    return 0;
}
