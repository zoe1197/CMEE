#!/usr/bin/env python3
"""This program is for excersising the comprehension and for loop"""

__auther__ = "Zoey Dy"
__version__ = "0.0.1"

import sys
from click import command


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

birds = list(birds)

latin_name_comp = [bird[0] for bird in birds] 
common_name_comp = [bird[1] for bird in birds]
mean_body_mass_comp = [bird[2] for bird in birds]

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

latin_name_loop = []
common_name_loop = []
mean_body_mass_loop = []

for bird in birds:
    latin_name_loop.append(bird[0])
    common_name_loop.append(bird[1])
    mean_body_mass_loop.append(bird[2])

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.


def main(argv):

    print(latin_name_comp)
    print(common_name_comp)
    print(mean_body_mass_comp)

    print(latin_name_loop)
    print(common_name_loop)
    print(mean_body_mass_loop)

    
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
