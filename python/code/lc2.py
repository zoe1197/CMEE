
#!/usr/bin/env python3
"""This is the excercise2 for comprehension and loop"""

__appname__ = "comp excercise2"
__version__ = "0.0.1"
__auther__ = "Zoey"
__license__ = "license"

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets

import sys
from telnetlib import STATUS
from sympy import principal_branch


rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )
 
# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

Q1 = [month for month in rainfall if month[1] > 100]
Q1 = tuple(Q1)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

Q2 = [month[0] for month in rainfall if month[1] < 50]
# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

Q1_loop = []
Q2_loop = []
for month in rainfall:
    if month[1] > 100:
        Q1_loop.append(month)
    if month[1] < 50:
        Q2_loop.append(month[0])

Q1_loop = tuple(Q1_loop)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.a


def main(argv):
    
    print(Q1)
    print(Q2)
    print(Q1_loop)
    print(Q2_loop)


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status) 
