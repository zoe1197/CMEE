# tutorial 5
import numpy as np 
import scipy as sp 
import matplotlib as plt

# Q6
M = np.array([[0,1.6,3.9], [0.8,0,0], [0,0.1,0]])
p0 = np.array([[1000],[100],[20]])
p1 = np.matmul(M, p0)
p2 = np.matmul(M, p1)
p3 = np.matmul(M, p2)
p3
p_test = np.matmul(np.linalg.matrix_power(M, 3), p0)
p_test


# Q7
P = np.array([[0,5,3,2,1], [0.9,0,0,0,0], [0,0.3,0,0,0], [0,0,0.1,0,0], [0,0,0,0.05,0]])
N0 = np.array((0,0,0,0,10))
N20 = np.matmul(np.linalg.matrix_power(P, 20), N0)
N20

N_list = []
for i in range(1,20,1):
    
    N = np.matmul(np.linalg.matrix_power(P, i), N0)
    N_list = N_list.append(N)


plt.plot(range(20), N_list)
plt.show()

########
M = np.array([[0,1.6,3.9], [0.8,0,0], [0,0.1,0]])
np.linalg.eig(M)