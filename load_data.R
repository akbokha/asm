#REQUIRED EXECUTION----------------------------------------------------------------
library(readxl)
library(ggplot2)
library(plotly)
library(plyr) #includes the count-function

ncdata <- read_excel("C:/_Storage/asm/170120 Non Conformance Data 2013.xlsx")
#remove last row with only NA values
ncdata <- head(ncdata, -1)

#FINANCIAL ANALYSIS----------------------------------------------------------------
#same data as ncdata, but without the rows (nc's) that have Total actuals == 0 euro
ncdata_posactuals <- ncdata[ncdata$`Total Actuals`!=0.0,]

#same data, but sorted (increasing on Total Actuals)
ncdata_posactuals_inc <- ncdata_posactuals[order(ncdata_posactuals$`Total Actuals`, decreasing = FALSE),]


#same data as ncdata, but only the rows (nc's) that have Total actuals ==0
ncdata_zeroactuals <- ncdata[ncdata$`Total Actuals`==0.0,]
