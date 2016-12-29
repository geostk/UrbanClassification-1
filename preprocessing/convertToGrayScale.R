#convert first band to gray scale band from R,G,B bands
# Krishna Karthik Gadiraju/kkgadiraju

library(rgdal)
library(rgeos)
library(foreign)




myImg1 <- readGDAL('clipped-2016-03-20.tif')
myImg1.data <- myImg1@data

smin = 0
smax = 255
print(summary(myImg1@data))

#Convert the first band to grayscale and store it
myImg1@data$band1 <- 0.2989*myImg1.data$band4 + 0.5870*myImg1.data$band3 +
  0.1140*myImg1.data$band2
print(summary(myImg1@data))

writeGDAL(myImg1, fname = 'clipped-2016-03-20-GrayScale.tif')

print('Write completed')

max(myImg1@data$band1)
