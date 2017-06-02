#install R packages for the Epigenetic & High-Dimension Mediation Data Challenge

#Package to read large table
install.packages("data.table")

#Package for controlling FDR and uses empirical null distribution
install.packages("fdrtool")

#Package to make an R developer's life easier
install.packages(devtools)
install.packages(tidyverse)

#Package to perform mediation analysis with multiple mediators
devtools::install_github("YinanZheng/HIMA")

#Package to compute Sobel test
install.packages("multilevel")

#Package for Confounder Adjusted Testing 
install.packages("cate")

#Package q-value for controlling FDR
#Try https:// or http:// 
source("http://bioconductor.org/biocLite.R")
biocLite("qvalue")