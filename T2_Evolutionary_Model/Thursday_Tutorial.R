rm(list = ls())
graphics.off()


# 0 < x0 < 1
Time_fix <- function(x0, N){
  return(-2*N*(x0*log(x0)+(1-x0)*log(1-x0)) )
}

time2plot <- c()
x0plot <- seq(0,1,0.01)
for (i in x0plot) {
  time2plot <- append(time2plot, Time_fix(i, 10))
}
plot(x0plot, time2plot, pch = 19)


# Q2
N2plot <- seq(100, 10^8, 1000)
# x0 = 0.01
x_0.01 <- c()
for (i in N2plot) {
  x_0.01 <- append(x_0.01, Time_fix(0.01, i))
}
# x0 = 0.1
x_0.1 <- c()
for (i in N2plot) {
  x_0.1 <- append(x_0.1, Time_fix(0.1, i))
}
# x0 =0.5
x_0.5 <- c()
for (i in N2plot) {
  x_0.5 <- append(x_0.5, Time_fix(0.5, i))
}
# plot
plot(N2plot, x_0.5, cex = 0.1, pch =19)
points(N2plot, x_0.1, cex = 0.1, pch = 19)
points(N2plot, x_0.01, cex = 0.1, pch = 19)


# Q3
tao <- function(N){
  return(2*log(N))
}
Q3 <- c()
proxi <- c()
for (i in N2plot) {
  Q3 <- append(Q3,Time_fix(x0 = 1/i, i)) 
  proxi <- append(proxi, tao(i))
}
plot(N2plot, Q3, pch = 19, cex = 0.1)
points(N2plot, proxi, pch = 19, cex = 0.1)


# if a mutant is under selection tao~1/2s
tao_est <- function(s){
  return(1/(2*s))
}

