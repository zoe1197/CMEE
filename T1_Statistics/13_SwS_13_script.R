## Statistics with Sparrows - 13
rm(list = ls())
dev.off()

# read the data
data <- read.delim("13_Wylde_single.mounted.txt", header = T)
head(data)
# loading the package
library(lme4)

# investigate the repeatability of Femur length:
lmm1<-lmer(Femur_length~1+(1|ID), data)
summary(lmm1)
r <- 1.2570822/(1.2570822+0.0003399) # variance[1]/(variance[1]+variance[2])
