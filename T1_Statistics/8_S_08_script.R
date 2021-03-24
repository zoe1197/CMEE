## SwS_08 ##
# Exercises
# (no uploads)
# 1)	Run the code you find under “examples” in the help file for lm
# 2)	Look through the helpfile for runif and see if you understand it.
# 3)	Increase and decrease the size of the random noise you add to the data, 
#     and see what it does to your linear model estimates! This will help you 
#     better understand the concepts behind it, and also help you to better 
#     interpret results. Further, I hope this will help you to use this tool 
#     (making up data where you know what the result should be like, and then 
#     analysing it) to better understand statistics. 
# 4)	Run the example code from the helpfile for runif and see if you can 
#     understand it.


rm(list=ls())
x<-c(1,2,3,4,8)
y<-c(4,3,5,7,9)
x
mean(x)
var(x)
y
mean(y)
var(y)

?lm
model1 <- lm(y~x)
model1
summary(model1)

##################
df <- data.frame(x,y)
require(ggplot2)
ggplot(df, aes(x= x, y = y)) +
  geom_point() +
  stat_smooth(method = lm)
##################

coefficients(model1)
resid(model1)

plot(y~x, pch=19, xlim=c(0,8.5), ylim=c(0,9.5))
segments(0,-30,0,30, lty=3)
segments(-30,0,30,0,lty=3)

x<-seq(from=-10, to=10, by=0.2)
x
y<- 7.1-0.2 * x
y
summary(lm(y~x))
plot(y~x)
y<- 7.1-0.2 * x + runif(length(x))
summary(lm(y~x))
residuals(lm(y~x))
quantile(residuals(lm(y~x)))
