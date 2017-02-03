library(plotly)

# This shows the distribution of the total actuals per product line

totalActualsProductLines <- plot_ly(ncdata_posactuals, x = ~ncdata_posactuals$`Total Actuals`, color=~ncdata_posactuals$`Product Line`, type = "box", boxmean=TRUE) %>%
  layout(
    title = "Total Actuals Per Product-Line",
    xaxis = list(         
      title = "Total Actuals", 
      showgrid = T)
  )


histTotalActuals <- plot_ly(x = ~ncdata_posactuals$`Total Actuals`, type = "histogram")
