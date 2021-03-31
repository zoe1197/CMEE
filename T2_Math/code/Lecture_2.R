rm(list = ls())
graphics.off()

# Q1
PP_qua <- function(R, w, t, fi){
  xt = R*cos(w*t-fi)
  yt = R*sin(w*t-fi)
  return(c(xt, yt))
}

# Q_a
# time_a <- c(0,1,2,3,8)
# plot(0, pch = 20, xlab = 'prey', ylab = 'predator', 
#      xlim = c(-1.2,1.2), ylim = c(-1.2,1.2))
# for (i in time_a) {
#   print(i)
#   pop <- PP_qua(R = 1, w = pi/4, t = i, fi = 0)
#   points(pop[1], pop[2], pch = 20)
# }
# text(pop[1], pop[2])

# Q_b
time_b <- seq(0,10,0.01)
plot(0, pch = 20, xlab = 'time', ylab = 'predator/prey', 
     xlim = c(-.5,11), ylim = c(-1.2,1.2))
for (j in time_b) {

  pop <- PP_qua(R = 1, w = pi/4, t = j, fi = 0)
  points(j, pop[1], pch = 20, cex = 0.1, col = 'red')
  points(j, pop[2], pch = 20, cex = 0.1, col = 'blue')
}


# Q_c
time_b <- seq(0,10,0.01)
plot(0, pch = 20, xlab = 'time', ylab = 'predator/prey', 
     xlim = c(-.5,11), ylim = c(-1.2,1.2))
for (j in time_b) {
  
  pop <- PP_qua(R = 1, w = pi/4, t = j, fi = pi/4)
  points(j, pop[1], pch = 20, cex = 0.1, col = 'red')
  points(j, pop[2], pch = 20, cex = 0.1, col = 'blue')
}

# Q_e
fi <- function(fi){
  return(tan(-fi))
}
fi_plot <- seq(-pi,6*pi,0.01)
plot(0, ylim = c(-pi-0.3,6*pi+0.3), xlim = c(-1.2,1.2))
for (k in fi_plot) {
  points(fi(k), k, pch = 20, cex = 0.1)
} 


# Q_g
Q_g <- function(R, w, t, fi){
  xt = R*cos(w*t-fi)
  yt = R*sin(w*t-fi)
  return(xt^2+yt^2)
}
t_q <- seq(0,10,0.01)
plot(0, ylim = c(-pi-0.3,6*pi+0.3), xlim = c(-.2,12))
for (g in t_q) {
  points(g, Q_g(R = 1, w = pi, t = g, fi = 0), pch = 20, cex = 0.1, col = 'red')
  points(g, Q_g(R = 2, w = pi, t = g, fi = 0), pch = 20, cex = 0.1, col = 'blue')
}
