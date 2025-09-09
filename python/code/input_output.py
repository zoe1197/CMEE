
#############################
# FILE INPUT
#############################
# Open a file for reading
from os import getcwd
from this import d

from sympy import principal_branch


f = open('../sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
    print(line)

# close the file
f.close()


# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()


##########
# OUTPUT #
##########
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()
# see whether writen
f = open("../sandbox/testout.txt", 'r')
for i in f:
    print(i)
f.close()

# saving objects (binary files)
import pickle

my_dictionary = {'a key': 10, 'another key': 11}
f = open('../sandbox/testp.p', 'wb') # w means write, b means accept the binary files
pickle.dump(my_dictionary, f)
f.close()

# load the data again
f = open('../sandbox/testp.p', 'rb')
another_dictionary = pickle.load(f)
f.close()
print(another_dictionary)   


#################################
# use with method to open files #
#################################

import csv
# read the file
with open("../data/testcsv.csv", 'r') as f:

    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])

# write a file containing only species name and body mass
with open("../data/testcsv.csv", "r") as f:
    with open("../data/bodymass.csv", "w") as g:
        csvread  = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])