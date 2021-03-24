#######################
# Chapter 2 ###########
#######################

#######################
# PCA 
library(mvtnorm)
set.seed(123)
covariance <- matrix(c(5,3,0,-3,0, 3,5,0,-3,0, 0,0,5,0,0,
                       -3,-3,0,6,0, 0,0,0,0,3), nrow=5)
data <- rmvnorm(1000, sigma=covariance)
names(data) <- c("a", "b", "c", "d", "e")

pca <- prcomp(data)
biplot(pca)
biplot(pca, choices=2:3)

pca
plot(pca$x[,2] ~ data[,3], xlab="'c' variable", ylab="PC2")

summary(pca)
plot(pca)

pca <- prcomp(data, scale=TRUE)

#######################
# NMDS
# Draw species' parameters
intercepts <- rnorm(20, mean=20)
env1 <- rnorm(20)
env2 <- rnorm(20)

# Create environment
env <- expand.grid(env1=seq(-3,3,.5), env2=seq(-3,3,.5))
biomass <- matrix(ncol=20, nrow=nrow(env))
for(i in seq_len(nrow(biomass)))
    biomass[i,] <- intercepts + env1*env[i,1] + env2*env[i,2]

library(vegan)
dist <- dist(biomass)
pcoa <- cmdscale(dist, eig=TRUE)
barplot(pcoa$eig)

plot(pcoa$points[,1:2], xlab="PCoA1", ylab="PCoA2")
plot(pcoa$points[,1:2], type="n", xlab="PCoA1", ylab="PCoA2")
text(pcoa$points[,1:2]+.25, labels=env[,1], col="red")
text(pcoa$points[,1:2]-.25, labels=env[,2], col="black")

nmds <- metaMDS(dist)
plot(nmds)
stressplot(nmds)

mantel(dist, dist(env[,1]))
mantel(dist, dist(env))

#######################
# Quantile regression
library(quantreg)
data <- data.frame(dist=as.numeric(dist),
                   env1=as.numeric(dist(env[,1])), env2=as.numeric(dist(env[,2])))
model <- rq(dist ~ env1 + env2, data=data)
summary(model)


simple.eh <- rq(dist ~ env1, data=data)
with(data, plot(dist ~ env1, pch=20,
                xlab="Environmental distance", ylab="Site similarity"))
abline(simple.eh, col="red", lwd=3)


#######################
# Exercises

library(raster)
r <- getData("worldclim",var="bio",res=10)
e <- extent(150,170,-60,-40)
data <- data.frame(na.omit(extract(r, e)))
names(data) <- c("temp.mean","temp.diurnal.range", "isothermality",
                 "temp.season","max.temp","min.temp","temp.ann.range","temp.wettest",
                 "temp.driest","temp.mean.warmest","temp.mean.coldest","precip",
                 "precip.wettest.month","precip.driest","precip.season",
                 "precip.wettest.quarter","precip.driest.quarter",
                 "precip.warmest","precip.coldest")

# Load the data in
comm <- as.matrix(read.table("hot-sites.txt"))
site.data <- read.table("site-data.txt")
# Build datasets of distances for quantile regression
dist.data <- with(site.data, data.frame(
                                 dist=as.numeric(your.distance.matrix),
                                 temp=as.numeric(dist(temp)),
                                 groups=as.numeric(dist(outer(groups, groups, `==`), method="binary"))
                             ))
# Color plots of data according to a categorical variable
some.plot.function(some.data, col=ifelse(groups=="hot", "red", "blue"))


#######################
# Chapter 3 ###########
#######################

#######################
# Hierarchical
data <- data.frame(rbind(
    cbind(rnorm(50),rnorm(50)),
    cbind(rnorm(50,5), rnorm(50,5)),
    cbind(rnorm(50,-5), rnorm(50,-5))
))
data$groups <- rep(c("red","blue","black"), each=50)
names(data)[1:2] <- c("x","y")
with(data, plot(y ~ x, pch=20, col=groups))

distance <- dist(data[,c("x","y")])
upgma <- hclust(distance, method="average")
plot(upgma)
comp.link <- hclust(distance)
plot(comp.link)

