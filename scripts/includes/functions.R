# add package if it doesnt exist
addPackage <- function(thePackageName)
{
  if(thePackageName %in% rownames(installed.packages()) == FALSE)
  {
    install.packages(thePackageName)
    library(thePackageName)
  }
  else
  {
    msg <- paste("The package", thePackageName, "has already been installed.")
    print(msg)
  }
}

# return predicted species for Iris data
predictIrisSpecies <- function(sourcedata)
{
  # irisData <- iris[sample(1:150, 50),]
  # trainingSet <- irisData
  
  # create copy of the iris DF
  trainingSet <- sourcedata
  
  # create a TRUE/FALSE column for each Species for our prediction
  trainingSet$setosa <- c(trainingSet$Species == 'setosa')
  trainingSet$versicolor <- c(trainingSet$Species == 'versicolor')
  trainingSet$virginica <- c(trainingSet$Species == 'virginica')
  
  # trainingSet
  
  trainingSet$Species <- NULL
  
  # train data using neural networks
  nn <- neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, trainingSet, hidden=3,lifesign = "full")
  
  # plot the neural network
  # plot(nn, rep="best")
  # plot(nn, rep = "best", intercept=FALSE)
  
  # predict the species using the original Iris data
  predict <- compute(nn, iris[1:4])
  
  # predict
  
  # make round numbers
  result <- 0
  
  for (i in 1:150) { result[i] <- which.max(predict$net.result[i,]) }
  
  # result
  
  for (i in 1:150) { if (result[i]==1) { result[i] = "setosa"}}
  for (i in 1:150) { if (result[i]==2) {result[i] = "versicolor"} }
  for (i in 1:150) { if (result[i]==3) {result[i] = "virginica"} }
  
  comparison <- iris
  
  # add column with our predicted values
  comparison$Predicted <- result
  
  # comparison
  
  return(comparison)
}

predictIrisSpeciesUser <- function(sourcedata)
{
  #accepting user input:
  
  predict <- compute(nn, userobs[1:4])
  
  result <- 0
  
  result[1] <- which.max(predict$net.result[1,])
  
  if (result==1) { result = "setosa"}
  if (result==2) {result = "versicolor"}
  if (result==3) {result = "virginica"}
  
  comparison <- userobs
  
  comparison$Predicted <- result
  
  return(comparison)
}
