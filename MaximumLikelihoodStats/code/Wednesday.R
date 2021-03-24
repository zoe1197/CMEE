

rm(list = ls())
graphics.off()


### continue with the likelihood model from tomorrow
# read the data 
recap.data <- read.csv("../data/recapture.csv")

#  define the likelihood function
M1 <- function(parm, dat){
  
  b <- parm[1]
  sigma <- parm[2]
  x <- dat[,1]
  y <- dat[,2]
  
  error.term <- (y-b*x)
    
  density <- dnorm(error.term, mean = 0, sd = sigma, log = T)
  
  return(sum(density))
}

regression.log.likelihood <- function(parm, dat){
  a <- parm[1]
  b <- parm[2]
  sigma <- parm[3]
  
  x <- dat[,1]
  y <- dat[,2]
  
  density <- dnorm(y, mean = a+b*x, sd = sigma, log = T)
  
  return(sum(density))
}

M1op <- optim(par = c(1,1), M1, dat = recap.data, method = 'L-BFGS-B', 
              lower = c(-1000,0.0001), upper = c(1000,10000),
              control = list(fnscale = -1), hessian = T)
M2op <- optim(par = c(1,1,1), regression.log.likelihood, dat=recap.data,
              method = 'L-BFGS-B', lower = c(-1000, -1000, 0.0001), upper = c(1000,1000,10000),
              control = list(fnscale = -1), hessian = T)

# the test statistic D 
D <- 2*(M2op$value - M1op$value)
D
# critical value
qchisq(0.95, df = 1)



###################### Q3 ######################
# write the pmf function of binomial distribution, u can use dbinom directly
binom <- function(n=10, k=7, p=0.5){
  return(choose(n = n, k = k)*p^k*(1-p)^(n-k))
}
binom()
binom_pmf <- dbinom(x = 7,size = 10,prob = 0.5, log = FALSE)
binom_pmf

dbinom(x = 7, size = 10, prob = 0.5,log = TRUE) 
dbinom(x = 7,size = 10,prob = 0.7,log = TRUE)
