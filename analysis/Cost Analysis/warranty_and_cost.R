# execute dates_analysis.R first

ncdata_warranty <- ncdata%>% drop_na(WarrantyPhase)
ncdata_warranty$"WarrantyDays" <- NA

ncdata_warranty <- ncdata_warranty[order(ncdata_warranty$WarrantyPhase, decreasing = FALSE),]
ncdata_warranty <- ncdata_warranty[2349:3960,]

for (i in 1:nrow(ncdata_warranty)) {
  ncdata_warranty[i,]$WarrantyDays <- 
    difftime(ncdata[i,]$`Warranty End`, ncdata[i,]$`Creation Date`, units = c("days"))
}

ncdata_warranty <- ncdata_warranty%>% drop_na(WarrantyDays)
ncdata_warranty <- ncdata_warranty%>% drop_na(`Total Actuals`)


ncdata_warranty <- ncdata_warranty[order(ncdata_warranty$WarrantyDays, decreasing = FALSE),]
ncdata_warranty <- ncdata_warranty[466:1213,]
correlation <- cor(ncdata_warranty$WarrantyDays, ncdata_warranty$`Total Actuals`)

library(plotly)
p <- plot_ly((ncdata_warranty), x = ~ncdata_warranty$WarrantyDays,
             y = ~ncdata_warranty$`Total Actuals`,  type = 'scatter',
             mode = 'markers', color=~`Total Actuals`,
             marker = list(opacity = 0.9, sizemode= "diameter")) %>%
  layout(title = "Is there a relation between number of NC's/costs and the warranty?",
         xaxis = list(title = "Warranty / Contract days left", showgrid = TRUE),
         yaxis = list(title = "Total Actuals", showgrid = TRUE))