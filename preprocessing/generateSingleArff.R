#convert geotiff to csv/arff format to be used in Weka classifiers
#Krishna Karthik Gadiraju/kkgadiraju
rm(list=ls())

library(rgdal)
library(rgeos)
library(foreign)


myImg<-readGDAL('clipped-2016-03-20.tif')
simpleImg <- readGDAL('../featureGeneration/Composite-2016-03-20-Simple1.tif')
advancedImg <- readGDAL('../featureGeneration/Composite-2016-03-20-Advanced1.tif')
higherImg <- readGDAL('../featureGeneration/Composite-2016-03-20-Higher1.tif')
myImgData <- myImg@data
#myImgData <- myImgData[!!rowSums(myImgData),] #replace all rows with zeros
simpleImgData <- simpleImg@data
advancedImgData <- advancedImg@data
higherImgData <- higherImg@data
colnames(myImgData) <- c("Aerosol","B","G","R","NIR","SWIR1","SWIR2","Cirrus")
colnames(simpleImgData) <- c("energy","entropy","corr","invDiffM","inertia","clusShade","clusProm","hCorr")
colnames(advancedImgData) <- c("mean","variance","dissim","sumAvg","sumVar","sumEntr","diffEntr","diffVar","IC1","IC2")
colnames(higherImgData) <- c("SRE" , "LRE", "GLNU", "RLNU", "RP",     "LGRE", "HGLRE", "SRLGLE", "SRHGLE","LRLGLE", "LRHGLE")
#allData <- myImgData
allData <- cbind(myImgData,simpleImgData,advancedImgData,higherImgData)

x2 <- sample(1:5,nrow(allData),replace=T)
allData$Class <-x2

top10 <- c('Aerosol','LRLGLE','sumVar','diffEntr','R','IC1','clusShade','clusProm','invDiffM','corr') 
outputData <- allData[,top10] 

#outputData <- allData

outputData$Class <- as.factor(outputData$Class)

#outputData <- outputData[,c("Class","Aerosol","B","G","R","NIR","SWIR1","SWIR2","Cirrus")]

#write.csv(x=outputData,file = '2016-03-20-allImage-features-top10.csv',row.names = F)
write.arff(outputData,file='2016-03-20-allImage-features-top10.arff',relation='testing')

