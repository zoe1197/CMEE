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
    // 1  2  3  4
    //  \/    \/
    //   5    6
    //    \  /
    //      7
    //
    
    // Let's set up the root first:
    t->trnodes[t->ntax].left = &t->trnodes[t->ntax+1];
    // Equivalently:
//    (*((*t).trnodes + t->ntax)).left = t->trnodes + t->ntax + 1;
    // Set up ancestor pointer here
    t->trnodes[t->ntax].right = &t->trnodes[t->ntax+2];
    // Set up ancestor pointer here
    t->trnodes[t->ntax+1].left = &t->trnodes[0]; // Point to tip 1 
    // Set up ancestor pointer here
    t->trnodes[t->ntax+1].right = &t->trnodes[1]; // Point to tip2
    // Set up ancestor pointer here
    t->trnodes[t->ntax+2].left = &t->trnodes[2]; // Point to tip 3
    // Set up ancestor pointer here
    t->trnodes[t->ntax+2].right = &t->trnodes[3]; // Point to tip 4

    // Initialise root pointer
    t->root = &t->trnodes[t->ntax];

    traverse(t->root);
    
    // deletes the tree memory
    delete_tree(t);
    t = NULL;

    return 0;
}

