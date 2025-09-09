
rm(list = ls())

# draw species' parameters
intercepts <- rnorm(20, mean = 20)
env1 <- rnorm(20)
env2 <- rnorm(20)

# create environment
env <- expand.grid(env1=seq(-3,3,.5), env2=seq(-3,3,.5))
biomass <- matrix(ncol = 20, nrow = nrow(env))
for (i in seq_len(nrow(biomass))) {
  biomass[i,] <- intercepts + env1*env[i,1] + env2*env[i,2]
}

# PCoA
library(vegan)
dist <- dist(biomass)
pcoa <- cmdscale(dist, eig = TRUE)
barplot(pcoa$eig)

# plot
plot(pcoa$points[,1:2], xlab = "PCoA1", ylab = "PCoA2")
plot(pcoa$points[,1:2], type = "n", xlab = "PCoA1", ylab = "PCoA2")
text(pcoa$points[,1:2]+.25, labels = env[,1], col = "red")
text(pcoa$points[,1:2]-.25, labels=env[,2], col="black")

