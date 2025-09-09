#include <stdio.h>

int main(void)
{
    int x = 0;
    int y = 1;
    // If... statement
    if (x){
        printf("Yes, 1\n");
        printf("Will this line print?\n");
    } else{
        printf("x must must be 0\n");
    }

    if (x == y) {
        printf("x and y are equal\n");
    }

    if (x != y) {
        printf("x and y are unequal\n");
    }

    if (x && y) {
        printf("Yes to x AND y!\n");
    }

    if (x || y) {
        printf("Yes to x OR y!\n");
    }


    return 0;
}