# include the functions.R file holding customised functions
source('scripts\\includes\\functions.R', chdir = TRUE)

# import packages using addPackage function (currently not working properly)
addPackage("neuralnet")
install.packages("neuralnet")
library("neuralnet")
library("RODBC")

# predict Iris species using the original Iris dataset and return the prediction
irisPrediction <- predictIrisSpecies(iris)

# predict a user observation inputting 4 values (currently user can input a 
# data frame of any number of obserations, not just 1 observation) and predicting the Iris type

Sepal_Length <- 5.9
Sepal_Width <- 3.0
Petal_Length <- 5.1
Petal_Width <- 1.8

# define the data frame
userobs <- data.frame(SepalLength=double(), SepalWidth=double(), PetalLength=double(), PetalWidth=double(), stringsAsFactors=FALSE)

# populate the data frame
userobs <- rbind(userobs, data.frame(SepalLength=Sepal_Length, SepalWidth=Sepal_Width, PetalLength=Petal_Length, PetalWidth=Petal_Width, stringsAsFactors=FALSE))

irisPrediction <- predictIrisSpeciesUser(userobs)

addPackage("RODBC")

sendResultsToSQL(irisPrediction)
