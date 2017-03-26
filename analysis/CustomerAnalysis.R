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
  layout(title="Average Number of NC's per Machine")
CustomerNCS
