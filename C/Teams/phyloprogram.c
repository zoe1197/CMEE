#include <stdio.h>

#include "tree.h"
// will need to include "tree.c" when compile: gcc phyloprogram.c tree.c


// This program uses tree.c and tree.h to create and manipulate phylogenetic tree

int main (int argc, char* argv[]) {

  int ntax = 4;
  tree* t = NULL; // always initialise a new pointer to NULL, even through
                  // new_tree() does this too - paranoid programming

  // Creates memory for a tree with ntax tips
  t = new_tree(ntax);

  // Now manually link up a tree (would probably have function to do this ideally)
  // Tree: ((1,2),(3,4)) <- see Day5 slides to make sense of this syntax. = 2 branches with 2 nodes each
  //  1  2   3  4
  //  \  /  \  /
  //   5     6
  //    \  /
  //     7
  // As we are setting up inernal nodes, they have indexes from ntax up to nnodes

  // Set up the root so it points to left and right ancestor nodes

  // Explanation of top line:
  // t->trnodes = pointer to nodes of the tree
  // t->ntax = integer giving number of taxa
  // t->trnodes[t->ntax] = (ntax)th node of the tree
  // t->trnodes[t->ntax].left = pointer to the left node of the (ntax)th node of the tree
  // &t->trnodes = a pointer to (ie address of) nodes of the tree
  // &t->trnodes[t->ntax+1] = pointer to (ntax + 1)th node of the tree

  // Initialise root
  t->root = &t->trnodes[t->ntax]; // root is the (ntax)th node of the tree

  // Connect root to left and right branches
  //t->root->left = t->root+1;
  //t->root->right = t->root+2;
  //t->root->anc = NULL;

  t->trnodes[t->ntax].left = &t->trnodes[t->ntax+1];
  t->trnodes[t->ntax].right = &t->trnodes[t->ntax+2];
  //t->trnodes[t->ntax].anc = NULL; // no ancestor as it's the root

  // Set up left branch
  //t->root+1->left = &t->trnodes[0];
  //t->root+1->right = &t->trnodes[0];
  //t->root+1->anc = t->root;


  t->trnodes[t->ntax+1].left = &t->trnodes[0]; // Point to tip 1, these are at start of nodes array as are the tips
  t->trnodes[t->ntax+1].right = &t->trnodes[1]; // Point to tip 2
  //t->trnodes[t->ntax+1].anc = &t->trnodes[t->ntax]; // ancestor = the root

  // Set up right branch
  t->trnodes[t->ntax+2].left = &t->trnodes[2]; // Point to tip 3
  t->trnodes[t->ntax+2].right = &t->trnodes[3]; // Point to tip 4
  //t->trnodes[t->ntax+2].anc = &t->trnodes[t->ntax]; // ancestor = the root


  // Initialise root
  //t->root = &t->trnodes[t->ntax];

  //Traverse the tree from the root
  traverse(t->root);

  // deletes the tree memory
  delete_tree(t);
  t = NULL;

  return 0;
}
