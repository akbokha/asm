levels(factor(earchiveNewMachines$Customer))
#Test welke bruikbaar zijn


#Add averages to earchive
PNAverages$NumberofNCs <- NULL
PNAverages$NumberofProducts <- NULL
PNAverages$ID <- NULL
earchiveAverages <- merge(earchiveNewMachines, PNAverages, by = "PN")
earchiveAverages2 <- merge(earchiveNewMachines, PNAverages, by = "PN")
earchiveAverages

table(earchiveAverages$Customer)
table(earchiveAverages$Location)
table(earchiveAverages$Type)
table(earchiveAverages$`Process R1`)
table(earchiveAverages$`Process R2`)

#Remove unnecessary coloms: ship date, SAP number, ASM Name, Customer Name
earchiveAverages$`ASM Name` <- NULL
earchiveAverages$`Customer Name` <- NULL
earchiveAverages$`Ship date` <- NULL
earchiveAverages$`SAP Id` <- NULL
earchiveAverages

#Add only levels with more than 4 instances
CustomerVector <- c("Bosch", "Global_Foundries", "IBM", "\\bIC\\b", "Infineon", "STMicroelectronics", "Texas_Instruments")
LocationVector <- c("East_Fishkill", "F14_Leixlip", "F32_Chandler", "Kulim", "Malta", "Reutlingen_MFW", "Villach", "Agrate_AG8", "F12_Chandler", "F24_Leixlip", "Hillsboro_D1C")
#Type vector is all sufficient
R1Vector <- c("Nitride", "Poly", "TEOS")
R2Vector <- c("Nitride", "Poly", "TEOS")

#Filter dataframe based on vectors above
earchiveAverages <- earchiveAverages[grepl(paste(CustomerVector, collapse = "|"), earchiveAverages$Customer),]
earchiveAverages <- earchiveAverages[grepl(paste(LocationVector, collapse = "|"), earchiveAverages$Location),]
earchiveAverages <- earchiveAverages[grepl(paste(R1Vector, collapse = "|"), earchiveAverages$`Process R1`),]
earchiveAverages <- earchiveAverages[grepl(paste(R2Vector, collapse = "|"), earchiveAverages$`Process R2`),]
earchiveAverages

#Proportion tables
for (i in 2:6) {
  a <- table(earchiveAverages[,i])
  b <- (prop.table(a))
  colnames(c) <- c("Level", "Frequency")
  write.table(c, sep = ",")
}
colnames(earchiveAverages) <- c("PN", "Customer", "Location", "Type", "ProcessR1", "ProcessR2", "Averages")
#Cross tables
xtab1 <- xtabs(~Type +Customer, earchiveAverages)
xtab2 <- xtabs(~Type +ProcessR1, earchiveAverages)
xtab3 <- xtabs(~Type +Location, earchiveAverages)  
xtab4 <- xtabs(~Type +ProcessR2, earchiveAverages)

#Add margins to cross tables
xtab1 <- addmargins(xtab1)
xtab2 <- addmargins(xtab2)
xtab3 <- addmargins(xtab3)
xtab4 <- addmargins(xtab4)

#Wrtie the tables
write.table(xtab1, sep = ",")
write.table(xtab2, sep = ",")
write.table(xtab3, sep = ",")
write.table(xtab4, sep = ",")

#proportion in cross tables
prop.table(xtab1)
prop.table(xtab2)
prop.table(xtab3)
prop.table(xtab4)


#Stratified table
xtab5 <- xtabs(~Type +Location +Customer, earchiveAverages)
xtab5

#SAS-like cross table
#install package gmodels

SAStable <- xtabs(~ Type +Location, earchiveAverages)
SAStable <- CrossTable(SAStable)
write.table(SAStable, sep = ",")

#Make a multi-attribute plot
earchiveAverages2$Customer
earchiveAverages2 <- earchiveAverages2[grepl(paste(LocationVector, collapse = "|"), earchiveAverages2$Location),]
plot_ly(data = earchiveAverages2, x = ~Customer, y = ~Average, type = 'scatter', color = ~Location, colors = "Set1", marker = list(size = 25, opacity = 0.5), symbol = ~Type) %>%
  layout(title = "Average Number of NC's per Customer, Type, and Location", xaxis = list(title = "Customer"), yaxis = list(title = "Average Number of NC's"))
  
plot_ly(data = earchiveAverages2, x = ~`Process R1`, y = ~Average, type = 'scatter', color = ~Location, colors = "Set1", marker = list(size = 25, opacity = 0.5), symbol = ~Type) %>%
  layout(title = "Average Number of NC's per Process R1, Type, and Location", xaxis = list(title = "Customer"), yaxis = list(title = "Average Number of NC's"))  

plot_ly(data = earchiveAverages2, x = ~`Process R1`, y = ~Average, type = 'scatter', color = ~Customer, colors = "Set2", marker = list(size = 25, opacity = 0.5), symbol = ~Type) %>%
  layout(title = "Average Number of NC's per Process R1, Type, and Customer", xaxis = list(title = "Customer"), yaxis = list(title = "Average Number of NC's"))  
