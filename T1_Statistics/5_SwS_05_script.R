### SwS 05 ###
# 
# Learning aims
# •Understand that effect size is most important when comparing means estimates
# •Get insight into why the p-value is only secondary
# •Learn how to execute a t-test
# •Learn how to judge the biological significance of the results
# •Apply the effect of sample size on mean estimate precision




# 1) Test if wing length in 2001 differs from the grand-total mean. 
# Test if male and female wing length differ in 2001. 
# Test if male and female wing length differ in the full dataset. 
# Test if male and female tarsus differs in the full dataset. 
# Report all your results in a table and share with your group. 
# Discuss what and how to present. 
# Explore different table options and find at least two different 
# ways of presenting your results in a table. 
# 
d$Q1Year <- d$Year==2001
Q1 <- t.test(d$Wing~d$Q1Year)
Q1


# 2) Now, run a batch of tests - check for each year whether any of 
# the measures differs from the grand total mean.
# Upload one word document per group for (2). In this word document, 
# present the results from (2) using what you’ve learned in (1), 
# in a delightful and easy to understand way, as you would in a 
# scientific publication. One word document per group to upload.
#
# 3) (not compulsory but will improve your skills immensely) 
# Then, see if you understand how to employ the t.test properly in R. 
# There are eleven cohorts (years) in this dataset. Test whether the 
# first five years differ in terms of Tarsus, Mass, Wing, and Bill from 
# the latter six years. To do this, you will first need to create a 
# two-level variable that denotes to wich group a certain observation 
# belongs. Then you can test against this. Do it in two ways - 
# once with , and once with ~.
# To do that you will have to re-arrange the data, which might be tricky 
# and take quite some of your time, a lot of brain power, and a lot 
# of de-bugging! All this is something you will need to do quite often 
# over the course of this year. So do try to wrap your head around it. 
# Use all your mighty plyr functions for this. There will be various, 
# vastly different solutions for this one - as long as the end result is 
# the same, that’s perfectly fine.
# Call on your group for help. Discuss your possible solutions in your 
# group, and later on the online discussion board.




rm(list = ls())
graphics.off()


d <- read.table("5_SparrowSize.txt", header = TRUE)
boxplot(d$Mass~d$Sex.1, col = c('red', 'blue'), ylab = 'Body mass (g)')
t.test1 <- t.test(d$Mass~d$Sex.1)
t.test1

d1 <- as_data_frame(head(d,50))
length(d1$Mass)
t.test2 <- t.test(d1$Mass~d1$Sex)
t.test2
