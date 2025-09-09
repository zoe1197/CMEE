#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
//    char astr1[] = "This is a string";
//    char* astr2 = "This is also a string";

    char* placenames[] = {"Parking lot", "Cricket lawn", "The Reactor"};

    printf("I've played croquet on the: %s\n", placenames[1]);
    printf("I've played croquet on the: %s\n", *(placenames + 1));

    return 0;
}