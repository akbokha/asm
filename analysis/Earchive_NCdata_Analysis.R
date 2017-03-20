#ncdata heeft de unieke identifier maar die staat met meer in zijn kolom --> split de equipment descr in twee kolommen met de PN van earchive en de product type 

ncdata$PN <- lapply(strsplit(as.character(ncdata$`Equipment descr`), "\\("), "[",2)
ncdata$type <- lapply(strsplit(as.character(ncdata$ `Equipment descr`), "\\("), "[", 1)

#Verwijder de ")". 
ncdata$PN <- gsub(")", "", as.character(ncdata$PN))

#Nu bruikbare kolommen die gekoppeld kunnen worden aan earchive
alldata <- merge(ncdata, earchive, by="PN")
View(alldata)

#geeft 1900 rows -> best bruikbare dataset, hoeveel unieke waardes?
length(unique(alldata$PN))

#245 unieke waardes. 600 NA's
