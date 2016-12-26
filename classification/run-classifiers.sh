#!/bin/bash

#compile java code


#run classifiers
#java -cp weka.jar:. UrbanClassification  $1 $2 "nbayes"

#wait


java -cp weka.jar:. UrbanClassification  $1 $2 "j48"

wait


java -cp weka.jar:. UrbanClassification  $1 $2 "randomForest"

wait


java -cp weka.jar:. UrbanClassification  $1 $2 "mlp"

wait


java -cp weka.jar:. UrbanClassification  $1 $2 "knn"

wait
  
