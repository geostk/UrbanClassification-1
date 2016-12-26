################################################
# Get classified samples from Weka, visualize it as geotiff
# Krishna Karthik Gadiraju/kgadira
# Bharathkumar Ramachandra/tnybny
################################################

library(rgdal)
library(rgeos)
library(foreign)

#read original image
myImg1 <- readGDAL('Composite-2016-03-20.tif')


#Function that assigns colors
colorize <- function(d)
{
  for(i in 1:3)
  {
    d[, i] <- rep(col1[d[1, 1], i], nrow(d))
  }
  d
}

createResult <- function(cl.method){
  
  #read classified file
  classified <- read.csv(paste(cl.method,'.csv',sep=''))
  
  #column names of features - top 10 features selected using feature selection + Class Label
  colnames(classified) <-   c("Class","Aerosol","B","G","R","NIR","SWIR1","SWIR2","Cirrus")
  
  #colnames(classified) <-  c('band4','band3','Aerosol','energy','band2','invDiffM',
  #                           'SWIR1','SWIR2','diffEntr','inertia','Class')
  
  print(colnames(classified))
  print(summary(classified))
  
  classified[which(classified$Class!=1),]$Class <-2 #1 = urban
  
  # Convert class variable to factor
  classified$Class <-as.factor(classified$Class)
  print('classes summary')
  print(summary(classified))
  
  #Assign colors: Source: Visualization work done by BharathKumar Ramachandra/tnybny
  col1 = matrix(0, nrow = 2, ncol = 3)
  col1[1, ] =  c(0, 0, 255) # blue urban
  col1[2, ] =  c(255, 255, 255) # white everything else 
  
  print('Beginning to add colors')
  classified$ID <- seq.int(nrow(classified))
  
  t <- split(classified, classified$Class, drop = T)
  t <- lapply(t, FUN = colorize1)
  
  print('Colorized completed')
  x <- do.call("rbind", t)
  
  x <- x[order(x$ID), ] #Reorder data in original order
  
  
  x <- x[, c("R","G","B")] #Remove unnecessary columns
  colnames(x) <-c('band4','band3','band2') #Rename first three bands to ba
  myImg@data[,c('band4','band3','band2')]<-x #Copy R,G,B bands
  writeGDAL(myImg, fname = paste(cl.method,'-tiff.tif',sep='')) #write GDAL file
  
  print(paste(cl.method,': Write completed'))
  
  
  
  
}


classifiers <- c("nbayes","j48","randomForest","mlp","knn")

for( i in 1:length(classifiers)){
  createResult(classifiers(i))
}





