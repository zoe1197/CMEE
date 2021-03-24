

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