cut.by.groups <- cutree(upgma, k=2)
cut.by.height <- cutree(upgma, h=8)

install.packages("paran")
install.packages("ape")
install.packages("splits", repos="http://R-Forge.R-project.org")
library(splits)
gap.stat <- ddwtGap(data[,c("x","y")])
with(gap.stat, plot(colMeans(DDwGap),pch=15,type='b',
                    ylim=extendrange(colMeans(DDwGap),f=0.2),
                    xlab="Number of Clusters", ylab="Weighted Gap Statistic"))
gap.stat$mnGhatWG


#######################
# KMeans (and model-based)

data <- data.frame(rbind(
    cbind(rnorm(50),rnorm(50)),
    cbind(rnorm(50,2.5),rnorm(50,2.5)),
    cbind(rnorm(50,-2.5),rnorm(50,-2.5)),
    cbind(rnorm(50,5), rnorm(50,5)),
    cbind(rnorm(50,-5), rnorm(50,-5))
))
data$groups <- rep(c("red","blue","grey80","grey60","grey20"), each=50)
names(data)[1:2] <- c("x","y")
with(data, plot(y ~ x, pch=20, col=groups))

k.means <- kmeans(data[,-3], centers=5, nstart=10)
table(k.means$cluster, data$groups)

library(splits)
gap.stat <- ddwtGap(data[,c("x","y")])
with(gap.stat, plot(colMeans(DDwGap),pch=15,type='b',
                    ylim=extendrange(colMeans(DDwGap),f=0.2),
                    xlab="Number of Clusters", ylab="Weighted Gap Statistic"))
gap.stat$mnGhatWG

library(fclust)
fuzzy <- FKM(data[,c("x","y")], k=5)
# Get lots of summary statistics
summary(fuzzy)
# Plot the predictions out
plot(fuzzy)

library(mclust)
model <- Mclust(data[,-3])
summary(model)
model
plot(model, what="BIC")


#######################
# Exercises

library(cluster)
votes <- na.omit(cluster::votes.repub)
logit <- function(x) log(x / (1-x))
transformed <- logit(votes/100)



#######################
# Chapter 4 ###########
#######################
rm(list = ls())
graphics.off()
#######################
# Regression trees

# Build model of species diversity
data <- expand.grid(temperature=seq(0,40,4), humidity=seq(0,100,10), carbon=seq(1,10,1), herbivores=seq(0,20,2))
data$plants <- runif(nrow(data), 3, 5)
data$plants <- with(data, plants + temperature * .1)
data$plants[data$humidity > 50] <- with(data[data$humidity > 50,],
                                        plants + humidity * .05)
data$plants[data$carbon < 2] <- with(data[data$carbon < 2,], plants - carbon)
data$plants <- with(data, plants + herbivores * .1)
data$plants[data$herbivores > 5 & data$herbivores < 15] <-
    with(data[data$herbivores > 5 & data$herbivores < 15,], plants - herbivores * .2)
# Draw random data from Poisson based on this
for(i in seq_len(nrow(data)))
    data$plants[i] <- rpois(1, data$plants[i])

library(tree)
# Pick some training data and then fit a model to it
training <- sample(nrow(data), nrow(data)/2)
model <- tree(plants~., data=data[training,])
# Examine the model
plot(model)
text(model)
# Look at the statistics of the model
model
summary(model)

# Check performance outside training set
cor.test(predict(model, data[-training,]), data$plants[-training])
# Check cross-validation of model
plot(cv.tree(model))

library(randomForest)
model <- randomForest(plants~., data=data[training,], mtry=ncol(data)-1)
cor.test(predict(model, data[-training,]), data$plants[-training])

model <- randomForest(plants~., data=data[training,], importance=TRUE)
importance(model)
cor.test(predict(model, data[-training,]), data$plants[-training])

library(gbm)
model <- gbm(plants~., data=data[training,], distribution="poisson")
summary(model)
# A plot of variable importance should also have appeared now
faster.model <- gbm(plants~., data=data[training,], distribution="poisson", shrinkage=.1)

#######################
# Lasso regression

