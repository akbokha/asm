#Average Chart Generator
#Functions: Standard_Bar_All, Relative_Averages_Function

Average_Bar_Generator <- function(AbsoluteSet, RelativeSet, Column, X_Axis = NULL, Y_Axis = NULL, Title = NULL) {
  Averaging <- Relative_Averages(AbsoluteSet, RelativeSet, Column)
  Averaging <- data.frame(Averaging)
  plot_ly(x = Averaging$, y = , type = 'bar') %>%
              layout(title = Bar_Chart_Title, 
                     yaxis = list(title = Y_Name), 
                     xaxis = list(title = X_Name)))
  
}
 

