layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))

hist(ncdata_posactuals$`Total Actuals`, main="Number of NC's (all product-lines) where Total Actuals: 0 - 2000 euro", plot=TRUE,
     xlab="Total Actuals",
     border="red", 
     col="orange",
     las=1,
     ylim=c(0,400),
     breaks=600,
     xlim=c(0, 2000))

hist(ncdata_posactuals$`Total Actuals`, main="2000-12000 euro", plot=TRUE,
     xlab="Total Actuals",
     border="red", 
     col="orange",
     las=1,
     ylim=c(0,60),
     breaks=230,
     xlim=c(2000, 12000))


hist(ncdata_posactuals$`Total Actuals`, main="12000+ euro", plot=TRUE,
     xlab="Total Actuals",
     border="red", 
     col="orange",
     las=1,
     ylim=c(0,30), xlim=c(12000, 70000))