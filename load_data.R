library(readxl)
ncdata <- read_excel("C:/_Storage/asm/170120 Non Conformance Data 2013.xlsx")

#same data, but without the rows (nc's) that have Total actuals == 0 euro
ncdata_posactuals <- ncdata[ncdata$`Total Actuals`>0,]
