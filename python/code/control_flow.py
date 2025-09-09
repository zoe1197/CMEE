
#!/usr/bin/env python3
"""This module is for exercising change the python code into a format module"""

from cgi import print_directory
import imp
import sys


def foo_1(x):
    return x ** 0.5


def foo_2(x, y):
    if x > y:
        return x
    return y


def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result


def foo_5(x): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)

     
def foo_6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto




########################
def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')



########################
def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')



########################
def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')



########################
def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')



########################
def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')



# WHILE loop with BREAK
def hello_6(x, y):
    while x: # while x is True
        print("hello! " + str(y))
        y += 1 # increment y by 1 
        if y == 6:
            break
    print(' ')


def main(argv):
    print(foo_1(9))
    print(foo_2(3,6))
    print(foo_3(7,2,18))
    print(foo_3(2,7,1))
    print(foo_4(6))
    print(foo_5(6))
    print(foo_6(6))
    print(hello_1(12))
    print(hello_2(12))
    print(hello_3(3, 17))
    print(hello_4(0))
    print(hello_5(12))
    print(hello_6 (True, 0))

if __name__ == "__main__":
    status = main(main(sys.argv))
    sys.exit(status)