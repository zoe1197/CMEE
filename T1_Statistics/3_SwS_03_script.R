#### SwS 03 ####

# Welcome - this is your workspace for hand out SwS 03 #

# Please first work through the hand out using this script #
# Nothing needs to be submitted #



############## Learning aims
# - Understand different data types
# - Understand why continuous data are the most valuable data
# - Understand that non-continuous data has limited value


rm(list = ls())
d <- read.table("3_SparrowSize.txt", header = TRUE)
str(d)
d$BirdIDFact <- as.factor(d$BirdID)
str(d)
plot(d$Mass~as.factor(d$Year), xlab = "Year", ylab = "House Sparrow body mass(g)")
plot(d$Mass~d$Year, xlab = "Year", ylab = "House Sparrow body mass(g)")


b <- read.table("3_BTLD.txt", header = TRUE)
str(b)
mean(b$ClutchsizeAge7, na.rm = TRUE)
plot(b$LD.in_AprilDays.~b$Year, ylab="Laying date (April days)", xlab="Year",
     pch=19, cex=0.3)
plot(b$LD.in_AprilDays.~jitter(b$Year), ylab = "Laying data(April days)", xlab = "Year", pch = 19, cex = 0.1)
require(ggplot2)
ggplot(b,aes(x = Year, y = LD.in_AprilDays.)) +
  geom_violin()
boxplot(b$LD.in_AprilDays.~b$Year, ylab="Laying date (April days)", xlab="Year")
p <- ggplot(b, aes(x = as.factor(Year), y = LD.in_AprilDays.)) +
  geom_violin()
require(Hmisc)
p + stat_summary(fun.data = "mean_sdl", geom = "pointrange")
