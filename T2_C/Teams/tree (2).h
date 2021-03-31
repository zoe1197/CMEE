#ifndef _TREE_H_
#define _TREE_H_

struct node {
    struct node *left; // The left desc pointer
    struct node *right; // The right desc pointer
    struct node *anc;  // Pointer to the parent node
    int         index; // 0...nnodes
    int         tip; // 1-ntax
};

/* This is the tree struct
 * The trees nodes are stored in the trnodes "array"
 * Indicies 0...ntax-1 are for the terminal nodes
 * ntax...nnodes-1 are the internal nodes and root
 */
struct tree {
    struct node *trnodes;
    struct node *root;
    int          ntax; // Number tips (or terminal taxa)
    int          nnodes; // Minimum: 2 * ntax-1 : rule for bin tree
};

typedef struct node node;
typedef struct tree tree;

tree *new_tree(const unsigned int ntax);
void delete_tree(tree *t);
void traverse(node* p);

#endif
