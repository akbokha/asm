# execute dates_analysis.R first

ncdata_warranty <- ncdata%>% drop_na(WarrantyPhase)
ncdata_warranty$"WarrantyDays" <- NA

ncdata_warranty <- ncdata_warranty[order(ncdata_warranty$WarrantyPhase, decreasing = FALSE),]
ncdata_warranty <- ncdata_warranty[2349:3960,]

for (i in 1:nrow(ncdata_warranty)) {
  ncdata_warranty[i,]$WarrantyDays <- difftime(ncdata[i,]$`Warranty End`,
                                               ncdata[i,]$`Creation Date`, units = c("days"))
}

ncdata_warranty <- ncdata_warranty%>% drop_na(WarrantyDays)
ncdata_warranty <- ncdata_warranty%>% drop_na(`Total Actuals`)


ncdata_warranty <- ncdata_warranty[order(ncdata_warranty$WarrantyDays, decreasing = FALSE),]
ncdata_warranty <- ncdata_warranty[466:1213,]
correlation <- cor(ncdata_warranty$WarrantyDays, ncdata_warranty$`Total Actuals`)

plot(ncdata_warranty$WarrantyDays, ncdata_warranty$`Total Actuals`)