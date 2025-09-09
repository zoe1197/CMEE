#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    bool overlap = false;
    bool site1[] = {true, true, true, false, true};
    bool site2[] = {false, true, true, false, true};
    bool siteol[5];

    unsigned char site1pk;
    unsigned char site2pk;

    int i = 0;
    for (i = 0; i < 5; ++i){
        if (site1[i] == true && site2[i] == true){
            siteol[i] = true;
            overlap = true;
        } else {
            siteol[i] = false;
        }
        
    }

    // site1pk & site2pk
    // Would accomplish the same in bitwise operations
    // site1: 11101
    // site2: 01101

    site1pk = 0;

    for (i = 0; i < 5; ++i) {
        if (site1[i] == true) {
//            site1pk = site1pk | (1 << i);
            site1pk |= (1 << i);
        }
    }
    printf("Numerical value of site1pk: %i\n", (int)site1pk);

    return 0;
}