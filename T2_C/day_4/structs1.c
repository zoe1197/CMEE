#include <stdio.h>
#include <stdlib.h>

struct site_data {
    float latitude;
    float longitude;
    float elevation;
    char** species;
    int    nspecies;
    int*   sppcounts;
};

// typedef __datatype__ __alias__
typedef struct site_data site_data;
//typedef char dna_t; // A typedef to store DNA data

int main(void)
{
    site_data s1;
    site_data s2;

    site_data sites[20];
    site_data *sites_ptr = NULL;

    site_ptr = malloc(20 * sizeof(site_data));

    s1.latitude = 75.2221;
    s2.longitude = -1.0001;

    s2.longitude = s2.longitude + 2.0;
}