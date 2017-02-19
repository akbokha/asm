#Packages: plotly en plyr
#Andere codes: Bar Chart Generator function Standard_Bar_NC)

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
#3064, Not Assigned 2118 --> uniek

NrOfCat(ncdata$`Problem descr`)
#5251 --> volledig ingevuld

NrOfCat(ncdata$`Equipment descr`)
Standard_Bar_NC(ncdata$`Equipment descr`)
#1051 --> zelfde machine gaat vaker kapot?? ook 632 NA --> uitzoeken

#oké, misschien kan ik die NrOfCat gewoon laten loopen
apply(ncdata,FUN = NrOfCat())



