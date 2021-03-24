source("../Data/abc.R")
library(coda)

# Rejection algorithm
N <- 1e4

# data/observations
y <- 4

# function to simulate is called "simulateElephants"
thetas <- c()
while (length(thetas) <= N) {
  # browser()
  # 1. draw from prior (continuous, bounded, uniform)
  theta <- runif(1,0,20)
  
  # 2. simulate observations
  ysim <- simulateElephants(theta)
  
  # 3. accept/reject
  if (ysim == y) thetas <- c(thetas, theta)
  
}

hist(thetas)







################ example2 ################ 
source("../Data/abc.R")
# Rejection algorithm in the continuous case
N <- 1e3
y <- 91.3514
epsilon <- 1e-1 

# function to simulate is called "simulateWaterTemp"

# euclidean distance
rho <- function(x,y) sqrt((x-y)^2)

thetas <- c()
while (length(thetas) <= N) {
  
  # 1. draw from prior (continuous, bounded, uniform)
  theta <- runif(1, min=80, max=110)
  
  # 2. simulate observations
  ysim <- simulateWaterTemp(theta)
  
  # 3. accept/reject
  if (rho(ysim,y)<=epsilon) thetas <- c(thetas, theta)
  
}

print(mean(thetas))
print(var(thetas))
hist(thetas)
quantile(thetas, c(0.025,0.25,0.5,0.75,0.975))






################# practice #################
source("../Data/abc.R")
# Rejection algorithm with proportions of simulations to accept
N <- 1e4
Y <- c(91.34, 89.21, 88.98)
th <- 0.05

# distance function
rho <- function(x, y){
  sum(sqrt((x-y)^2)) / length(y)
}

# function to simulate is called "simulateWaterTemp"
thetas <- dis <- c()

for (i in 1:N) {
  
  # 1. draw from prior (continuous, bounded, normal)
  theta <- 0
  while (theta < 80 | theta > 110) {
    theta <- rnorm(1, mean = 90, sd = sqrt(20))
  }
  thetas <- c(thetas, theta)
  
  # 2. simulate observations
  ysim <- simulateWaterTemp(theta)
  
  # 3. calculate the distance
  dis <- c(dis, rho(ysim, Y))
}

# prior / parameter
hist(thetas)
quantile(thetas)

# relationship between paremeter and distance
head(cbind(thetas, dis))

# distance
hist(dis)
accept <- which(rank(dis, ties.method = 'random') / length(dis) <= th)
range(dis[accept])
abline(v = max(dis[accept]), lty = 2)
