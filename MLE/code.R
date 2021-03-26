

rm(list = ls())
graphics.off()


# Q3-2: X ~ Poisson(numda = 2) visualize the PMF
x <- 0:10
y <- dpois(x, lambda = 2)
plot(x, y, pch = 16, ylab = 'PMF', xlab = 'Outcome(x)')


# Q3-3: calculate the Poisson P(x=4) and P(x <= 3)
# 1. Pr(x = 4)
exp(-2)*2^4 / factorial(x = 4)
dpois(x = 4,lambda = 2)
# 2. Pr(x<=3)
sum(dpois(0:3, lambda = 2))
ppois(3, lambda = 2)
exp(-2)*(2^3/factorial(3)+2^2/factorial(2)+2^1/factorial(1))

# Q3-4: simulate Poisson with lambda = 2
x <- rpois(1000,lambda = 2)
x
hist(x)

set.seed(123)
x <- rpois(10, lambda = 2)
y <- rpois(10, lambda = 2)
x == y # not equal
# reset seeds
set.seed(123)
z = rpois(10, lambda = 2)
x == z # should be all equaled

# Q4-4: X~Exponential(lambda = 2). Plot the PDF of X for Rx=[0,5] with interval 0.01
inter <- seq(0,5,0.01)
Pr_X <- dexp(x = inter, rate = 2)
plot(inter, Pr_X, pch = 16, cex = 0.1, xlab = 'X(random variable)', ylab = 'Probability')

# Q4-5: calculate the probability of an interval using PDF
integrate(dexp, lower = 0, upper = 1, rate = 2)

# Q5-1: Plot standard normal distribution from -3 to 3
x <- seq(-3,3,0.1)
y <- dnorm(mean = 0, sd = 1, x = x)
plot(x, y, pch = 16, cex = 0.5)

integrate(dnorm, lower = 2, upper = 3)
pnorm(3)-pnorm(2)
integrate(dnorm, lower = -1.96, upper = 1.96)
pnorm(1.96)-pnorm(-1.96)

# Q6: CLT:Central limit theorem
y <- rnbinom(1000, 1, 0.2)
hist(y)
y <- matrix(rnbinom(30*1000, 1, 0.2), nrow = 1000, ncol = 30)
y.row.mean <- apply(y, 1, mean)
hist(y.row.mean)











########################## Tuesday ##########################
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

# check optimize
optimize(binomial.likelihood, interval = c(0,1), maximum = TRUE)


############ Rabbit Example ############
# read the data
recap.data <- read.csv("data/recapture.csv", header = TRUE)
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
  
  # the log-likelihood is the sum of individual log-density
  return(sum(density))
}

# 2. log-likelihood + error
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

regression.log.likelihood(c(1,1,1), dat = recap.data)
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








########################## Wednesday ##########################

########################## Thursday ##########################
########################## Friday ##########################