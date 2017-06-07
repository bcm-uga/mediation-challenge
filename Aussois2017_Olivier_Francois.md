```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

Removing Unwanted Variation in Epigenome-Wide Association Studies 
========================================================
author: Olivier François (Univ. Grenoble-Alpes)
date: June 8th, 2017

Outline
========================================================

**Contents of this talk**:

- Methylation Array data (example)
- Presentation of Challenge 2
- (Not the best) solution for mediation analysis

Methylation array data
========================================================

- Methylation of cytosine bases in DNA CpG islands is important in epigenetic regulation mechanisms.
- Hypermethylation of CpG islands located in the promoter regions of tumor suppressor genes has been established as one mechanism for gene regulation in cancer. 
- Arrays enable high-throughput profiling of DNA methylation status of CpG islands.
- The **Beta-value**, ranging from 0 to 1, is used to measure the percentage of methylation.



Methylation Array (reduced data set)
========================================================

**Data for challenge 2**:
- 1496 beta-normalized methylation profiles
- 78 individivuals
- Sun exposure, cancer phenotype, age, gender, tissue sample 
- **Vandiver et al. 2015** Age and sun exposure-related widespread genomic blocks of hypomethylation in nonmalignant skin. Genome Biology 16, 16:80.




Methylation Array (reduced data set)
========================================================

**Data for challenge 2:**
- 1496 beta-normalized methylation profiles
- 78 tissue samples 
- Sun exposure, cancer phenotype, age, gender, tissue type


```r
link.to.challenge2 <- "https://raw.githubusercontent.com/BioShock38/mediation-challenge/master/data/challenge2.txt"
```

```r
data2 <- read.table(link.to.challenge2, stringsAsFactors = FALSE, header = TRUE)
#data2 <- read.table(link.to.challenge2)
Expset <- data2[,2:1497]
```


Question of interest and some difficulties
========================================================


- Which probes are found in the mediation path from exposure to phenotype? 
- Potentially **many mediators** (and they are the needles in the haystack)
- **Confounding factors** must be removed before evaluation of mediation effects


Confounding factors
========================================================

**Evaluating structure in the methylation array**:
- Perform a principal component analysis of the methylation data
```r
pca <- prcomp(Expset, scale = T) 
plot(pca$x, cex = 2, col = "blue",pch = 19)
```

Clusters explained by tissue type and age
========================================================

```r
par(mfrow = c(1,2))
plot(pca$x, col = factor(data2$tissue) , main = "Tissue",pch = 19)
younger  <- data2$age < 50
plot(factor(younger) , pca$x[,3], col=c("orange", "lightblue"), main = "Age", xlab = c("younger/elder"))
```


Removing systematic variation from the EWAS (of phenotype)
========================================================
**Correction with 2 principal components**:
```r
par(mfrow = c(1,2))
p <- ncol(Expset)
pc1 = pca$x[,1]
pc2 = pca$x[,2]
y <- data2$phenotype
pvalue = pvalue.corrected = NULL

for (i in 1:p){ 
  mod2 <- glm(y ~  Expset[,i] + pc1 + pc2 , family = "binomial")  
  mod1 <- glm(y ~  Expset[,i], family = "binomial") 
  pvalue[i] <- summary(mod1)$coeff[2,4]
  pvalue.corrected[i] <- summary(mod2)$coeff[2,4]  
}  
hist(pvalue, col = "lightblue", main ="")
hist(pvalue.corrected, col = "orange", main ="")
```


Using the R package "cate"
========================================================

```r
require("cate")
par(mfrow = c(1,2))
mod.cate <- cate(~ y, data.frame(y), Y = as.matrix(Expset), r = 1)
pvalue.corrected <- mod.cate$beta.p.value  
 
hist(pvalue, col = "lightblue", main ="")
hist(pvalue.corrected, col = "orange", main ="")
```



Mediation analysis with methylation arrays (my attempt)
========================================================

A **four-step 'outlier' detection** approach:

- Compute z-scores (zx) for the association **Expset ~ exposure**
- Compute z-scores (zy) for the association **Expset ~ phenotype**
- Combine zx and zy linearly using **PCA**
- Compute p-values from the resulting scores by using **fdrtool** 



My R function 
========================================================

**Class "covfefe"** (English translation: "the worst I can do"): 
- contains z-scores, pvalues and candidate probes (FDR)

```r
mycovfefe <- function(Expset, phenotype, exposure, k= NULL, fdr = 0.05){
  # Expset An n by p matrix (n individuals, p probes) of differential expression/methylation data  
  # phenotype A numeric vector 
  # exposure A numeric or a factor vector
  # k An integer representing the number of factors
  # fdr A nuleric value reprsenting the expected FDR level in qvalue computations
  
  Em <- as.matrix(Expset)
  y <- as.numeric(phenotype)
  
  if (is.numeric(exposure)){
    x <- exposure
  } else {
    x <- as.factor(exposure)
  }

  if (!is.null(k)) pc <- prcomp(Em, scale = T)$x[,1:k]
  
  zx = zy = NULL
    
    for (i in 1:ncol(Em)){ 
      mod <- lm(Em[,i] ~ x)   
      zx[i] <- summary(mod)$coeff[2,3]
      mod <- glm(y ~  Em[,i] + pc , family = "binomial")  
      zy[i] <- summary(mod)$coeff[2,3]
      }  
  
  zp <- prcomp(cbind(zx,zy), scale = T)
  z.scores <- zp$x[,1]  
  obj  <- fdrtool::fdrtool(z.scores, statistic = "normal", verbose = FALSE, plot = FALSE)
  p.values <- obj$pval
  candidates <- which(qvalue::qvalue(p.values, fdr.level = fdr)$signif)
  
  res <- list(zx = zx, zy = zy, p.values = p.values, candidates = candidates)
  class(res) <- "covfefe"
  return(res)
}

plot.covfefe <- function(obj){
  plot(-log10(obj$p.values), col = "grey80", xlab = "probes", cex = .7)  
  points(obj$candidates,-log10(p.values)[obj$candidates], pch = 19, col = "orange", cex = 1.2)  
}
```


```r
obj <- mycovfefe(
        Expset, 
        phenotype = data2$phenotype, 
        exposure = data2$exposure, 
        k = 2)
```



Results: Histogram of p-values
========================================================

```r
p.values = obj$p.values
hist(p.values, col = "green3")
```


Results: P-value plot (log10) 
========================================================

```r
plot(obj)
```




Challenge 2
========================================================

**Download the data for challenge 2**:
- Propose your own approach to mediation based on Sobel tests, hima, etc
- Or/and improve "mycovfefe"
- Send your candidate list to the web application.

- This **.Rmd presentation** contains all scripts for reproducibility
