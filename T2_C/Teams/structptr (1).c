#include <stdio.h>
#include <stdlib.h>

struct node {
    int index;
    int data;
    struct node *next;
};

typedef struct node node;

void traversell(node *n)
{
    //printf("%i ", n->index); // In preorder
    if (n->next != NULL) {
        traversell((*n).next);
    }
    printf("%i ", n->index); // In postorder
}

void remove_ith_node1(unsigned int i, node *n)
{
    if (n->next != NULL) {
        if (n->next->index == i){
            n->next = n->next->next;
            return;
        }
        remove_ith_node1(i, n->next);
    }
}


void remove_ith_node(const unsigned tgt, unsigned i, node *n) 
{
    node *p = NULL;
    ++i;
	if (n->next != NULL) {
		if (tgt == i) { // if next node has index i
            p = n->next;
			n->next = n->next->next;
            p->next = NULL; // This closes separate entires to the list
			return;
		}
		remove_ith_node(tgt, i, n->next); // if next node doesnt have index i, go to next node
	} else {// if has got to the end of the linked list without returning
		printf("Index %i out of bounds!\n", i);
		return;
	}
}


int main(void)
{
    // Set up array of 6 nodes
    int i;
    node nodes[6];
    for (i = 0; i < 5; ++i) {
        nodes[i].next = &nodes[i+1];
        nodes[i].index = i;
    }
    nodes[i].next = NULL;
    nodes[i].index = i;

    // n1.next==>n2.next==>n3.next==>n4.next==>NULL
    traversell(nodes);
    printf("\n");

    // Remove by traversal
    remove_ith_node(3, 0, nodes); // Decide what i is
    
    // Verify that it worked
    traversell(nodes);
    printf("\n");
    
    traversell(&nodes[3]);
    printf("\n");
    return 0;
}
