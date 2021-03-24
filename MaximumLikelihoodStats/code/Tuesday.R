

rm(list = ls())
graphics.off()


############ example in class
# write down the likelihood function
binomial.likelihood <- function(p){
  choose(10,7)*p^7*(1-p)^3
}
# calculate the likelihood value at 9 = 0.1
binomial.likelihood(p=0.1)
# plot the likelihood function for a range of P
p <- seq(0, 1, 0.01)
likelihood.value <- binomial.likelihood(p)
plot(p, likelihood.value, type = 'l')
# plot the log likelihood function
log.binomial.likelihood <- function(p){
  log(binomial.likelihood(p = p))
}
# plot the log-likelihood 
p <- seq(0,1,0.01)
log.likelihood.value <- log.binomial.likelihood(p)
plot(p, log.likelihood.value, type = 'l')

#
optimize(binomial.likelihood, interval = c(0,1), maximum = TRUE)


############ Rabbit Example ############
# read the data
recap.data <- read.csv("../data/recapture.csv", header = TRUE)
# scatterplot
plot(recap.data$day, recap.data$length_diff, pch = 19)
# 1. log-likelihood
regression.log.likelihood <- function(parm, dat){
  a <- parm[1]
  b <- parm[2]
  sigma <- parm[3]
  
  x <- dat[,1]
  y <- dat[,2]
  
  density <- dnorm(y, mean = a+b*x, sd = sigma, log = T)
  
  return(sum(density))
}
regression.log.likelihood(c(1,1,1), dat = recap.data)

# 2. log-likelihood
regression.log.likelihood2 <- function(parm, dat){
  a <- parm[1]
  b <- parm[2]
  sigma <- parm[3]

  x <- dat[,1]  
  y <- dat[,2]
  
  error.term <- (y-a-b*x)
  density <- dnorm(error.term, mean = 0, sd = sigma, log = T)
  
  return(sum(density))
}


regression.log.likelihood2(c(1,1,1), dat = recap.data)

# optimise the log-likelihood funcion
optim(par = c(1,1,1), regression.log.likelihood, method = 'L-BFGS-B',
      lower = c(-1000,-1000,0.0001), upper = c(1000,1000,10000),
      control = list(fnscale=-1), dat = recap.data, hessian = T)

# perform the same analysis with lm()
m <- lm(length_diff ~day, data = recap.data)
summary(m)
n <- nrow(recap.data)
sqrt(var(m$residual)*(n-1)/n)


############ Q7 ############


