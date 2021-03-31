import numpy as np

M = np.array([[2/3,1/2],[1/3,1/2]])
M

# p0 = (1,0)'
p0 = np.array((1,0))
p0
np.matmul(M, p0)
np.matmul(np.linalg.matrix_power(M, 1), p0)
np.matmul(np.linalg.matrix_power(M, 2), p0)
np.matmul(np.linalg.matrix_power(M, 2), p0)
np.matmul(np.linalg.matrix_power(M, 100), p0)
# get the result (.6,.4)'


# p0 = (0,1)'
p0 = np.array((0,1))
np.matmul(np.linalg.matrix_power(M,1), p0)
np.matmul(np.linalg.matrix_power(M,2), p0)
np.matmul(np.linalg.matrix_power(M,3), p0)
np.matmul(np.linalg.matrix_power(M,100), p0)
# get the result (.6,.4)'


# p0 = (0.6,0.4)'  (3/5, 2/5)'
p0 = np.array((0.6,0.4))
np.matmul(np.linalg.matrix_power(M, 1), p0)
np.matmul(np.linalg.matrix_power(M, 2), p0)
np.matmul(np.linalg.matrix_power(M, 3), p0)
np.matmul(np.linalg.matrix_power(M, 100), p0)
# get the result (.6,.4)'


v = np.array((-1,1))
np.matmul(np.linalg.matrix_power(M, 1), v)
np.matmul(np.linalg.matrix_power(M, 2), v)
np.matmul(np.linalg.matrix_power(M, 3) , v)
np.matmul(np.linalg.matrix_power(M, 100), v)




