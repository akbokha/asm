#With this function we will generate standard vertical bar chart plots
#The function needs two arguments: the data frame and 
#The column of the data frame you want to analyze
Standard_Bar_NC <- function(My_Column, Column_Name = NULL, My_DF = NULL) {
  
  #Gets the column name. 
  #Preferred Method: if it works there will be no need to specify the column name 
  #Column_Index <- match(My_Column,names(My_DF))
  #Column_Name <- names((My_DF[Column_Index]))
  
  #Makes a data frame with the number of NC's for each group
  Column_Count <- aggregate(data.frame(count = My_Column), list(Column_Name = My_Column), length)
  
  #Input for bar chart
  Y_Axis <- Column_Count$count
  X_Axis <- Column_Count$Column_Name
  #Provides names for the title and Y Axis
  Bar_Chart_Title <- paste("Number of NC's per", Column_Name)
  Y_Axis_Name <- "Number of NC's"
  #generate the bar chart using plot_ly
  plot_ly(x = X_Axis, y = Y_Axis, type = 'bar', mode = 'markers') %>%
    layout(title = Bar_Chart_Title, 
           yaxis = list(title = Y_Axis_Name), 
           xaxis = list(title = Column_Name))
}
#Trying with the customer set.
Standard_Bar_NC(ncdata$Customer, Column_Name = "Customer")

