rm(list = ls())
graphics.off()


# beta-binomial model of allele frequencies
p <- seq(0,1,0.01)



# A)
k1 <- 40
n1 <- 200
alpha1 <- k1+1
beta1 <- n1-k1+1
# calculate the beta likelihood (posterior probability)
beta_likelihood1 <- dbeta(p, shape1 = alpha1, shape2 = beta1)
# plot the beta function likelihood corresponding to p value
plot(p, beta_likelihood1, type = 'l', xlab = 'Frequency of G', ylab = 'Posterior dentisy(pdf)')
# calculate notable quantiles of beta function
qbeta(p = c(0.025, 0.25, 0.5, 0.75, 0.975), shape1 = alpha1, shape2 = beta1)

# B)
k2 <- 4
n2 <- 20
alpha2 <- k2+0.1
beta2 <- n2-k2+0.1
beta_likelihood2 <- dbeta(p, alpha2, beta2)
points(p, beta_likelihood2, type = 'l', xlab = 'Frequency of G', ylab = 'Posterior density', lty = 2)
qbeta(p=c(0.025, 0.25, 0.5, 0.75, 0.975), alpha2, beta2)


# C)
x <- dbeta(p, 0.1, 0.1)
points(p, x, type = 'l', lty = 3)

M1 <- pbeta(0.5, alpha2, beta2)
M2 <- 1-M1
M1/M2


