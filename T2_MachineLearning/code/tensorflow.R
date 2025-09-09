
rm(list = ls())

# simulate (this time adding noise to the response variable)
exp <- replicate(10, rnorm(400))
resp <- exp[,1]*2-0.5*exp[,2]-exp[,7]*exp[,8]+exp(abs(exp[,3])) +
  rnorm(nrow(exp))
exp <- as.matrix(scale(exp)); resp <- as.numeric(scale(resp))
training <- sample(nrow(exp), nrow(exp)/2)

# get Keras ready
library(tensorflow)
library(keras)


# specific model
medel <- keras_model_sequential()
model %>%
  layer_dense(units = 15, activation = 'relu', input_shape = 10) %>%
  layer_dense(units = 15, activation = 'relu') %>%
  layer_dense(units = 1)


