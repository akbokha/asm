NrOfCat(AllCustomers_MachineData$Customer.x)
#41 bedrijven, nc's verwijderen
AllCustomers_MachineData <- alldata2[!is.na(alldata2$Customer.x),]
length(AllCustomers_MachineData)

#bar chart genereren
Standard_Bar_NC(AllCustomers_MachineData$Customer.x,"Customer", "Number of NC's")

#Vergelijken met earchive
NrOfCat(earchive_correct$Customer)
#84 categoriën
earchive_correct <- earchive[!is.na(earchive$Customer),]
Standard_Bar_NC(earchive_correct$Customer)
#Blijkt dat earchive andere namen gebruikt, 5 grootste manueel uitzoeken:

NumberOfCustomerNCs <- aggregate(data.frame(count = AllCustomers_MachineData$Customer.x), list(count_by = AllCustomers_MachineData$Customer.x), length)
NumberOfCustomerNCs <- as.data.frame(NumberOfCustomerNCs)
setDT(NumberOfCustomerNCs, keep.rownames = TRUE)
colnames(NumberOfCustomerNCs) <- c("ID", "Customer", "Number of NC's")

OrderedCustomerNCs <- NumberOfCustomerNCs[order(NumberOfCustomerNCs$`Number of NC's`),]
OrderedCustomerNCs

#Intel; 548, Global Foundries; 141, Infineon; 132, Rober Bosch GmbH; 125
#Look these up in earchive: IC; Global_Foundries, Infineon, BOSCH
NumberOfCustomerE <- aggregate(data.frame(count = earchive_correct$Customer), list(count_by = earchive_correct$Customer), length)
NumberOfCustomerE <- as.data.frame(NumberOfCustomerE)
setDT(NumberOfCustomerE, keep.rownames = TRUE)
colnames(NumberOfCustomerE) <- c("ID", "Customer", "NumberOfMachines")

OrderedCustomerE <- NumberOfCustomerE[order(NumberOfCustomerE$NumberOfMachines),]
OrderedCustomerE
#IC; 159, Infineon; 148, BOSCH; 26, Global_Foundries; 12
#Count average number of NC's per product for these
NrNCsIntel <- 548 / 159
NrNCsInfineon <- 132 / 148
NrNcsBosch <- 125 / 26
NrNcsGlobalFoundries <- 141 / 12

#Zet ze in een data frame
Averages = c(NrNCsIntel, NrNCsInfineon, NrNcsBosch, NrNcsGlobalFoundries)
Companies = c("Intel", "Infineon", "Bosch", "Global Foundries")
AverageNCPerProduct <- data.frame(Companies, Averages)
AverageNCPerProduct <- AverageNCPerProduct[order(AverageNCPerProduct$Averages),]
plot_ly(AverageNCPerProduct, x=~AverageNCPerProduct$Companies, y=~AverageNCPerProduct$Averages, type = 'bar', mode = 'markers') %>%
  layout(
    title = "Average Number of NC's per product"
  )

Standard_Bar_NC(AllCustomers_MachineData$Customer.y,"Customer", "Number of NC's")
Standard_Bar_NC(AllCustomers_MachineData$Customer.x,"Customer", "Number of NC's")


#Doe hetzelfde voor de andere Customer Data
NumberOfCustomerYNCs <- aggregate(data.frame(count = AllCustomers_MachineData$Customer.y), list(count_by = AllCustomers_MachineData$Customer.y), length)
NumberOfCustomerYNCs <- as.data.frame(NumberOfCustomerYNCs)
setDT(NumberOfCustomerYNCs, keep.rownames=TRUE)
colnames(NumberOfCustomerYNCs) <- c("ID", "Customer", "NumberOfNCs")
OrderedCustomerY <- NumberOfCustomerYNCs[order(NumberOfCustomerYNCs$NumberOfNCs),]
OrderedCustomerY
OrderedCustomerE

#koppel de twee data frames en verwijder de twee ID kolommen
CustomerNCS <- merge(OrderedCustomerY, OrderedCustomerE, by = "Customer")
CustomerNCS$ID.x <- NULL
CustomerNCS$ID.y <- NULL

#Bereken gemiddelde aantal NC's per Machine
CustomerNCS$'NCs per Machine' <- CustomerNCS$NumberOfNCs / CustomerNCS$NumberOfMachines

plot_ly(CustomerNCS, x=~CustomerNCS$Customer, y=~CustomerNCS$`NCs per Machine`, type = 'bar', mode='markers') %>%
  layout(title="Average Number of NC's per Machine per Customer", xaxis = (list(title = "")), yaxis = (list(title = "NC's per machine")))
CustomerNCS

Standard_Bar_NC(AllCustomers_MachineData$Type)
Standard_Bar_NC(earchive_correct$Type)

#functie waarmee ik makkelijk van een kolom een data frame kan maken met daarin de unieke waarden + aantallen
CategoryFrame <- function(My_Column, Col1 = NULL, Col2 = NULL, Col3 = NULL, Col4 = NULL, Col5 = NULL, Col6 = NULL) {
  NrOfCategories <- aggregate(data.frame(count = My_Column), list(count_by = My_Column), length)
  NrOfCategories <- as.data.frame(NrOfCategories)
  NrOfCategoriesA <- setDT(NrOfCategories, keep.rownames = TRUE)
  colnames(NrOfCategoriesA) <- c(Col1, Col2, Col3, Col4, Col5, Col6)
  NrOfCategoriesA
}

#Functie op de twee datasets gebruiken
NrOfETypes <- CategoryFrame(earchive_correct$Type, Col1 = "ID",Col2 = "Type", Col3 = "Number of Instances")
NrOfATypes <- CategoryFrame(AllCustomers_MachineData$Type, "ID", "Type", "Number of Instances")

#Twee dataframes mergen en gemiddelde uitrekenen per type
MergedTypes <- merge(NrOfATypes, NrOfETypes, by = "Type")
MergedTypes$ID.x <- NULL
MergedTypes$ID.y <- NULL
MergedTypes$Average <- MergedTypes$`Number of Instances.x` / MergedTypes$`Number of Instances.y`

plot_ly(MergedTypes, x=~MergedTypes$Type, y=~MergedTypes$Average, type = 'bar', mode = 'markers') %>%
  layout(title="Average Number of NC's per Type", xaxis = (list(title = "Type")), yaxis = (list(title = "Average number of NC's")))


NrOfEProducts <- CategoryFrame(earchive_correct$PN, "ID", "PN", "Number of Instances")
NrOfEProducts

NrOfAProducts <- CategoryFrame(AllCustomers_MachineData$PN, "ID", "PN", "Number of Instances")
NrOfAProducts

MergedProducts <- merge(NrOfAProducts, NrOfEProducts, by = "PN")
MergedProducts$ID.x <- NULL
MergedProducts$ID.y <- NULL
MergedProducts$Averages <- MergedProducts$`Number of Instances.x` / MergedProducts$`Number of Instances.y`
MergedProducts
plot_ly(MergedProducts, x=~MergedProducts$PN, y=~MergedProducts$Averages, type = 'bar', mode = 'markers') %>%
  layout(title="Average Number of NC's per Product", xaxis = (list(title = "PN")), yaxis = (list(title = "Average number of NC's")))
