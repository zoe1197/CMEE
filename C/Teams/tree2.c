#include <stdio.h>
#include <stdlib.h>

#include "tree.h"

// can run this alone using gcc -c (as no main function), this file is run with
// phyloprogam.c

tree* new_tree(const unsigned int ntax) {

  /*
  This is the allocator function for the tree structure,
  requires as an argument the intended number of terminals
  (ie. number of species the tree will hold)
  */

  tree* t = NULL;

  t = calloc(1, sizeof(tree));
  if (t == NULL) {
    printf("Insifficient memory for requested tree size\n");
    return NULL;
  }

  t->ntax = ntax;
  t->nnodes = 2 * ntax; // number of nodes in a rooted binary tree = 2 * ntax - 1
                        // here, an extra 'dummy' node will also be used at the root
                        // hence 2 * ntax

  printf("made it\n");
  // Initialise the node data
  t->trnodes = malloc(t->nnodes * sizeof(node)); // reserving enough memory for all the nodes
  if (t->trnodes == NULL) {
    printf("Insuffient memory for requested tree size\n");
    free(t); // need to free assigned memory or will create a memory leak
    return NULL;

  }

  int i;
  for (i = 0; i < t->nnodes; i++) {
    t->trnodes[i].index = i;
    if (i < t->ntax) {
      t->trnodes[i].tip = i + 1;
    } else {
      t ->trnodes[i].tip = 0; // as not at the tip, kind of acts like a boolean too
    }
    t->trnodes[i].left = NULL;
    t->trnodes[i].right = NULL;
    t->trnodes[i].anc = NULL;
  }
  printf("made it2\n");

  return t;
}

void delete_tree(tree* t) {

  if (t->trnodes != NULL) {
    free(t->trnodes);
    t->trnodes = NULL;
  }

  free(t);
}
// if current node is a tip: return
// else:
// traverse the left node
// traverse the right node
// return
void traverse(node* p) {
  printf("here3\n");
  if (p->tip != 0) {
    printf("Reached a tip\n");
    return;
  }
  printf("here\n");
  traverse(p->left);
  printf("here2\n");

  traverse(p->right);
  printf("Node: %i\n", p->index);
  return;

}
