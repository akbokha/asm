# correlation matrix of the various costs. No notable significant correlations can be found.
cor(ncdata_posactuals[,11:14], use = "complete.obs")

library(MASS)       # load the MASS package 

for (i in ncdata) {
  # construct contingency table of two variables
  tbl = table(ncdata$`Product Line`,ncdata$`Defect Group`) 
  #perform chi-squared test on contingency table
  chisq.test(tbl)
}
