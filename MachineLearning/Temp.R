
# what is "with"
with(mtcars, mpg[cyl == 8  &  disp > 350])
# is the same as, but nicer than
mtcars$mpg[mtcars$cyl == 8  &  mtcars$disp > 350]

test <- matrix(data = seq(1:100), nrow = 10, ncol = 10)
test <- as.data.frame(test)
names(test) <- letters[1:10]
test


with(test, a*3)
test$new[test$a>3] <- with(test[test$a>3,], b*2)

