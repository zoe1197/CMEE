rm(list = ls())
setwd("~/reviewCMEE/ML")

library(mvtnorm)

# generate the data
set.seed(123)
covariance <- matrix(
  c(5,3,0,-3,0,3,5,0,-3,0, 0,0,5,0,0,-3,-3,0,6,0, 0,0,0,0,3),
  nrow = 5)
data <- rmvnorm(1000, sigma=covariance)
names(data)<- c("a", "b", "c", "d", "e")

# run the analysis
pca <- prcomp(data)
biplot(pca)
biplot(pca, choices=2:3)

pca
plot(pca$x[,2] ~ data[,3], xlab="'c' variable", ylab="PC2")

summary(pca)
plot(pca)

# scale your data
pca <- prcomp(data, scale = TRUE)
biplot(pca)
