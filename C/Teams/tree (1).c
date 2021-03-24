#include <stdlib.h>
#include <stdio.h>

#include "tree.h"

tree *new_tree(const unsigned int ntax)
{
    /* This is the allocator function for the 
     * tree structure. Requires as an argument the
     * intended number of terminals (i.e. number of
     * species the tree will hold*/
    int i = 0;
    tree *t = NULL;

    t = calloc(1, sizeof(tree));
    if (t == NULL) {
        printf("Insufficient memory for requested tree size\n");
        return NULL;
    }

    t->ntax = ntax;
    t->nnodes = 2 * ntax; // 2 * ntax - 1: nnodes in a rooted 
                          // binary tree. But I use a 'dummy' root
                          // so that adds one extra internal node
    t->trnodes = calloc(t->nnodes, sizeof(node));

    // Initialise the node data:
    for (i = 0; i < t->nnodes; ++i) {
        t->trnodes[i].index = i;
        if (i < t->ntax) {
            t->trnodes[i].tip = i + 1;
        } else {
            t->trnodes[i].tip = 0;
        }

        t->trnodes[i].left = NULL;
        t->trnodes[i].right = NULL;
        t->trnodes[i].anc = NULL;
    }

    if (t->trnodes == NULL) {
        printf("Insufficient memory for requested tree size\n");
        free(t);
        return NULL;
    }

    return t;
}

void delete_tree(tree *t)
{
    if (t->trnodes != NULL) {
        free(t->trnodes);
        t->trnodes = NULL;
    }

    free(t);
}

// If: current node is a tip:
//  return;
// Traverse the left node
// Traverse the right node
// return;
void traverse (node *p)
{

}

