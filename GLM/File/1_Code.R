

d <- read.table("../data/SparrowSize.txt", header = TRUE)
str(d)
names(d)
head(d)



# 1. Centrality and spread
hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey")
mean(d$Tarsus, na.rm = TRUE)
var(d$Tarsus, na.rm = TRUE)
sd(d$Tarsus, na.rm = TRUE)

hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey",
     prob=TRUE) # this argument tells R to plot density instead of frequency, you can see that on the y-axis
lines(density(d$Tarsus,na.rm=TRUE), # density plot
      lwd = 2)
abline(v = mean(d$Tarsus, na.rm = TRUE), col = "red",lwd = 2)
abline(v = mean(d$Tarsus, na.rm = TRUE)-sd(d$Tarsus, na.rm = TRUE), col = "blue",lwd = 2, lty=5)
abline(v = mean(d$Tarsus, na.rm = TRUE)+sd(d$Tarsus, na.rm = TRUE), col = "blue",lwd = 2, lty=5)

t.test(d$Tarsus~d$Sex)
