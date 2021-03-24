
// char: 00000000
//
// DNA 4 Bases: A,C,G,T.
//
// A: 0001
// C: 0010
// G: 0100
// T: 1000
//
// char sequence[].
//
// Let's say a 4-base sequence: AACG
// And another AT[TG]G
//
// This is pseudocode:
// char sequence1[] = {0001, 0001, 0010, 0100};
// char sequence2[] = {0001, 1000, 1100, 0100};


int main(void)
{
    char ldesc; // sp1
    char rdesc; // sp2
    char parent;

//    If there is an intersection between the state sets of sp1 and sp2:
//	        The preliminary set at d1 is the intersection of sp1 and sp2;
//    Else
//	        The preliminary set at d1 is the union of sp1 and sp2;

    if (ldesc & rdesc) {
        parent = ldesc & rdesc; // Same as set intersection
    } else {
        parent = ldesc | rdesc; // Set union
    }

}