# 1. traditional for loop
# calculate the distribution of the sum of 30 chisq(df = 1) random variables
result1 <- rep(NA, 1000)
for (i in 1:1000) {
  #browser()
  temp <- rchisq(30, df = 1)
  result1[i] <- sum(temp)
}
result1





# 2.doParallel package: parallelised version

# 1> load the package
require(doParallel)

# 2> create a local 'cluster' object cl. 
# the number inside the bracket must not exceed your CPU core counts. refister the cluster before use
cl <- makeCluster(6)
registerDoParallel(cl)

# 3> foreach
# .combine is an argument specifying how results from different runs are combined. possible was are c, cbind, rbind. default is a list
# remember %dopar%
result2 <- foreach(1:1000, .combine = 'c') %dopar%{
  temp <- rchisq(30, df = 1)
  return(sum(temp))
}

# 4> stop the cluster after use
stopCluster(cl)

result2