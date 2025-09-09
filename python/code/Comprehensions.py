

x = [i for i in range(3)]
print(x)
# it is the same as:
x = []
for i in range(3):
    x.append(i)
print(x)


x = [i.lower() for i in ['HJ', 'DHC', 'DJNHBIEU']]
print(x)
# it is the same as 
x = ['HJ', 'DHC', 'DJNHBIEU']
for i in range(len(x)):
    x[i] = x[i].lower()
print(x)

# nested loop
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flat_mat = []
for row in matrix:
    for n in row:
        flat_mat.append(n)
print(flat_mat)  
# it's the same as:
flat_mat = [n for row in matrix for n in row]
print(flat_mat)

words = (["These", "are", "some", "words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])
print(first_letters)
# it's the same as:
first_lets = [w[0] for w in words]
first_lets



## Finds just those taxa that are oak trees from a list of species

taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

def is_an_oak(name):
    return name.lower().startswith('quercus ')

[is_an_oak(names) for names in taxa]


##Using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

##Using list comprehensions   
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASE using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)