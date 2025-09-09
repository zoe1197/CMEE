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
//    printf("%i ", n->index); // In preorder
    if (n->next != NULL) {
        traversell(n->next);
    }
    printf("%i ", n->index); //In postorder
}

void remove_ith_node(unsigned int n, node *n)
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

    node *nptr;

    nptr = &n1;

    printf("Index in n1: %i\n", n1.index);
    (*nptr).index = 5;
    printf("Index in n1: %i\n", n1.index);
    nptr->index = 7;
    printf("Index in n1: %i\n", n1.index);

    n1.index = 1;
    n2.index = 2;
    n3.index = 3;
    n4.index = 4;

    // A linked list
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n4;
    n4.next = NULL;

    // n1==>n2==>n3==>n4
    traversell(&n1);
    printf("\n");

//simple remove
//    n1.next = &n3;

//remove by traversal
    remove_ith_node();
    
    printf("\n");

}