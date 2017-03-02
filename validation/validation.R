# check if the material categories match the NC Material descr attribute

countoccur <- 0
for (i in 1:5258) {
  if (grepl(ncdata[i,]$`Material Categories`, ncdata[i,]$`NC Material descr`, fixed = TRUE)){
    countoccur <- countoccur + 1
  }
}

match_percentage <- (countoccur/5258)*100
cat("match percentage material categories: \n", match_percentage)
# we can conclude (based on the high percentage) that these two attributes contain reliable data
