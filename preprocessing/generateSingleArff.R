#convert geotiff to csv/arff format to be used in Weka classifiers
#Krishna Karthik Gadiraju/kkgadiraju
rm(list=ls())

library(rgdal)
library(rgeos)
library(foreign)


myImg<-readGDAL('C:/Users/Admin/Google Drive/Settlement Mapping/Landsat8/2016-03-20/Composite-2016-03-20.tif')
#simpleImg <- readGDAL('May28-SimpleFinal.tif')
#advancedImg <- readGDAL('May28-AdvancedFinal.tif')
myImgData <- myImg@data
#simpleImgData <- simpleImg@data
#advancedImgData <- advancedImg@data
colnames(myImgData) <- c("Aerosol","B","G","R","NIR","SWIR1","SWIR2","Cirrus")
#colnames(simpleImgData) <- c("energy","entropy","corr","invDiffM","inertia","clusShade","clusProm","hCorr")
#colnames(advancedImgData) <- c("mean","variance","dissim","sumAvg","sumVar","sumEntr","diffEntr","diffVar","IC1","IC2")
allData <- myImgData
#allData <- cbind(myImgData,simpleImgData,advancedImgData)

x2 <- sample(1:4,nrow(allData),replace=T)
allData$Class <-x2

#top10 <- c('R','G','Aerosol','energy','B','invDiffM','SWIR1','SWIR2','diffEntr','inertia','Class')
#outputData <- allData[,top10] 

outputData <- allData

outputData$Class <- as.factor(outputData$Class)

#write.csv(x=outputData,file = 'may28-allImage-top10.csv',row.names = F)
write.arff(outputData,file='2016-03-20-OnlyBands.arff',relation='testing')

