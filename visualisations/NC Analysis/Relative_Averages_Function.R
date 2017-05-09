#Berekent automatisch gemiddelde
#Input is de twee datasets die vergeleken worden
#Heeft nog errors
Relative_Averages <- function(DataFrameAbsolute, DataFrameRelative, Column_Name) {
DataFrameAbsolute <- data.frame(DataFrameAbsolute)
DataFrameRelative <- data.frame(DataFrameRelative)
    
Aggregated1 <- DataFrameAbsolute[, Column_Name]
Aggregated2 <- DataFrameRelative[, Column_Name]


NumberOf1 <- aggregate(data.frame(count = Aggregated1), list(count_by = Aggregated1), length)
Dfof1 <- as.data.frame(NumberOf1)
setDT(Dfof1, keep.rownames = TRUE)
colnames(Dfof1) <- c("ID", Column_Name, "NumberofNCs")

NumberOf2 <- aggregate(data.frame(count = Aggregated2), list(count_by = Aggregated2), length)
NumberOf2
Dfof2 <- as.data.frame(NumberOf2)
setDT(Dfof2, keep.rownames = TRUE)
colnames(Dfof2) <- c("ID", Column_Name, "NumberofProducts")

AveragingData <- merge(Dfof1, Dfof2, by = Column_Name)
AveragingData$ID.y <- NULL
AveragingData$ID.x <- NULL

AveragingData$Average <- AveragingData$NumberofNCs / AveragingData$NumberofProducts
AveragingData <- data.frame(AveragingData)
}


