## SwS_11 ##


rm(list = ls())
daphnia <- read.delim("11_daphnia.txt")
summary(daphnia)

# 1.Outliers
par(mfrow = c(1,2))
plot(Growth.rate ~ as.factor(Detergent), data = daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia)

# 2. Homogneity of variance
require(dplyr)
daphnia %>%
  group_by(Detergent) %>%
  summarise(variance = var(Growth.rate))
daphnia %>%
  group_by(Daphnia) %>%
  summarise(variance = var(Growth.rate))

dev.off()
hist(daphnia$Growth.rate)

seFun <- function(x) {
  sqrt(var(x)/length(x))
}
# calculate the mean of each detergent using tapply
detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                      FUN = mean))
detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                     FUN = seFun))
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean))
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

dev.off()
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids <- barplot(detergentMean, xlab = "Detergent type", 
                   ylab = "Population growth rate", ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, 
       detergentMean + detergentSEM, code = 3, angle = 90)
barMids <- barplot(cloneMean, xlab = "Daphnia clone", 
                   ylab = "Population growth rate",ylim = c(0, 5))
arrows(barMids, cloneMean - cloneSEM, barMids, 
       cloneMean + cloneSEM, code = 3, angle = 90)

# the linear model
daphniaMod <- lm(Growth.rate~Detergent + Daphnia, data = daphnia)
summary(daphniaMod)
# the ANOVA model
daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)
?aov
# Tukey HSD using result from anova model
daphniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphniaModHSD
par(mfrow = c(2,1), mar = c(4,4,2,2))
plot(daphniaModHSD)
par(mfrow = c(2,2))
plot(daphniaMod)


##################### Multiple Regression #####################
timber <- read.delim("11_timber.txt")
summary(timber)
# 1. Outliers
par(mfrow = c(2,2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)
# 2.Homogeneity of variance
var(timber$volume)
var(timber$girth)
var(timber$height)

t2<-as.data.frame(subset(timber, timber$volume!="NA"))
t2$z.girth<-scale(timber$girth)
t2$z.height<-scale(timber$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)
# 3. Are the data normally distributed?
par(mfrow = c(2, 2))
hist(t2$volume)
hist(t2$girth)
hist(t2$height)
# 4: Are there excessively many zeroes?
# Nope.
# 5: Is there collinearity among the covariates?
# Uh. This is a nice one.
pairs(timber)
cor(timber)
summary(lm(girth ~ height, data = timber))
VIF<- 1/(1-0.27)
VIF
sqrt(VIF) #The standard errors of girth are thus inflated by 1.17

pairs(timber)
cor(timber)
pairs(t2)
cor(t2)
# 6: Visually inspect relationships
# 7: Consider interactions?
timberMod <- lm(volume ~ girth + height, data = timber)
# aov(volume ~ girth + height, data = timber)
anova(timberMod)
summary(timberMod)
plot(timberMod)
