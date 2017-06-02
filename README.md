# mediation-challenge
Repository for the Epigenetic and High-Dimension Mediation Data Challenge (Aussois, June 7-9 2017)

##  1.Installation of software

### Installing R and R-studio
To participate to the challenge, you need to install [R](http://google.com) on your computer. To make R easier to use, we suggest to install [RStudio](https://www.rstudio.com/), which is an integrated development environment (IDE) for R.

### Installing R packages
To install R packages that are useful for the challenge, copy and paste in R the following piece of code

```r
source("https://raw.githubusercontent.com/BioShock38/mediation-challenge/master/install_mediation_aussois2017.R")
```

##  2.Download the dataset for challenges 1 and 2

Dataset for the 1st challenge and 2nd challenge can be loaded using the following pieces of code in R .

```r
data1<-fread("https://www.dropbox.com/s/7pwkxrwo0o6fdfb/data_challenge1.txt?raw=1",header=TRUE,data.table=FALSE)
```

```r
data1<-fread("https://www.dropbox.com/s/dm3hqk3vdji3ey3/challenge2.txt?raw=1",header=TRUE,data.table=FALSE)
```

##  2.Download the dataset for challenges 1 and 2
