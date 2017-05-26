# correlation matrix of the various costs. No notable significant correlations can be found.
cor(ncdata_posactuals[,11:14], use = "complete.obs")

# p-value of chi-squared tests to test association between two nominal values

library(MASS)       # load the MASS package 

pmatrix <- matrix(0, ncol = 10, nrow = 10)

for (i in 1:10) {
  for (j in 1:10) {
    # construct contingency table of two variables
    tbl = table(ncdata[,i],ncdata[,j]) 
    #perform chi-squared test on contingency table
    result <- chisq.test(tbl)
    pmatrix[i,j] <- result$p.value
  }
}
pmatrix

tbl = table(ncdata$'Customer',ncdata$`Defect Group`)
tbl_main <- tbl()
chisq.test(tbl)


alarmData <- read.csv("C:/_Storage/asm/allAWwsev2013.csv")
alarmDataEnd <- read.csv("C:/_Storage/asm/allAWwsev2013_endForAccess.csv")
