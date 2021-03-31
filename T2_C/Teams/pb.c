/* pb.c
 *
 * This is the main file for the program I call pbits.
 * pbits is a program to take in any integer and print its
 * value to the console in binary.
 *
 * To compile this program, compile both files  
 * printbits.c and pblib.c as follows:
 *
 * gcc pb.c pblib.c -o pbits
 *
 * This will create an executable called pbits
 *
 * To USE the program, simply enter the following at the command prompt
 * where 'x' is the value of an integer you wish to print in binary:
 *
 *  ./pbits x
 *
 * For instance, the following example should run as:
 *
 *  ./pbits 21
 *  The binary representation of 21:
 *  00000000000000000000000000010101
 *
 * */

#include <stdio.h>
#include <stdlib.h>

void print_bits(const unsigned int b);

int main(int argc, char * argv[]) // Using command-line arguments
{
    /* 
     * Explanation of command-line arguments:
     * You can issue some arguments to your program
     * at the time of execution, simply by placing them
     * after the executable name when you run it. As explained
     * above, you enter the integer as your first user argument.
     *
     * Program arguments are stored in an array of strings: argv
     * (argument vector). And counted in argc (argument count).
     *
     * The first argument (argv[0]) is just the program name.
     *
     * */

    int a;
    
    // Need to check that the user passed some arguments. 
    // We only expect one user argument, so argc should be 2:
    if (argc != 2) {
        printf("ERROR: Incorrect number of arguments.\n");
        printf("Please supply an integer value\n");
        return 1; // Return an exit error to the OS.
    }

    a = atoi(argv[1]); // argv 1 is the first user argument
    
    printf("The binary representation of %i:\n", a);
    print_bits(a);
    return 0;
}
