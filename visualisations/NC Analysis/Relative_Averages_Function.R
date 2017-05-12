#Berekent automatisch gemiddelde
#Input is de twee datasets die vergeleken worden

Relative_Averages <- function(DataFrameAbsolute, DataFrameRelative, Column_Name, X_Axis, Y_Axis, TitleName) {

#Maak dataframes van de input  
DataFrameAbsolute <- data.frame(DataFrameAbsolute)
DataFrameRelative <- data.frame(DataFrameRelative)

#Pakt de naam van de kolom en verbindt hem aan de datasets zodat de juiste kolommen gepakt kunnen worden
Aggregated1 <- DataFrameAbsolute[, Column_Name]
Aggregated2 <- DataFrameRelative[, Column_Name]

#Berekent absolute aantal NC's en zet het in een dataframe
NumberOf1 <- aggregate(data.frame(count = Aggregated1), list(count_by = Aggregated1), length)
Dfof1 <- as.data.frame(NumberOf1)
setDT(Dfof1, keep.rownames = TRUE)
colnames(Dfof1) <- c("ID", Column_Name, "NumberofNCs")

#Berekent Vergelijkingswaarde van de NC's en zet het in een dataframe
NumberOf2 <- aggregate(data.frame(count = Aggregated2), list(count_by = Aggregated2), length)
NumberOf2
Dfof2 <- as.data.frame(NumberOf2)
setDT(Dfof2, keep.rownames = TRUE)
colnames(Dfof2) <- c("ID", Column_Name, "NumberofProducts")

#Merged de dataframes en verwijderd de overbodige ID kolommen
AveragingData <- merge(Dfof1, Dfof2, by = Column_Name)
AveragingData$ID.y <- NULL
AveragingData$ID.x <- NULL

#Berekent gemiddelde en zet het in de dataframe
AveragingData$Average <- AveragingData$NumberofNCs / AveragingData$NumberofProducts
#Dit leek me overbodig maar kreeg er vaak errors mee dus nog maar eens omzetten naar df
AveragingData <- data.frame(AveragingData)
xis <- AveragingData[, Column_Name]

#Grafiek ervan plotten
plot_ly(x = xis, y = AveragingData$Average, type = 'bar', orientation = 'v' ) %>%
  layout(title = TitleName, 
         yaxis = list(title = Y_Axis), 
         xaxis = list(title = X_Axis))

}


