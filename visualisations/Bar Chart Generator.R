#With this function we will generate standard vertical bar chart plots
#The function needs one argument: the column of the data frame you want to analyze
Standard_Bar_NC <- function(My_Column) {
  Amount <- My_Column
  My_Column_Count <- aggregate(data.frame(count = Amount), list(My_Col_Name = Amount), length)
  Y_Axis <- My_Column_Count$count
  X_Axis <- My_Column_Count$My_Col_Name
  z <- 
  #generate the bar chart using plot_ly
  plot_ly(x = X_Axis, y = Y_Axis, type = 'bar', mode = 'markers') %>%
    layout(title = paste("Number of NC's per", z, sep =" "), 
           yaxis = list(title = "Y_Axis_Name"), 
           xaxis = list(title = z))
}
Standard_Bar_NC(My_Column = ncdata$Customer)
