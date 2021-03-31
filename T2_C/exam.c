#include <stdio.h>
#include <stdlib.h> // Preprocessor dirs on separate lines
int main(void)
struct node {
int index;
void *data;
struct node *next;
};