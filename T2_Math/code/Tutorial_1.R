

rm(list = ls())
graphics.off()

# Q_3
# Monod growth function
monod <- function(a,k,N){
  # a,k>0, N>=0 
  return(a*N/(k+N))
}
N <- seq(0,10,0.01)
plot(N, monod(a = 8,k = 1, N), pch = 20, cex = 0.01)
points(N, monod(a = 5, k = 3,N),  pch = 20, cex = 0.01)
points(N, monod(a = 5, k = 1,N),  pch = 20, cex = 0.01)


# Q 4
fx <- function(b,n,x){
  # n:positive inte
  return(x^n/(b^n+x^n))
}
x <- seq(0,10,0.01)
n_1_3 <- list()
#plot.new()
for (n in 1:3) {
  n_1_3 <- append(n_1_3, fx(b = 2, n = n, x = x))
}
df <- t(as.data.frame(n_1_3))
df <- as.data.frame(df)
df$nvalue<- rep(c("1","2","3"), each = 1001)
df$xvalue <- rep(x,3)

library(ggplot2)
ggplot(data = df, aes(x=xvalue, y=V1)) +
  geom_point(aes(colour = nvalue), size = 0.0001) +
  geom_abline(slope = 0, intercept = 0.5) +
  geom_vline(xintercept = 2) +
  geom_hline(yintercept = 1)

# generate different data corresponding to different b
b <- 1:7
b_1_7 <- list()
for (b in 1:7) {
  b_1_7 <- append(b_1_7,fx(b = b, n = 1, x = x))
}
df <- as.data.frame(t(as.data.frame(b_1_7)))
bvalue <- as.character(seq(1:7))
df$bvalue <- rep(bvalue,each = 1001)
df$xvalue <- rep(x,7)
ggplot(data = df, aes(x = xvalue, y = V1)) +
  geom_point(aes(colour = bvalue), size = 0.0001) +
  geom_hline(yintercept = .5)



# Q_5
loglog <- function(){
  return(x^D)
}
logdf <- read.csv("../data/words_moby_dick.csv")
logdf$logx <- log(logdf$occurences)
logdf$logy <- log(logdf$word_label)
model <- lm(data = logdf, logy~logx)
D <- coef(model)[2]
D

# Q8
len <- function(L, k, x){
  return(L*(1-exp(-k*x)))
}
k <- c(1,0.1)
x <- seq(0,100,0.01)
leng <- list()
for (i in k) {
  leng <- append(leng, len(L = 20, k = i, x = x))
}
df <- as.data.frame(t(as.data.frame(leng)))
df$kvalue <- rep(as.character(k), each = length(x))
df$x <- rep(x, 2)
ggplot(data = df, aes(x = x, y = V1)) +
  geom_point(aes(colour = kvalue), size = 0.0001)

# Q_9
ratio1 <- function(x){
  return(exp(x)/x^2)
}
x1 <- seq(0,50, 0.01)
plot(x1, ratio1(x1), cex = 0.01)

ratio2 <- function(x){
  return(exp(x)/x^20)
}
x2 <- seq(0,1000, 0.01)
plot(x2, ratio2(x2), cex = 0.01)

ratio3 <- function(x){
  return(x/log(x))
}
x3 <- seq(0,50, 0.01)
plot(x3, ratio3(x3), cex = 0.01)

x <- seq(0,1000,0.01)
df <- data.frame(x = rep(x, 3), 
                 ratio = rep(c("ratio1", "ratio2", "ratio3"), each = length(x)),
                 y = c(ratio1(x),ratio2(x),ratio3(x)))
ggplot(data = with(df, df[df$ratio == "ratio2",]), aes(x, y)) +
  geom_point(aes(color = ratio), size = 0.00001)


