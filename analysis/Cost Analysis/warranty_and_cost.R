# execute dates_analysis.R first

ncdata_warranty <- ncdata_warranty[order(ncdata_warranty$WarrantyPhase, decreasing = FALSE),]
ncdata_warranty <- ncdata_warranty[2349:3960,]

for (i in 1:nrow(ncdata_warranty)) {
  ncdata_warranty[i,]$WarrantyDays <- difftime(ncdata[i,]$`Warranty End`,
                                               ncdata[i,]$`Creation Date`, units = c("days"))
}