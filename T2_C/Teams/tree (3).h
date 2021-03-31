#ifndef _TREE_H_
#define _TREE_H_

// Library for creating phylogenetic trees

struct node {
  struct node* left; // left descendant pointer
  struct node* right; // right descendant pointer
  struct node* anc; // parent node pointer
  int index; // number of node (used for internal nodes)
  int tip; // used to identify tips of the tree, numbers 1 - ntax

  // other options
  //float brlength; // branch length
  //char* label; // species name (for tips)
};
typedef struct node node;


// Tree struct: a wrapper to store the block of nodes
// indices 0.. ntax-1 are for terminal nodes
// ntax... nnodes-1 are the internal nodes and root
struct tree {
  struct node* trnodes; // pointer to all nodes in tree
  struct node* root; // pointer to the root
  int ntax; // number of tips (or terminal taxa)
  int nnodes; // number of nodes in the tree
};
typedef struct tree tree;


tree* new_tree(const unsigned int ntax); // allocate all memory
void delete_tree(tree* t); // deallocate all memory
void traverse(node* p); // to traverse nodes of tree

#endif