explanatory <- replicate(1000, rnorm(1000))
response <- explanatory[,123]*1.5 -explanatory[,678]*.5

library(lars)
model <- lars(explanatory, response, type="lasso")
plot(model)

signif.coefs <- function(model, threshold=0.001){
    coefs <- coef(model)
    signif <- which(abs(coefs[nrow(coefs),]) > threshold)
    return(setNames(coefs[nrow(coefs),signif], signif))
}
signif.coefs(model)

model <- lars(explanatory, response, type="lar")
plot(model)
signif.coefs(model)

bad.model <- lars(explanatory, response, type="lar", normalize=FALSE)
signif.coefs(bad.model, thresh=0) # Wow what a lot of coefficients!
signif.coefs(model, thresh=0)     # Nothing wrong here :D


#######################
# SVM

x <- replicate(2, rnorm(1000))
y <- (rowSums(x) > (median(rowSums(x)) - 1)) & (rowSums(x) < (median(rowSums(x)) + 1))
data <- data.frame(y, x)
with(data, plot(x, pch=20, col=ifelse(y, "red", "black")))

library(e1071)
training <- sample(nrow(data), nrow(data)/2)
model <- svm(y~., data=data[training,], type="C")
plot(model, data[training,])

table(predict(model, data[-training,]), data$y[-training])

tune(svm, train.x=data[training,-1], train.y=data$y[training], 
     ranges=list(cost=c(1,10), gamma=c(.5,1,10)))


#######################
# Exercises

plot(model, iris, Sepal.Length ~ Sepal.Width, slice=
                                                  list(Petal.Width=median(iris$Petal.Width),Petal.Length=median(iris$Petal.Length))
     )



#######################
# Chapter 5 ###########
#######################

#######################
# Notes
x <- rnorm(1000)
y <- -x
data <- data.frame(scale(cbind(x,y)))
library(neuralnet)
model <- neuralnet(y ~ x, hidden=0, data=data)
plot(model)

explanatory <- data.frame(replicate(10, rnorm(400)))
names(explanatory) <- letters[1:10]
response <- with(explanatory, a*2 -0.5*b - i*j + exp(abs(c)))
data <- data.frame(scale(cbind(explanatory,response)))

training <- sample(nrow(data), nrow(data)/2)
model <- neuralnet(response~a+b+c+d+e+f+g+h+i+j,
                   dat=data[training,], hidden=5)
cor.test(compute(model, data[-training,1:10])$net.result[,1],
         data$response[-training])
plot(model)

library(NeuralNetTools)
garson(model, bar_plot=FALSE)
garson(model)

#######################
# Chapter 5 Exercise  #
#######################
data <- read.csv("data/winequality-red.csv", header = TRUE, sep = ';')
# single layer
library(neuralnet)
model <- neuralnet(data = data, hidden = 0, formula = quality~alcohol)
plot(model)
training <- sample(nrow(data), nrow(data)/2)
model <- neuralnet(data = data[training,], 
                   quality ~ fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+free.sulfur.dioxide+total.sulfur.dioxide+density+pH+sulphates+alcohol,
                   hidden = 11)
plot(model)

#######################
# Chapter 6 ###########
#######################

#######################
# Notes

# Simulate (this time adding noise to the response variable)
exp <- replicate(10, rnorm(400))
resp <- exp[,1]*2 -0.5*exp[,2] - exp[,7]*exp[,8] + exp(abs(exp[,3])) + rnorm(nrow(exp))
# Scale data and making training subset
exp <- as.matrix(scale(exp)); resp <- as.numeric(scale(resp))
training <- sample(nrow(exp), nrow(exp)/2)

# Get Keras ready
library(keras)
install_keras()

# Specific model  
model <- keras_model_sequential() 
model %>% 
    layer_dense(units = 15, activation = 'relu', input_shape=10) %>%
    layer_dense(units = 15, activation = 'relu') %>% 
    layer_dense(units = 1)

# Compile model
model %>% compile(
              loss = 'mean_squared_error',
              optimizer = optimizer_rmsprop(),
              metrics = c('mean_squared_error')
          )
