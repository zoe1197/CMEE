#!/usr/bin/env python3
"""this module is for comparing the list comprehension and for loop when you need to print stuff by each item"""

__exercise__ = "tuple"
__version__ = "0.0.1"
__auther__ = "Zoey"
__license__ = "license"

import sys

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis
# Common name: Savannah sparrow
# Mass: 18.7
# ... etc.

# Hints: use the "print" command! You can use list comprehensions!

def main(argv):

    # for loop 
    for bird in birds:
        print("Latin name: ", bird[0])
        print("Common name: ", bird[1])
        print("Mass: ", bird[2])

    # list comprehension
    lat_name = [bird[0] for bird in birds]
    com_name = [bird[1] for bird in birds]
    mass = [bird[2] for bird in birds]
    for i in range(len(lat_name)):
        print("Latin name: ", lat_name[i])
        print("Common name: ", com_name[i])
        print("Mass: ", mass[i])

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)