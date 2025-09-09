
# 1
x <- rnorm(1000)
y <- -x
data <- data.frame(scale(cbind(x,y)))
library(neuralnet)
model <- neuralnet(y~x, hidden = 0, data = data)
plot(model)

# 2
explanatory <- data.frame(replicate(10, rnorm(400)))
names(explanatory) <- letters[1:10]
response <- with(explanatory, a*2-0.5*b-i*j+exp(abs(c)))
data <- data.frame(scale(cbind(explanatory, response)))

training <- sample(nrow(data), nrow(data)/2)
model <- neuralnet(response~a+b+c+d+e+f+g+h+i+j, 
                   data = data[training,], hidden = 5)
cor.test(compute(model, data[-training,1:10])$net.result[,1], 
                 data$response[-training])
plot(model)
 
# "Garson test" help figuring out what the most important explanatory variables are in the partibular model
library(NeuralNetTools)
garson(model, bar_plot=FALSE)
garson(model)


########### Exercise ###########
# 2
data <- read.csv("datasets/winequality-red.csv", sep = ';')
training <- sample(nrow(data), nrow(data)/2)
model <- neuralnet(quality~fixed.acidity+volatile.acidity+
                     citric.acid+residual.sugar+chlorides+
                     free.sulfur.dioxide+total.sulfur.dioxide+
                     density+pH+sulphates+alcohol,
                   data = data[training,], hidden = 1)
cor.test(compute(model, data[-training, 1:10])$net.result[,1], 
         data$quality[-training])
plot(model)

garson(model, bar_plot = FALSE)
garson(model)
