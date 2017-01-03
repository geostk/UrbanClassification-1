################################################
#Feature selection using Learning Vector Quantization
# Source: http://machinelearningmastery.com/feature-selection-with-the-caret-r-package/
# Krishna Karthik Gadiraju/kgadira
################################################


rm(list=ls())

set.seed(100)

library('mlbench')
library('caret')
library('pROC')

data.training <- read.csv('../preprocessing/2016-03-20-training-Features.csv')
data.testing <- read.csv('../preprocessing/2016-03-20-testing-Features.csv')
data.training$Class <- as.factor(data.training$Class) #Convert to factor
data.testing$Class <- as.factor(data.testing$Class) #convert to factor
control <- trainControl(method="repeatedcv", number=10, repeats=3) #we can explore more by changing these params

model <- train(Class~., data=data.training, method="lvq", preProcess="scale", trControl=control)
# estimate variable importance
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)

#Based on this, take top 10 most important variables and Class variable
top10 <- c('Aerosol','LRLGLE','sumVar','diffEntr','R','IC1','clusShade','clusProm','invDiffM','corr') 
#c('R','G','Aerosol','energy','B','invDiffM','SWIR1','SWIR2','diffEntr','inertia','Class')

data.training.final <- data.training[,top10]
data.testing.final <- data.testing[,top10]

#Write down CSV and/or arff files to use for prediction
#write.csv(x=data.training.final,'../preprocessing/2016-03-20-training-features-top10-training.arff',row.names = F)
write.arff(data.training.final,file='../preprocessing/2016-03-20-features-top10-training.arff',relation='training')

#write.csv(x=data.testing.final,'../preprocessing/2016-03-20-training-features-top10-training.arff',row.names = F)
write.arff(data.testing.final,file='../preprocessing/2016-03-20-features-top10-testing.arff',relation='testing')
