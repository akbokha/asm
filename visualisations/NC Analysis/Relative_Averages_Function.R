#Berekent automatisch gemiddelde
#Input is de twee datasets die vergeleken worden
#Heeft nog errors
Relative_Averages <- function(DataFrameAbsolute, DataFrameRelative, Column_Name) {
  
Aggregated1 <- DataFrameAbsolute[, Column_Name]
Aggregated2 <- DataFrameRelative[, Column_Name]

NumberOf1 <- aggregate(DataFrameAbsolute(count=Aggregated1), list(count_by = Aggregated1), length)
DfOf1 <- as.data.frame(NumberOf1)
setDT(NumberOf1, keep.rownames = TRUE)
colnames(NumberOf1) <- c("ID", Column_Name, "NumberofNC")
orderedOf1 <- NumberOf1[order(NumberOf1$NumberofNCs),]

NumberOf2 <- aggregate(DataFrameRelative(count = Aggregated2), list(count_by = Aggregated2), length)
DfOf1 <- as.data.frame(NumberOf2)
setDT(NumberOf2, keep.rownames = TRUE)
colnames(NumberOf2) <- c("ID", Column_Name, "NumberofNCs")
orderedOf2 <- NumberOf2[order(NumberOf2$NumberofNCs),]

AveragingData <- merge(orderedOf1, orderedOf2, by = Column_Name)
AveragingData$ID.x <- NULL
AVeragingData$ID.y <- NULL
ColName <- merge("NCs per", Column_Name) 
AveragingData$ColName <- AveragingData$NumberofNC / AveragingData$NumberofNCs
}


#  NumberOfCustomerYNCs <- aggregate(data.frame(count = AllCustomers_MachineData$Customer.y), list(count_by = AllCustomers_MachineData$Customer.y), length)
 # NumberOfCustomerYNCs <- as.data.frame(NumberOfCustomerYNCs)
  #setDT(NumberOfCustomerYNCs, keep.rownames=TRUE)
  #colnames(NumberOfCustomerYNCs) <- c("ID", "Customer", "NumberOfNCs")
  #OrderedCustomerY <- NumberOfCustomerYNCs[order(NumberOfCustomerYNCs$NumberOfNCs),]
  #OrderedCustomerY
  #OrderedCustomerE
  
  ##koppel de twee data frames en verwijder de twee ID kolommen
  #CustomerNCS <- merge(OrderedCustomerY, OrderedCustomerE, by = "Customer")
  #CustomerNCS$ID.x <- NULL
  #CustomerNCS$ID.y <- NULL
  
  ##Bereken gemiddelde aantal NC's per Machine
  #CustomerNCS$'NCs per Machine' <- CustomerNCS$NumberOfNCs / CustomerNCS$NumberOfMachines
#}
#NumberOfCustomerNCs <- aggregate(data.frame(count = AllCustomers_MachineData$Customer.x), list(count_by = AllCustomers_MachineData$Customer.x), length)
#NumberOfCustomerNCs <- as.data.frame(NumberOfCustomerNCs)
#setDT(NumberOfCustomerNCs, keep.rownames = TRUE)
#colnames(NumberOfCustomerNCs) <- c("ID", "Customer", "Number of NC's")

#OrderedCustomerNCs <- NumberOfCustomerNCs[order(NumberOfCustomerNCs$`Number of NC's`),]
#OrderedCustomerNCs

##Intel; 548, Global Foundries; 141, Infineon; 132, Rober Bosch GmbH; 125
##Look these up in earchive: IC; Global_Foundries, Infineon, BOSCH
#NumberOfCustomerE <- aggregate(data.frame(count = earchive_correct$Customer), list(count_by = earchive_correct$Customer), length)
#NumberOfCustomerE <- as.data.frame(NumberOfCustomerE)
#setDT(NumberOfCustomerE, keep.rownames = TRUE)
#colnames(NumberOfCustomerE) <- c("ID", "Customer", "NumberOfMachines")

#OrderedCustomerE <- NumberOfCustomerE[order(NumberOfCustomerE$NumberOfMachines),]
#OrderedCustomerE