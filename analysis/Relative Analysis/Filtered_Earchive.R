#Filter data zodat alleen de producten met 2E en 2P voorkomen, andere producten waren blijkbaar oud ofzo
alldataNewMachines <- alldata[grepl("2E",alldata$PN)|grepl("2P",alldata$PN),]

#Check of de warranties enzo nu ook goed zijn
Standard_Bar_NC(alldataNewMachines$`NC Equipment Phase`, "Equipment Phase", "Number of NC's")
Standard_Bar_NC(alldata$`NC Equipment Phase`, "Equipment Phase", "Number of NC's")

#Houden alleen maar NC's over die in Manufacturing, I&Q of Warranty zijn. Weet even niet zo goed 
#Of contract er ook bij hoort, maar anders moet die gefilterd worden

Standard_Bar_All(alldataNewMachines$Customer.x,"Customer", "Number of NC's")
Relative_Averages(alldataNewMachines, earchive_correct, "NC Status")
