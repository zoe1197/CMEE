#include <stdio.h>

char base_transfer(char base);

int main(void)
{
    char DNA[] = "CATAAACCCTGGCGC";
    
    int i = 0;
    for (i = 0; i < 15; ++i) {
        printf("%i", base_transfer(DNA[i]));
    }
    printf("\n");
    
    return 0;
}