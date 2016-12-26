#!/bin/bash

#simple features - 8 output image channels are: Energy, Entropy, Correlation, Inverse Difference Moment, Inertia, Cluster Shade, Cluster Prominence and Haralick Correlation
/home/kgadira/OTB-5.8.0-Linux64/bin/otbcli_HaralickTextureExtraction -in $1 -channel 1 -texture simple -parameters.min 0 -parameters.max 11800 -parameters.xrad 5 -parameters.yrad 5 -parameters.xoff 2 -parameters.yoff 2 -parameters.nbbin 25 -out Composite-2016-03-20-Simple.tif 

#advanced features - 10 output image channels are: Mean, Variance, Dissimilarity, Sum Average, Sum Variance, Sum Entropy, Difference of Entropies, Difference of Variances, IC1 and IC2
/home/kgadira/OTB-5.8.0-Linux64/bin/otbcli_HaralickTextureExtraction -in $1 -channel 1 -texture advanced -parameters.min 0 -parameters.max 11800 -parameters.xrad 5 -parameters.yrad 5 -parameters.xoff 2 -parameters.yoff 2 -parameters.nbbin 25 -out Composite-2016-03-20-Advanced.tif

#higher features - 11 output image channels are: Short Run Emphasis, Long Run Emphasis, Grey-Level Nonuniformity, Run Length Nonuniformity, Run Percentage, Low Grey-Level Run Emphasis, High Grey-Level Run Emphasis, Short Run Low Grey-Level Emphasis, Short Run High Grey-Level Emphasis, Long Run Low Grey-Level Emphasis and Long Run High Grey-Level Emphasis.
/home/kgadira/OTB-5.8.0-Linux64/bin/otbcli_HaralickTextureExtraction -in $1 -channel 1 -texture higher -parameters.min 0 -parameters.max 11800 -parameters.xrad 5 -parameters.yrad 5 -parameters.xoff 2 -parameters.yoff 2 -parameters.nbbin 25 -out Composite-2016-03-20-Higher.tif

#SFS Texture Extraction 6 output texture features are SFS’Length, SFS’Width, SFS’PSI, SFS’W-Mean, SFS’Ratio and SFS’SD.
/home/kgadira/OTB-5.8.0-Linux64/bin/otbcli_SFSTextureExtraction -in $1 -channel 1 -out Composite-2016-03-20-SFS.tif 

  
