## SwS 09 ##
# Exercises:
# Upload one word document per group
# 1)	Discuss the questions above with your group, until you find 
#       satisfactory answers.
# 2)	Run a linear model, where you test the hypothesis that sparrows with 
#     bigger bills can eat more. The prediction is that the larger the bill, 
#     the heavier the sparrow.
# Detail what your explanatory and what your response variable is. Write a short (1A4) report on methods and results per group.
#Before you go into the linear model, you should first describe your data, say how many sparrows, how many females and males, whether there is a difference in your response between the sexes. If that difference is meaningful, you should test the sexes separately. Write this section as you would write it for a scientific article. Discuss in the group what should go into the report, and what not. Submit one report per group.

rm(list=ls())
d<-read.table("9_arrowSize.txt", header=TRUE)

plot(d$Mass~d$Bill, ylab="Mass (g)", xlab="Bill (mm)", pch=19, cex=0.4)

x<-c(1:100)
a<-0.5
b<-1.5
y<-b*x+a
plot(x,y, xlim=c(0,100), ylim=c(0,100), pch=19, cex=0.5)

head(d$Mass)
tail(d$Mass)

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)

d1<-subset(d, d$Mass!="NA")
d2<-subset(d1, d1$Tarsus!="NA")
model1<-lm(Mass~Tarsus, data=d2)
summary(model1)
# examing the residuals
hist(model1$residuals)
head(model1$residuals)

model2<-lm(y~x)
summary(model2) # check the R-squared comparing with model1


# about the z-scores
d2$z.Tarsus <- scale(d2$Tarsus)
model13<- lm(Mass~z.Tarsus, data = d2)
summary(model13)

d$Sex<-as.numeric(d$Sex)
plot(d$Wing ~ d$Sex, xlab="Sex", xlim=c(-0.1,1.1), ylab="")
abline(lm(d$Wing ~ d$Sex), lwd = 2)
text(0.15, 76, "intercept")
text(0.9, 77.5, "slope", col = "red")

d4<-subset(d, d$Wing!="NA")
m4<-lm(Wing~Sex, data=d4)
t4<-t.test(d4$Wing~d4$Sex, var.equal=TRUE)
summary(m4)

par(mfrow=c(2,2))
plot(model13)
par(mfrow = c(2,2))
plot(m4)











library(ggplot2)
#intercept is mass for female because f is before m. Bill is 0.9 which is the slope for female, for every 1mm increase in bill mass increases by 0.9 mass. The slope is sign so there is a sig interaction between mass and bill
#2.6 is the intercept for males, to work out slope of male line its 0.9+-0.16= 0.74, this is the slope of the male (0.93-0.74), so for every 1mm increase in bill size in males we get 0.74 increase in mass.
0.9+-0.16
#Bill:sex- this is how much the male and female lines differ, its only -0.16 different
#to work out slope of 
#We can  now predict mass if we know bill length
billplot<-qplot(x=Bill, y=Mass, data=d2, colour=Sex.1)+geom_smooth(method="lm")+geom_point()

##########################################################################

summary(model1)

