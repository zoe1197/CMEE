
from re import I


i = 1
x = 0
for i in range(10):
    x += 1
print(x)
print(i)

i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x,i 
x = a_function(10)
print(x)
print(i)

# try global variables
_a_global = 10

if  _a_global >= 5:
    _b_global = _a_global + 5 # _b_global will also be a global variable

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    _a_global = 4 # this is a local variable

    if _a_global >= 4:
        _b_global = _a_global + 5 # this is also gonna be a local variable

    _a_local = 3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)

# print("After calling a_function, outside the function, the value of _a_local is ", _a_local)
# this is not gonna work, cause the local variable is just exist in the function

_a_global = 10

def a_function():
    _a_local = 4
    
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
a_function()

print("Outside the function, the value of _a_global is", _a_global)

# using the global keyword in the function
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)

# the global keyword also works inside the nested funcitons:
def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    # the confusing part, even called a_function2, the _a_global variable is still not overworte
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)

# compare this one with the last function, assign the value before the function
_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)

# The use of return directive is also gonna change the variable in main workspace
def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    
my_list = [1, 2, 3]

print('before, my_list =', my_list)

modify_list_1(my_list)

print('after, my_list =', my_list)

# return directive
def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)
print('after, my_list =', my_list)

# use append:
def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) # an actual modification of the list
    print('changed to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)
modify_list_3(my_list)
print('after, my_list =', my_list)