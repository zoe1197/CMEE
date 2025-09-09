
from cgi import print_directory

x = 11
for i in range(x):
    if i > 3: 
        print(i)



# %cpaste: paste in the ipython console with correct indentation

# loops
for i in range(10):
    print(i)

a = range(10)
print(a)

for i in range(3,9):
    print(i)

for i in range(3,18,3):
    print(i)

# iterator V.S. generator
iter_list = iter(['Geeks', 'For', 'test', '3']) # print(iter_list) is not gonna work
print(next(iter_list))
print(next(iter_list))
print(next(iter_list))

iterable_obj = [1,2,3]
print(iterable_obj)
type(iterable_obj)
type(iter_list)

def sq_num(n):
    for i in range(1,n+1):
        yield i*i

sq = sq_num(5) # print(sq) is not gonna work
print(next(sq))
print(next(sq))
print(next(sq))
print(next(sq))
print(next(sq))

# some loop examples
my_list = [0,2,"geronimo!",3.0,True, False]
for k in my_list:
    print(k)

total = 0 
sumnum = [1,11,111,1111,11111]
for i in sumnum:
    total = total + i 
    print(total)

z = 0 
while z < 100:
    z = z + 19
    print(z)

# return
def foo(x):
    x *= x
    print(x)
sq = foo(2)
sq
type(sq)

def foo(x):
    x *= x
    print(x)
    return(x)
sq_return = foo(3)
sq_return
type(sq_return)

# running the python script
# in bash: ipython XXX.py / python3 XXX.py(it seems faster)
# within the ipython shell: run XXX.py

# control flow tools 
