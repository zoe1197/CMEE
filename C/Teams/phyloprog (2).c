#include <stdio.h>

#include "tree.h"

int main(int argc, char* argv[])
{
    int ntax = 4;

    tree *t = NULL; // Always initialise a new pointer to NULL

    // Creates memory for a tree with ntax tips
    t = new_tree(ntax);

    // Let's manually link up a tree
    // Tree: ((1,2),(3,4));
    // 
    // Tree drawing:
    // 1:0  2:1  3:2  4:3
    //  \   /    \    /
    //   5:4      6:5
    //      \     /
    //        7:6
    //
    
    int anctable[] = {4, 4, 5, 5, 6, 6, -1};
    
    // I want a function to read an ancestor table
    // void read_anctable(tree *t, int *anctable);
    read_anctable(t, anctable);

    // Verify that something happened
    traverse(t->root);
    
    // deletes the tree memory
    delete_tree(t);
    t = NULL;

    return 0;
}

