#Packages: plotly en plyr en data.table
#ncdata & Standard_Bar_NC functie

#1: Tel het aantal categoriën per kolom om te kijken of het een factor is
#2: Plot het in een bar chart
#3: Aantal categoriën/eventuele opmerkingen staat onder code
NrOfCat <- function(My_Column) {
  length(unique(My_Column))
}

NrOfCat(ncdata$`NC Equipment Phase`)
Standard_Bar_NC(ncdata$'NC Equipment Phase', Column_Name = "Equipment Phase")
#5, bruikbaar

NrOfCat(ncdata$`Call Title`)
Standard_Bar_NC(ncdata$'Call Title')
#3064, Not Assigned; 2118 --> uniek als is ingevuld

NrOfCat(ncdata$`Equipment descr`)
Standard_Bar_NC(ncdata$`Equipment descr`)
#zo'n 650 NA's, maar blijkbaar zijn sommige machines echt vaak kapot (!) --> zeker naar kijken

#Oké, dit is echt te veel copy paste werk: makkelijker met apply.
All_NrOfCat <- apply(ncdata, MARGIN = 2, FUN = function(x) NrOfCat(x))

#Omzetten naar een dataframe en kolomnamen neerzetten
NrOfCat_DF <- as.data.frame(All_NrOfCat)
setDT(NrOfCat_DF, keep.rownames = TRUE)
colnames(NrOfCat_DF) <- c("Attribute","Number of Categories")

#even ordenen van min naar max
OrderedNrOfCat <- NrOfCat_DF[order(NrOfCat_DF$`Number of Categories`),]

#We gaan ze even verdelen in niveaus op basis van hoeveel categorieën ze hebben
High_Nr_Categories <- OrderedNrOfCat[OrderedNrOfCat$`Number of Categories` > 500]
Medium_Nr_Categories <- OrderedNrOfCat[OrderedNrOfCat$`Number of Categories` > 50 & OrderedNrOfCat$`Number of Categories` <= 500]
Low_Nr_Categories <- OrderedNrOfCat[OrderedNrOfCat$`Number of Categories` <= 50]
