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

#245 unieke waardes. 632 NA's
sum(is.na(alldata$PN))
sum(is.na(ncdata$PN))
#NA's in alldata komen als NA niet gespecificeerd is in ncdata
#alle rows met NA in PN verwijderen:
alldata2 <- alldata[!is.na(alldata$PN),]
length(unique(alldata2$PN))

#244 unieke waardes.
length(alldata2$PN)
#1286 rows

length(unique(alldata2$Customer.x))
#41 bedrijven hierin
sum(is.na(alldata2$Customer.x))
