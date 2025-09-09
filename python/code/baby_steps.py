
# python data structure
## dictionary
GenomeSize = {'Homo sapiens':3200.0, 'Escherichia coli':4.6,'Arabidopsis thaliana':157.0}
GenomeSize['Arabidopsis thaliana']
GenomeSize['Saccharomyces cerevisiae'] = 12.1
GenomeSize['Homo sapiens'] = 3201.1
GenomeSize

a = [1,2,3,4,5]
b = a 
b
b.append(7)
b

## ??? shallow deep copy
import copy
a = [[1, 2], [3, 4]]
b = copy.deepcopy(a)
b
a[0][1] = 22
a
b

## Strings
s = " this is a string "
len(s)
s.replace(" ", "_")
s.find('s') # the first occurance of s
s.count('s') # count the number of s

t = s.split()
t
t = s.split('is')
t
s.upper()
s.upper().strip() # ??? can perform sequential operations
"WORLD".lower()

## getting help
help(s.upper)

# Writing Python Code
