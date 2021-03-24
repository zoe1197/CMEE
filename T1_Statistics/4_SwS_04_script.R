#### SwS 04 ####

# Welcome - this is your workspace for hand out SwS 04 #

# Please  work through the hand out using this script #
# Nothing needs to be submitted #


# Note: These exercises are intended to improve your understanding of the statistics, the functions, and improve your ability to problem solve and code.
# 1) Calculate the standard error of Tarsus, Mass, Wing and Bill length of the complete population sample (as opposed to all sparrows in this world) Note N of each. Then, subset the dataset to only 2001 data d1<-subset(d, d$Year==2001), as we did in the lecture. Calculate SE for Tarsus, Mass, Wing and Bill length for the 2001 sample. Calculate the 95% CI for each mean.
# 2) Play around with the last plot we made. Change the values of the simulation. Change the mean, the standard deviation to other values, and see how it affects your plot. Just try out various combinations! This should help you to get better at
# -	Understanding how mean and SE and sample size are linked
# -	Understanding how to plot things in R
# -	Understanding how to use for loops in R
# -	Understanding how to make, access and use variables, vectors and data frames in R
# Note: it is ok if you find this difficult. This is something that you need to do, and do again, and redo again, and the more often you practice this the better you will become at understanding it. So use this time to repeat and practice. 
# Non-compulsory:
#   3) If you found the above easy and want to test out your coding and stats skills, this is a task for you. 
# Sample mass of the whole sparrow dataset. Then produce a plot to see at what sample size the standard error become so small that you’d be confident to get a reasonably precise mean - precise with respect to the grand total mean of the whole dataset. (The next part is rather philosophical). Then look at sample sizes in different years and think about what sort of biological questions one could answer with one year’s data, and what not. 


############### Learning aims
# •To understand the link between the standard error of the mean, and the sample size
# •To understand that standard errors belong to a statistic (typically a mean)
# •To understand that standard errors are a measure of precision


rm(list = ls())
graphics.off()


d <- read.table("4_SparrowSize.txt", header = TRUE)
d1 <- subset(d, d$Tarsus!="NA")
seTarsus <- sqrt(var(d1$Tarsus)/length(d1$Tarsus))
seTarsus

d12001 <- subset(d1, d1$Year == 2001)
seTarsus2001 <- sqrt(var(d12001$Tarsus)/ length(d12001$Tarsus))
seTarsus2001


# show se decrese with sample size increasing
rm(list = ls())
TailLength <- rnorm(130, mean = 3.8, sd = 2)

summary(TailLength)
length(TailLength)
var(TailLength)
sd(TailLength)
hist(TailLength)

x <- 1:length(TailLength)
y <- rep(mean(TailLength), length(TailLength))
plot(x, y, cex = 0.03, xlim = c(0, max(x)), ylim = c(min(TailLength)+2.5, max(TailLength)-3),
     xlab = "Sample Size (n)", ylab = "Mean of tail length ±SE (m)", col = "red")
mu <- rep(mean(TailLength), length(TailLength))
se <- c()
for (i in 1:length(TailLength)) {
  d <- sample(TailLength, i, replace = FALSE)
  se[i] <- sd(TailLength) / sqrt(i)
}
up <- mu+se
down <- mu-se
segments(x, up, x1 = x, y1 = down, lty = 1)


