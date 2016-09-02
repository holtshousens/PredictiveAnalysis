source('scripts\\includes\\functions.R', chdir = TRUE)

addPackage("neuralnet")

install.packages("neuralnet")

library("neuralnet")



irisPrediction <- predictIrisSpecies(iris)

# irisPrediction

Sepal_Length <- 5.9
Sepal_Width <- 3.0
Petal_Length <- 5.1
Petal_Width <- 1.8


userobs <- data.frame(SepalLength=double(),
                      SepalWidth=double(),
                      PetalLength=double(),
                      PetalWidth=double(),
                      stringsAsFactors=FALSE)

userobs <- rbind(userobs, data.frame(SepalLength=Sepal_Length,
                                     SepalWidth=Sepal_Width,
                                     PetalLength=Petal_Length,
                                     PetalWidth=Petal_Width,
                                     stringsAsFactors=FALSE))

irisPrediction <- predictIrisSpeciesUser(userobs)