# Train model with data
model %>% fit(exp[training,], resp[training], epoch=500)

model %>% fit(
              exp[training,], resp[training], epoch=500,
              callbacks = callback_tensorboard("result")
          )
tensorboard("result")

#######################
# Chapter 6 Exercise  #
#######################
data <- read.csv("data/boardgames-continuous.csv", row.names = 1, as.is = TRUE)
with(data, plot(rating ~ year))
response <- data$rating
explanatory <- as.matrix(scale(data[,-1]))
ncol(explanatory)

training <- sample(nrow(explanatory), nrow(explanatory)/2)
model <- keras_model_sequential()
model %>%
    layer_dense(units = 10, activation = 'relu', input_shape = 11) %>%
    layer_dense(units = 10, activation = 'relu') %>%
    layer_dense(units = 1)
# compile model
model %>% compile(

    loss = 'mean_squared_error',
    optimizer = optimizer_rmsprop(),
    metric = c('mean_squared_error')
)
# train model with data
model %>% fit(explanatory[training, ], response[training], epoch = 500)
# validate the model in independent test data
plot(predict(model, explanatory[-training, ])[,1]~response[-training])
cor.test(predict(model, explanatory[-training, ])[,1], response[-training])


#######################
# Chapter 7 ###########
#######################

#######################
# Notes

# Setup
library(keras)
# install_keras()

# Load data
raw.data <- dataset_fashion_mnist()
resp <- raw.data$train$y
exp <- raw.data$train$x

# Do a bit of renaming and scaling, and plot for sense
lookup <- c("T-shirt/top", "Trouser", "Pullover", "Dress",
            "Coat", "Sandal", "Shirt", "Sneaker", "Bag", "Ankle boot")
exp <- exp / 255
par(mfrow=c(5,5))
for(i in seq_len(5*5))
    image(t(exp[i,28:1,]), main=lookup[resp[i]+1], col=grey.colors(255))
# ... the images are upside-down, hence the 28:1 statemnt,
# ... and R needs matrices rotated to plot, hence the use of *t*ranspose
# ... and keras needs labels (resp) to start at 0, hence +1


# Define model
model <- keras_model_sequential()
model %>%
    layer_flatten(input_shape = c(28, 28)) %>%
    layer_dense(units = 128, activation = 'relu') %>%
    layer_dropout(rate = 0.5) %>% 
    layer_dense(units = 10, activation = 'softmax')

# Compile model
model %>% compile(
              optimizer = 'adam', 
              loss = 'sparse_categorical_crossentropy',
              metrics = c('accuracy')
          )

# Fit model and independently validate
model %>% fit(exp, resp, epochs = 5)
test.resp <- raw.data$test$y
test.exp <- raw.data$test$x
test.exp <- test.exp/255
model %>% evaluate(test.exp, test.resp)
predictions <- model %>% predict(test.exp)
table(apply(predictions, 1, which.max)-1, test.resp)

# Model specification
conv <- keras_model_sequential() %>%
    layer_conv_2d(filters = 20, kernel_size = c(3,3), activation = 'relu',
                  input_shape = c(28,28,1)) %>% 
    layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
    #layer_dropout(rate = 0.25) %>% 
    layer_flatten() %>% 
    layer_dense(units = 20, activation = 'relu') %>% 
    layer_dense(units = 10, activation = 'softmax') %>%
    compile(
        optimizer = 'adam', 
        loss = 'sparse_categorical_crossentropy',
        metrics = c('accuracy')
    )

# Re-arrange data and fit model
array.exp <- array(exp, dim=c(dim(exp), 1))
conv %>% fit(array.exp, resp, epochs = 10)

# (If you want to subset the data a bit more, try)
subset.exp <- exp[1:500,,]
s.array.exp <- array(subset.exp, dim=c(dim(subset.exp), 1))
conv %>% fit(s.array.exp, resp[1:500], epochs = 10)
# Much faster!

new <- keras_model_sequential() %>%
    conv() %>%
    layer_dense(units = 10, activation = "softmax") %>%
    compile(
        optimizer = 'adam', 
        loss = 'sparse_categorical_crossentropy',
        metrics = c('accuracy')
    )

