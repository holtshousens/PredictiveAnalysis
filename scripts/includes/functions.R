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
  # sourcedata <- iris
  
  # create copy of the iris DF
  trainingSet <- sourcedata
   
  # create a TRUE/FALSE column for each Species for our prediction

  species <- as.character(unique(trainingSet$Species))
  
  noSpecies <- NROW(species)
   
  for (i in 1:noSpecies)
  {
    specie <- species[i]
    trainingSet[,paste(specie)] <- c(trainingSet$Species == specie)
  }

  # trainingSet
  
  # Remove original Species column
  trainingSet$Species <- NULL
  
  # train data using neural networks
  nn <- neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, trainingSet, hidden=3,lifesign = "full")
  
  # plot the neural network
  # plot(nn, rep="best")
  # plot(nn, rep = "best", intercept=FALSE)
  
  # predict the species using the original Iris data
  predict <- compute(nn, iris[1:4])
  
  # NROW(predict$net.result)
  
  # make round numbers & replace with string prediction
  
  result <- 0
  
  noRows <- NROW(predict$net.result)
  
  for (i in 1:noRows) 
  { 
    result[i] <- which.max(predict$net.result[i,]) 
    
    if (result[i] == 1) 
    { 
      result[i] = species[1]
    }
    else if (result[i] == 2)
    {
      result[i] = species[2]
    }
    else if (result[i] == 3)
    {
      result[i] = species[3]
    }
  }
  
  # create new data frame with sourcedata

  comparison <- sourcedata
  
  # add column with our predicted values
  comparison$Predicted <- result
  
  # return the comparison data frame
  
  return(comparison)
}


predictIrisSpeciesUser <- function(sourcedata)
{
  #accepting user input:
  
  # need to retrain the neuralnet using the iris data.
  # still to do:
  # remove the training of the dataset into a seperate function rather
  # so that we dont have train multiple times / every time a user submits
  # a new observation to predict
  
  nn <- neuralnet::neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, iris, hidden=3,lifesign = "full")
  
  predict <- neuralnet::compute(nn, sourcedata[1:4])
  
  result <- 0

  result[1] <- which.max(predict$net.result[1,])
  
  if (result==1) { result = "setosa"}
  if (result==2) {result = "versicolor"}
  if (result==3) {result = "virginica"}
  
  comparison <- sourcedata
  
  comparison$Predicted <- result
  
  return(comparison)
}

sendResultsToSQL <- function(results)
{
  addPackage("RODBC")
  
  connection <- RODBC::odbcConnect("LOCALHOST")
  
  tableName <- "dbo.iris"
  
  try(RODBC::sqlDrop(connection, tableName, errors = FALSE), silent = TRUE)
  
  sqlSave(connection, results)
  
  RODBC::odbcClose(connection)
}
