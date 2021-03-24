

rm(list=ls())
graphics.off()

d <- read.table("12_SparrowSize.txt", header = TRUE)

d1<-subset(d, d$Wing!="NA")
summary(d1$Wing)
hist(d1$Wing)

model1 <- lm(Wing~Sex.1, data = d1)
summary(model1)
boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")
anova(model1)
t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)

# with several groups
boxplot(d$Mass~d$Year)
m2<-lm(Mass~as.factor(Year),data=d)
anova(m2) # anova
summary(m2)
am2<-aov(Mass~as.factor(Year),data=d) # aov
summary(am2)
TukeyHSD(am2) # TukeyHSD
plot(TukeyHSD(am2))

# test more levels
boxplot(d1$Wing~d1$BirdID, ylab = "Wing Length (mm)")
require(dplyr)
tbl_df(d1)
glimpse(d1)
d$Mass %>% cor.test(d$Tarsus, na.rm=TRUE)
d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID))
d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID)) %>%
  count(count)

model3<-lm(Wing~as.factor(BirdID), data=d1)
anova(model3)



## repeatable
d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID))
d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID)) %>%
  count(count)
# CALCULATE n_0
denominator <- d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID)) %>%
  summarise (sum(count)) # the total capture times
numerator <- d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID)) %>%
  summarise (sum(count^2)) # the square of total capture times
numerator / denominator
denominator - numerator/denominator
df <- anova(model3)$Df[1]
n_0 <- (1/df)*(denominator - numerator/denominator)
# calculate S_A^2 & S_W^2
model3<-lm(Wing~as.factor(BirdID), data=d1)
anova(model3)
S_W2 <- MS_W <- anova(model3)[2,3]
MS_A <- anova(model3)[1,3]
S_A2 <- (MS_A-MS_W)/n_0
# CALCULATE repeatability
r <- S_A2/(S_W2+S_A2)
r