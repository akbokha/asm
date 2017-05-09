#Average Chart Generator
#Functions: Standard_Bar_All, Relative_Averages_Function

Average_Bar_Generator <- function(AbsoluteSet, RelativeSet, Column, X-Axis, Y-Axis, Title) {
  Averaging <- Relative_Averages(AbsoluteSet, RelativeSet, Column)
  Averaging <- data.frame(Averaging)
  Standard_Bar_All(Averaging$Average, X_Name = X-axis, Y_Names = Y-Axis, My_title = Title)
}

