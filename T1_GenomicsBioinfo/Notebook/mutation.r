# mutation rate
mu <- 1e-2
# over 1000 generations
fA <- rep(NA, 1000)
# starting allele frequency is 0
fA[1] <- 0

for (t in 1:999) fA[t+1] <- fA[t] + mu*(1-fA[t])

plot(x=1:1000, y=fA, type="l", xlab="generations", lty=1, ylim=c(0,1), ylab="Allele frequency")
lines(x=1:1000, y=1-fA, lty=2)

# mutation rates
mu_aA <- 1e-2
mu_Aa <- 1e-2
# over 1000 generations
fA <- rep(NA, 1000)
# starting allele frequency
fA[1] <- 0

for (t in 1:999) fA[t+1] <- (1-mu_Aa)*fA[t] + mu_aA*(1-fA[t])

plot(x=1:1000, y=fA, type="l", lty=1, ylim=c(0,1), ylab="Allele frequency", xlab="generations")
lines(x=1:1000, y=1-fA, lty=2)

mu_aA <- 2e-2
mu_Aa <- 1e-2
fA <- rep(NA, 1000)
fA[1] <- 0

for (t in 1:999) fA[t+1] <- (1-mu_Aa)*fA[t] + mu_aA*(1-fA[t])

plot(x=1:1000, y=fA, type="l", lty=1, ylim=c(0,1), ylab="Allele frequency", xlab="generations")
lines(x=1:1000, y=1-fA, lty=2)
cat("final frequency:", fA[length(fA)])
