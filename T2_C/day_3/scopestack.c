#include <stdio.h>
#include <stdlib.h>

void index_through_array(int mynumbers[5], int* index)
{
    while (*index < 5) {
        printf("Element %i: %i\n", *index, mynumbers[*index]);
        mynumbers[*index] += *index;
        ++(*index);
    }
}


void printarray(int array[], int size)
{
    int i = 0;
    for (i = 0; i < size; ++i) {
        printf("%i ", array[i]);
    }
    printf("\n");
}

int main(void)
{
    int index =0;
    int mynums[] = {19, 81, 4, 8, 10};

    /// Pointers _type_ *variable name:
    int *ptr1 = NULL; // ptr1 is a pointer to integer
    int* ptr2 = NULL; // ptr2 is also a pointer to an integer

    int a,b;
    ptr1 = &a;
    ptr2 = &b;

    // Inderectly index through ptr1
    // Indirection operator: *
    ptr1; // A memory address
    *ptr1; // Gets the data at the address

    // Initialize a band b through a pointer
    *ptr1 = 4;
    *ptr2 = 5;
    printf("The sum of a and b is: %i\n", *ptr1 + *ptr2);

    ptr1 = &index;
    printf("Value of index before function call: %i\n", index);
    //printf("Element in mynums before function: ");
    //printarray(mynums, 5);
    index_through_array(mynums, ptr1); // Pass index to this function
    printf("Value of index after function call: %i\n", index);
    //printf("Element in mynums after function: ");
    //printarray(mynums, 5);

    return 0;
}