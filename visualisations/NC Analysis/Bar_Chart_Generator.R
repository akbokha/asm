#With this function we will generate standard vertical bar chart plots
#The function has two arguments: the column of the data frame and 
#if necessary the new name you give this column
Standard_Bar_NC <- function(My_Column, Column_Name = NULL, Y_Name = NULL) {
  
  #Extract the column name; structure of column name is always
  #ncdata$Column_Name or ncdata$'Column Name'.
  Column_String <- deparse(substitute(My_Column))
  Given_Axis <- if (is.na(match("'",Column_String))) {
    substring(Column_String,8)
  } else {
    substring(Column_String,9, nchars(Column_String) - 1)
  }
  #Makes a data frame with the number of NC's for each group
  Column_Count <- aggregate(data.frame(count = My_Column), list(count_by = My_Column), length)
  
  #Input for bar chart
  Y_Axis <- Column_Count$count
  X_Axis <- Column_Count$count_by
  #Provides names for the Y axis, X axis and title
  Y_Axis_Name <- if (is.null(Y_Name)) {
    "Number of NC's" } else {
      Y_Name
    }
  X_Axis_Name <- if (is.null(Column_Name)) {
    paste("Number of NC's per", Given_Axis)
  } else {
    Column_Name
  }
  Bar_Chart_Title <- if (is.null(Column_Name)) {
    paste("Number of NC's per", X_Axis_Name)
  } else {
    paste(Y_Axis_Name, "per", X_Axis_Name)
  }
  #generate the bar chart using plot_ly
  plot_ly(x = X_Axis, y = Y_Axis, type = 'bar') %>%
    layout(title = Bar_Chart_Title, 
           yaxis = list(title = Y_Axis_Name), 
           xaxis = list(title = X_Axis_Name))
}
