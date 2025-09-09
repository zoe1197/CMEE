

import numpy as np


a = np.array(range(5))
print(a)
print(type(a))
print(type(a[0]))

b = np.array(range(5), float)
print(b)
b.dtype
print(type(b[0]))

# get 1-D arrays 
x = np.arange(5)
x
print(x)
y = np.arange(5.)
y

x.shape
y.shape

# using comprehension
p = np.array([i for i in range(10) if i%2 == 1])
p
q = p.tolist()
q

# to make the matrix you need a 2-D numpy array
mat = np.array([[0,1],[2,3]])
mat
mat.shape
# index [row, colum]
mat[1]
mat[:,1]
mat[1,0]
mat[0,-1]
mat[0,-2]
mat[-1,0]

# Replacing, adding or deleting elements
## replace a single element
mat[0,0] = 7
mat
mat[:,0] = [9,9]
mat
## adding by appending
np.append(mat, [[12,12]], axis = 0) # append by row: axis = 0
np.append(mat, [[22],[22]], axis = 1) # append by column: axis = 1
new_row = [[12,12]]
mat1 = np.append(mat, new_row, axis = 0)
mat1
## deleting
np.delete(mat1, 0, 1) #np.delete(object, index, row/column)
np.delete(mat1, 1, 0)

# flattening or reshaping arrays
mat
mat.ravel()
mat.reshape((1,4))
mat.reshape((4,1))

# pre-allocating arrays
np.ones((4,2))
np.zeros((4,2))
m = np.identity(4)
m
m.fill(16)
m

# numpy/scipy matrics, numpy matrics are a subclass of numpy arrays, the main advantage of scipy matrics is they provide a convenient notion for matric multiplication. e.g. a*b is their matrix product
## matrix-vector operations
mm = np.arange(16)
mm
mm = mm.reshape(4,4)
mm
mm.transpose()
mm + mm.transpose()
mm - mm.transpose()
mm * mm.transpose() # NOTE: this is element-wise multiplication
mm // mm.transpose()
mm // (mm + 1).transpose()
mm * np.pi
mm.dot(mm) # NOTE: this is the matric multiplication, or the dot product
# numpy matrix class
npmat = np.matrix(mm)
npmat
print(type(npmat))
# when you multiply the numpy matrix, it is the matrix multiplication
npmat * npmat
npmat * npmat == mm.dot(mm)
# while the numpy matrix is not recommanded, cause it may be removed in the futrue



# scipy: scipy.stats & scipy.integrate
import scipy as sc
from scipy import stats
# generate 10 samples from the normal distribution N(\mu, \segma)
sc.stats.norm.rvs(size = 10) # by default these numbers are from the standard normal distribution N(0,1)
np.random.normal(size = 10)
# seed 
np.random.seed(1234)
sc.stats.norm.rvs(size = 10)
