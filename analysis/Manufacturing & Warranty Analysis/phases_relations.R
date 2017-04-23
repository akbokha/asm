# make sure to load ncdata again (wihout modifications that could affect this analysis) in your global environment

# removing all the records (approx. 600) that are non-customer related
# these records have NA values for the Equipment descr attribute and the NC Equipment Phase attribute

ncdata_phases <- ncdata[!is.na(ncdata$`Equipment descr`),]

# removed 632 records (/5258)
# check if also all the records that are "Non-customer related" got removed

ncdata_phases <- ncdata_phases[ncdata_phases$`NC Equipment Phase` != "Non Customer related",]
#all the records @line 4 got removed
# count unique machines in the dataset

unique_count <- unique(ncdata_phases$`Equipment descr`)
unique_count <- length(unique_count)