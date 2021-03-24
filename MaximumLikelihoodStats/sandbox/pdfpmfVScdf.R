cdf_7_6 <- (pbinom(q = 7,size = 10,prob = 0.5,log.p = FALSE)-pbinom(q = 6,size = 10,prob = 0.5,log.p = FALSE))
test <- dbinom(x = 7,size = 10,prob = 0.5, log = FALSE)
cdf_7_6
test
