#### SwS 01 ####

# Welcome - this is your workspace for hand out SwS 01 #

# Please first work through the hand out using this script #

## Then work in groups to solve the following tasks in this script at first.
## When you have agreed on a solution, make a final solution script for the 
## below and hand that in with your word document. One script and one word 
## document per group.


# 1.	How many repeats are there per bird per year? 
# 2.	How many individuals did we capture per year for each 
#     sex? Compute the numbers, devise a useful table format, and 
#     fill it in.
# 3.	Think about how you can communicate (1) and (2) best 
#     in tables, and how you can visualise (1) and (2) using plots. 
#     Produce several solutions, and discuss in the group which 
#     the pros and cons for each solution to communicate and 
#     visualize the data structure for (1) and (2). 
# 4.	Write and submit two results sections for (1) and (2). 
#     Each result section should use different means of communicating 
#     the results, visually and in a table. Submit 1 word document, and 
#     1 script per group.


rm(list=ls())


# structure
myNumericVector <- c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9)
myCharacterVector <- c("low","low","low","low","high","high","high","high")
myLogicalVector <- c(TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE)
myMixedVector <-c(1, TRUE, FALSE, 3, "help", 1.2, TRUE, "notwhatIplanned")

str(myNumericVector)
str(myCharacterVector)
str(myLogicalVector)
str(myMixedVector)

# install.packages("lme4")
library(lme4)

# entering data
d <- read.table("1_SparrowSize.txt", header = TRUE)
str(d)
head(d)
summary(d)

d$Year
table(d$Year)

table(d$BirdID) #ID VS. capture times
table(table(d$BirdID)) #summary of capture times 
# 2 birds have been captured 12 times
# other way of doing so
require(dplyr)
BirdIDCount <- d %>% count(BirdID, BirdID, sort = TRUE)
BirdIDCount %>% count(n)


length(unique(d$Year))
length(unique(d$BirdID))

################ Excercise ################
# 1.How many repeats are there per bird per year?
PerBirdYear <- d %>% count(BirdID, Year, sort = TRUE)

# 2.How many individuals did we capture per year for each sex?
PerYearSex <- d %>% count(Year, Sex, sort = TRUE)
df %>% group_by(PerYearSex$Sex) 

# 3,4. visualization
require(ggplot2)
ggplot(data = df, aes(x = Year, y = n, fill = Sex)) +
  geom_bar(stat='identity', position='dodge')
