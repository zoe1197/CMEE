# 1. the shebang
#!/usr/bin/env python3

# 2. the docstring
"""Description of this program or application.
You can use several lines"""

__appname__ = '[application name here]'
__author__ = 'Your Name (your@email.address)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## imports ##
import sys # module to interface our program with the operating system

## constants ##




# sys.exit("I am exiting right now!")



## functions ##
def main(argv):
    """ Main entry point of the program """
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    return 0


# run it in terminal typing "python3 filename.py" or "ipython filename.py"
# or in the ipython shell typiing "%run filename.py"
if (__name__ == "__main__"): # with parenthesis the module is reusable 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)