new %>% fit(s.array.exp, resp[1:500], epochs = 10)

# Freeze the whole thing
freeze_weights(conv)

# freeze_layers(conv) 
# the original code from will which doesn't work

# ...or...
# Look at the model to figure out the layer names
conv
# Selectively unfreeze the last layer (your layer name will vary slightly)
#freeze_layers(conv, from="dense_2") ### doesn't work as the last one
freeze_weights(conv, from = "dense_2")

# Re-compile the model (you must do this before use after any freezing or unfreezing)
new %>% compile(
            optimizer = 'adam', 
            loss = 'sparse_categorical_crossentropy',
            metrics = c('accuracy')
        )
# ...if you've taken my programming class, you might be surprised that we don't have to
# ...re-compile conv here. Remember TensorFlow is a Python library - call by name
# ...is going on here, and so freeze_layers has done the work there for us already

# Let's do 20 training epochs
for(i in 1:20){
    # Randomly alter the training data
    augmented <- array.exp + rnorm(length(as.numeric(exp)), sd=.1)
    # Train once on new data
    conv %>% fit(augmented, resp, epochs=1)
}


#######################
# Exercises

library(keras)
mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y


#######################
# Chapter 8 ###########
#######################

#######################
# Notes

# Get Keras ready
library(kerasR)
install_keras()

# Simulate a time series (y) with first-order autocorrelation
y <- rep(0, 101)
for(i in seq(2, length(y)))
    y[i] <- y[i-1] + rnorm(1)
y <- as.numeric(scale(y))
# ... why are we scaling the variable?

# Make a predictor variable that is the previous time-step (x)
#   and then split into training/test data
x <- y[1:100]
x_train <- array(t(matrix(x[1:50], 5, 10)), dim=c(10,5,1))
x_test <- array(t(matrix(x[51:100], 5, 10)), dim=c(10,5,1))
y_train <- y[seq(6,51, by=5)]
y_test <- y[seq(56,101, by=5)]
# ... note we are using arrays, grouping our data into runs of
#     5 sequential points, with 10 training/test replicates,
#     and an overall dimension of 1 (i.e., a single variable)

# Build the model itself - spot the RNN layer!...
model <- keras_model_sequential() %>%
    layer_dense(input_shape=c(5,1), units=5) %>%
    layer_simple_rnn(units=5) %>%
    layer_dense(units=1)

# Train the model
model %>%
    compile(
        loss = "mean_squared_error",
        optimizer = optimizer_rmsprop(),
        metrics = list("mean_squared_error")
    )

# Let store the training data so that we can...
history <- model %>% fit(
                         x_train, y_train, epochs = 500
                     )
# ...plot it out, along with model predictions
plot(history)
plot(predict(model, x_test)[,1] ~ y_test)

# Simulate data and verify they have one major axis
pc1 <- rnorm(100)
xs <- replicate(10, pc1+rnorm(100, sd=.2))
biplot(prcomp(xs, scale=TRUE))

# Build our autoencoder (from scratch)
# - Note I have labelled the layer with the encoder
autoenc <- keras_model_sequential() %>%
    layer_dense(input_shape=10, units=5) %>%
    layer_dense(units=1, name="auto-encoder-layer") %>%
    layer_dense(units=5) %>%
    layer_dense(units=10)

# Fit autoencoder
autoenc %>%
    compile(
        loss = "mean_squared_error",
        optimizer = optimizer_rmsprop(),
        metrics = list("mean_squared_error")
    ) %>%
    fit(xs, xs, epochs=100)

# Extract the output from the autoencoder layer
out.autoenc <- get_layer(autoenc, "auto-encoder-layer")$output
t.autoenc <- keras_model(inputs=autoenc$input, outputs=out.autoenc)
est.pc1 <- predict(t.autoenc, xs)

# Verify that we've found the major axis
plot(est.pc1 ~ pc1)
cor.test(est.pc1, pc1)


#######################
# Exercises

library(tidyquant)
apple <- getSymbols("AAPL", from="2018-01-01", to="2018-12-31")
