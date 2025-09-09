#!/usr/bin/env python3
# Filename: using_name.py

from cgi import print_directory


if __name__ == '__main__':
    print("This Program is being run by itself")
else:
    print("I am being imported from another module")

print("this module's name is: " + __name__) 
