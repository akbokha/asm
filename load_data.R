#REQUIRED EXECUTION----------------------------------------------------------------
library(readxl)
library(ggplot2)
library(plotly)
library(plyr) #includes the count-function

ncdata <- read_excel("C:/_Storage/asm/170120 Non Conformance Data 2013.xlsx")
#remove last row with only NA values
ncdata <- head(ncdata, -1)

#make all "Not Assigned" Values the same across al columns ("blanks")
for (i in 1: 5258) {
  for (j in 1:50) {
    if (grepl(ncdata[i, j], "Not assigned", fixed= TRUE) ||
        grepl(ncdata[i, j], "Not Assigned", fixed= TRUE) ||
        grepl(ncdata[i, j], "9/Not assigned/Not assigned", fixed= TRUE) ||
        grepl(ncdata[i, j], "9/Not assigned", fixed= TRUE) ||
        grepl(ncdata[i, j], "5/Not assigned", fixed= TRUE) ||
        grepl(ncdata[i, j], "5/Not assigned/Not assigned", fixed= TRUE)) 
      {
      ncdata[i, j] <- NA
    }
  }
}

#FINANCIAL ANALYSIS----------------------------------------------------------------
#same data as ncdata, but without the rows (nc's) that have Total actuals == 0 euro
ncdata_posactuals <- ncdata[!is.na(ncdata$`Total Actuals`),]
ncdata_posactuals <- ncdata_posactuals[ncdata_posactuals$`Total Actuals`!=0.0,]


#same data, but sorted (increasing on Total Actuals)
ncdata_posactuals_inc <- ncdata_posactuals[order(ncdata_posactuals$`Total Actuals`, decreasing = FALSE),]
ncdata_posactuals_inc <- head(ncdata_posactuals_inc, -1)

#same data as ncdata, but only the rows (nc's) that have Total actuals ==0
ncdata_zeroactuals <- ncdata[ncdata$`Total Actuals`==0.0,]
