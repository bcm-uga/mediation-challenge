# mediation-challenge
Repository for the [Epigenetic and High-Dimension Mediation Data Challenge](https://data-institute.univ-grenoble-alpes.fr/events/epigenetic-high-dimension-mediation-data-challenge-710076.htm) (Aussois, June 7-9 2017)

##  1. Install software

### Install R and R-studio
To participate to the challenge, you need to install [R](https://cran.r-project.org/) on your computer. To make R easier to use, we suggest to install [RStudio](https://www.rstudio.com/), which is an integrated development environment (IDE) for R.

### Install R packages
To install R packages that are useful for the data challenge, copy and paste in R the following pieces of code

```r
#Install R packages for the Epigenetic & High-Dimension Mediation Data Challenge

#Package to read large table
install.packages("data.table")

#Package for controlling FDR and uses empirical null distribution
install.packages("fdrtool")

#Package to make an R developer's life easier
install.packages("devtools")
install.packages("tidyverse")

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
```

##  2. Download datasets for challenges 1 and 2

Dataset for the 1st challenge and 2nd challenge can be loaded in R using the following pieces of code.

```r
require(data.table)
data1<-fread("https://raw.githubusercontent.com/BioShock38/mediation-challenge/master/data/challenge1.txt",header=TRUE,data.table=FALSE)
```

```r
data2<-fread("https://raw.githubusercontent.com/BioShock38/mediation-challenge/master/data/challenge2.txt",header=TRUE,data.table=FALSE)
```

## 3. Form a team

To participate to the challenge, you should form teams. A team can be composed of 1, 2, or 3 participants. Once you have chosen a name for your team, send an email to [Michael Blum](mailto:michael.blum@univ-grenoble-alpes.fr) using "team mediation 2017" as email subject. A key for your team will then be sent to you by email.


## 4. Submit markers involved in mediation

The objective of the two data challenges is to find markers that are involved in the [mediation](https://en.wikipedia.org/wiki/Mediation_(statistics)) of a health outcome by a factor of exposure. For instance, you are asked to find, in the 2nd data challenge, the methylation markers that are involved in the mediation of skin cancer by sun exposure.

To submit a list of markers involved in mediation, you should use [the submission website](http://176.31.253.205/shiny/mediation-challenge/shiny-app/). An example of submission file containing a list of markers involved in mediation is contained in the file [mysubmission.txt](https://raw.githubusercontent.com/BioShock38/mediation-challenge/master/mysubmission.txt). 

## 5. Evaluation

The ranking of the participants will be based on the [F1 score](https://en.wikipedia.org/wiki/F1_score). The F1 score depends on the false discovery rate (FDR), which is the percentage of false positive markers in the submitted list, and of the power, which is the percentage of markers involved in mediation, which are found in the submitted list. The F1 score is equal to the harmonic mean of the power and of one minus the false discovery rate

![equation](http://latex.codecogs.com/gif.latex?%24%24%20F_1%20%3D%202%20%5Ccdot%20%5Cfrac%7B%5Cmathrm%7Bpower%7D%20%5Ccdot%20%281-%5Cmathrm%7BFDR%7D%29%7D%7B%5Cmathrm%7Bpower%7D%20&plus;%20%281-%5Cmathrm%7BFDR%7D%29%7D.%20%24%24)
## 6. Miscellaneous

We provide some files to show examples of mediation analysis in R.

[Baron and Kenny procedure and Sobel test in R](https://github.com/BioShock38/mediation-challenge/blob/master/Baron_Kenny_Sobel.Rmd) 

[Mediation analysis and epigenome-wide association studies](https://github.com/BioShock38/mediation-challenge/blob/master/Aussois2017_Olivier_Francois.Rpres) 
