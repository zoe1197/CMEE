

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
# ***
set.seed(123)
x <- rpois(10, lambda = 2)
y <- rpois(10, lambda = 2)
x == y # not equal
# reset seeds
# ***
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
########################## 
# r: generate random number in specific distribution
rnorm(20)
# d:pmf/pdf
dnorm(1:3)
# p:cdf
pnorm(q = 1.96) - pnorm(-1.96)
integrate(dnorm,lower = -1.96, upper = 1.96)
sum(dnorm(-1.96:1.96))
# q:quantile
qnorm(0.3)



########################## Tuesday ##########################
############ example in class
########################## 
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
########################## 

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
  # the log-likelihood is the sum of individual log-density
  return(sum(density))
}

# 2. log-likelihood + error
regression.log.likelihood.error <- function(parm, dat){
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
regression.log.likelihood.error(c(1,1,1), dat = recap.data)
# optimise the log-likelihood funcion
optim(par = c(1,1,1), regression.log.likelihood, method = 'L-BFGS-B',
      lower = c(-1000,-1000,0.0001), upper = c(1000,1000,10000),
      control = list(fnscale=-1), dat = recap.data, hessian = T)
# perform the same analysis with lm()
m <- lm(length_diff ~ day, data = recap.data)
summary(m)
n <- nrow(recap.data)
sqrt(var(m$residual)*(n-1)/n)


############ Q7 ############


########################## Wednesday ##########################
## EXAMPLE: Linear regression test for intercept
# M1(without an intercept), M2(with intercept), M1 is nested in M2
# define the function without intercept for M1
regression.no.intercept.log.likelihood <- function(parm, dat){
  b <- parm[1]
  sigma <- parm[2]
  x <- dat[,1]
  y <- dat[,2]
  error.term <- (y-b*x)
  density <- dnorm(error.term, mean = 0, sd = sigma, log = TRUE)
  # log likelihood is the sum of the densities
  return(sum(density))
}
# performing likelihood-ratio test
M1 <- optim(par = c(1,1), regression.no.intercept.log.likelihood,
            dat = recap.data, method = "L-BFGS-B",
            lower = c(-1000,0.0001), upper = c(1000,10000),
            control = list(fnscale = -1), hessian = T)
M2 <- optim(par = c(1,1,1), regression.log.likelihood,
            dat = recap.data, method = "L-BFGS-B",
            lower = c(-1000,-1000,0.0001), upper = c(1000,1000,10000),
            control = list(fnscale = -1), hessian = T)
# calculate the test statistic D
D <- 2*(M2$value-M1$value)
D
# calculate the critical value
chisq <- qchisq(0.95,1)
D < chisq

########################## 
# Example: Non-constant variance regression
regression.non.constant.var.log.likelihood <- function(parm, dat){
  b <- parm[1]
  sigma <- parm[2]
  x <- dat[,1]
  y <- dat[,2]
  error.term <- y-b*x
  density <- dnorm(error.term, mean = 0, sd = x*sigma, log = TRUE)
  return(sum(density))
}
# maximise the log-likelihood
M4 <- optim(par = c(1,1), regression.non.constant.var.log.likelihood,
            dat = recap.data, method = "L-BFGS-B",
            lower = c(-1000,0.0001), upper = c(1000,10000),
            control = list(fnscale = -1))
M4

########################## EXCERCISE
# Question 3 likelihood ratio test
## 1>
flip_coin <- function(p,n,y){
  return(choose(n,y)*(p^y)*((1-p)^(n-y)))
}
# M1: the simplified model with p = 0.5(p is fixed), Under M1, there is 0 free parameter. The maximised likelihood under M1 is
L_0.5 <- flip_coin(0.5,10,7)
log_L_0.5 <- log(L_0.5)
# M2: the Null model with 1 free parameter. We know from Tuesday that the likelihood is maximised when p=0.7. Hence the maximised likelihood under M1 is
L_0.7 <- flip_coin(0.7,10,7)
log_L_0.7 <- log(L_0.7)
# LRT statistic 
D <- 2*(log_L_0.7 - log_L_0.5)
# calculate the chi square
chi.sq <- qchisq(p = 0.95, df = 1)
# df of this test is 1-0=1, critical value of chi-square is 
chi.sq
# Since D < critical value, we accept M1 as the simplified model, do not reject the fair coin hypothesis.

## 2>
# M1: the simplified model with p = 0.5(p is fixed), 
# Under M1, there is 0 free parameter. The maximised likelihood under M1 is
L_1 <- flip_coin(0.5,50,35)
L_1
log_L_1 <- log(L_1)
log_L_1
# M2: the Null model with 1 free parameter. 
# We know from Tuesday that the likelihood is maximised when p=0.7. 
# Hence the maximised likelihood under M1 is
L_2 <- flip_coin(0.7,50,35)
L_2
log_L_2 <- log(L_2)
log_L_2
# LRT statistic 
D <- 2*(log_L_2 - log_L_1)
D
# df of this test is 1-0=1, critical value of chi-square is 
qchisq(p = 0.95,df = 1)
# Since D >> critical value, we reject M1 as the simplified model, do not reject the fair coin hypothesis.

## 3> find the 95% CI
# D = 2*(ln(L2)-ln(L1)) < $\chi^2|1 = 3.84$
# so ln(L2) - ln(L1) < 1.92
critic.value <- chi.sq/2
critic.value
# visualize
p = seq(0,1,0.001)
log.like <- dbinom(prob = p, log = TRUE, x = 35,size = 50)
plot(p, log.like-max(log.like),type = 'l')
abline(h = -crtic.value)
# so the 95% CI is 
within <- p[log.like > max(log.like)-critic.value]
CI <- c(min(within), max(within))
CI
abline(v = CI)
########################## 
########################## 
# Question 4
## read the data
flower <- read.table("../data/flowering.txt", header = T)
names(flower)
## visualize the data
par(mfrow = c(1,2))
plot(flower$Flowers, flower$State)
plot(flower$Root, flower$State)
## define the logistic log likelihood function
logistic <- function(parm,dat){
  a <- parm[1]
  b <- parm[2]
  c <- parm[3]
  state <- dat[,1]
  flowers <- dat[,2]
  root <- dat[,3]
  # model the success probability, via expit transformation
  p <- exp(a+b*flowers+c*root) / (1+exp(a+b*flowers+c*root))
  # the log likelihood function
  log.like <- sum(state*log(p)+(1-state)*log(1-p))
  return(log.like)
}

# try
logistic(c(0,0,0), dat = flower)

# Maximize the log likelihood 
M1 <- optim()
M1


########################## Thursday ##########################
########################## EXAMPLE: CI, linear regression
b <- seq(2,4,0.1)
sigma <- seq(2,5,0.1)
# the log.likelihood value is stroed in a matrix
log.like.value <- matrix(nr=length(b), nc=length(sigma))
# compute the log.likelihood value for each pair of parameters 
for (i in 1:length(b)) {
  for (j in 1:length(sigma)) {
    log.like.value[i,j] <- 
      regression.no.intercept.log.likelihood(parm = c(b[i],sigma[j]), dat = recap.data)
  }
}
rel.log.like.value <- log.like.value - M1$value
persp(b, sigma, rel.log.like.value, theta = 30, phi = 20,
      xlab = "b", ylab = "sigma", zlab = "rel.log.likelihood.value",
      col = "grey")
# How about a contour plot>
contour(b,sigma,rel.log.like.value,xlab='b',
        ylab='sigma',xlim = c(2.5,3.9),ylim = c(2.0,4.3),
        levels = c(-1:-5,-10), cex=2)
# draw a cross to indicate the maximum
points(M1$par[1], M1$par[2],pch=3)
# draw the -1.92 line(circle) on the contour map
coutour.line <- contourLines(b, sigma, rel.log.like.value, levels = -1.92)[[1]]
lines(coutour.line$x, coutour.line$y, col = 'red', lty = 2, lwd = 2)
##########################
########################## back to the rabbit data
# optim() for two-dimensional parameter space, b and sigma
# with hessian matrix
result <- optim(par = c(1,1), regression.no.intercept.log.likelihood,
                method = "L-BFGS-B",
                lower = c(-1000, 0.0001), upper = c(1000,10000),
                control = list(fnscale = -1), dat = recap.data, hessian = TRUE)
result$hessian # variance-covariance matrix is the negative of the inverse of he hessian matrix
# by solve() function
var.cov.matrix <- (-1)*solve(result$hessian)
var.cov.matrix # it's the variance-covariance structure fo (b\hat, theta\hat)
