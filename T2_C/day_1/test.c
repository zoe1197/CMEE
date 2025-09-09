#include <stdio.h>

int main (void)
{
    int i = 0;
    char mystring[] = "A string printed character-by-character\n";
    
    while(mystring[i]) {
        printf("%c", mystring[i]);
	++i;
    }
    
    printf("\n");

    return 0;
}