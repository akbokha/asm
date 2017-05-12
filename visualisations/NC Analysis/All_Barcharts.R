Standard_Bar_All <- function(My_Column, X_Name = NULL, Y_Name = NULL, My_title = NULL) {
  
  #Makes a data frame with the number of NC's for each group
  Column_Count <- aggregate(data.frame(count = My_Column), list(count_by = My_Column), length)
  
  #Input for bar chart
  Y_Axis <- Column_Count$count
  X_Axis <- Column_Count$count_by
  
  #Provides names for the Y axis, X axis and title
  Bar_Chart_Title <- if (is.null(X_Name)|is.null(Y_Name)) {
  "" }
  else if 
    (is.null(My_title)) {
    paste(Y_Name, "per", X_Name)
  } else {
    My_title
  }
  #generate the bar chart using plot_ly
  plot_ly(x = X_Axis, y = Y_Axis, type = 'bar') %>%
    layout(title = Bar_Chart_Title, 
           yaxis = list(title = Y_Name), 
           xaxis = list(title = X_Name))
}
