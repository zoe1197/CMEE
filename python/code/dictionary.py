#!/usr/bin/env python3
"""This module is for practicing dictionary"""

__exercise__ = "Dictionary"
__version__ = "0.0.1"
__auther__ = "zoey"
__license__ = "license"

import sys

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc

uni_species = set([species[1] for species in taxa])
uni_species = list(uni_species)
taxa_dic = {}
for i in range(len(uni_species)):
        taxa_dic[uni_species[i]] = [species[0] for species in taxa if species[1] == uni_species[i]]

def main(argv):
        for j in range(len(uni_species)):
                print(uni_species[j], ":", taxa_dic[uni_species[j]])

if __name__ == "__main__":
        status = main(sys.argv)
        sys.exit(status)