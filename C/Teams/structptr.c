#include <stdio.h>
#include <stdlib.h>

struct node {
    int index;
    int data;
    struct node *next;
};

struct tnode {
    struct node* left;
    struct node* right;
    struct node* anc;
};

typedef struct node node;

void traversell(node *n)
{
    //printf("%i ", n->index); // In preorder
    if (n->next != NULL) {
        traversell(n->next);
    }
    printf("%i ", n->index); // In postorder
}

void remove_ith_node(unsigned int i, node *n)
{
    if (n->next != NULL) {
        remove_ith_node(i, n->next);
    }
}


int main(void)
{
    node n1;
    node n2;
    node n3;
    node n4;

    n1.index = 1;
    n2.index = 2;
    n3.index = 3;
    n4.index = 4;

    // A linked list
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n4;
    n4.next = NULL;

    // n1.next==>n2.next==>n3.next==>n4.next==>NULL
    traversell(&n1);
    printf("\n");

    traversell(&n1);

    // Simple removal
    //n1.next = &n3;
    
    // Remove by traversal
    remove_ith_node( ); // Decide what i is
    
    // Verify that it worked
    traversell(&n1);

    printf("\n");
    
    return 0;
}
