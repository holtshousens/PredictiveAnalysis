# Predictive Analysis 

Predictive Analysis in R using the Iris data frame included in R Studio (version 0.99.484)

The script is a work in progress but currently holds the following 3 functions in the scripts\includes\functions.R file :

1. addPackage(thePackageName)
   A function which adds external packages to the session and includes to the library only if not already existing 

2. predictIrisSpecies(sourcedata)
   A function which predicts the species of the 150 observations in the iris dataframe using neural networks. 
   The prediction data frame is returned

3. predictIrisSpeciesUser(sourcedata)
   A function which accepts a user observation (any number in a data frame) and predicts the species. 
   The prediction data frame is returned.
