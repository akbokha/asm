# make sure to load ncdata again (wihout modifications that could affect this analysis) in your global environment

# ncdata is ordered (on dates)
# shuffle records

ncdata_shuffled <- ncdata[sample(nrow(ncdata)),]

# split data 70/30 (70% train, 30% test)
ncdata_train <- ncdata_shuffled[1:3681,]
ncdata_test <- ncdata_shuffled[3682:5258,]

# removing all the records (approx. 600) that are non-customer related
# these records have NA values for the Equipment descr attribute and the NC Equipment Phase attribute

ncdata_phases <- ncdata_train[!is.na(ncdata_train$`Equipment descr`),]
ncdata_test <- ncdata_test[!is.na(ncdata_test$`Equipment descr`),]

# removed 632 records (/5258)
# check if also all the records that are "Non-customer related" got removed

ncdata_phases <- ncdata_phases[ncdata_phases$`NC Equipment Phase` != "Non Customer related",]
ncdata_test <- ncdata_test[ncdata_test$`NC Equipment Phase` != "Non Customer related",]

#all the records @line 7 got removed
# count unique machines in the dataset

unique_count <- unique(ncdata_phases$`Equipment descr`)
unique_count <- length(unique_count)

# 494 unique machines in the dataset (/3208)

ncdata_phases$Manufacturing <- FALSE
ncdata_phases$Manufacturing[ncdata_phases$`NC Equipment Phase` == "Manufacturing"] <- TRUE

ncdata_phases$IandQ <- FALSE
ncdata_phases$IandQ[ncdata_phases$`NC Equipment Phase` == "I&Q"] <- TRUE

ncdata_phases$Warranty <- FALSE
ncdata_phases$Warranty[ncdata_phases$`NC Equipment Phase` == "Warranty"] <- TRUE

ncdata_phases$Contract <- FALSE
ncdata_phases$Contract[ncdata_phases$`NC Equipment Phase` == "Contract"] <- TRUE

# making subsets for each phase + a subset for the warranty and contract phase combined
warranty_phase <- ncdata_phases[ncdata_phases$Warranty,]
manufacturing_phase <- ncdata_phases[ncdata_phases$Manufacturing,]
IandQ_phase <- ncdata_phases[ncdata_phases$IandQ,]
contract_phase <- ncdata_phases[ncdata_phases$Contract,]
warrantycontract_phase <- ncdata_phases[ncdata_phases$Contract | ncdata_phases$Warranty,]
man_contract_phase <- ncdata_phases[ncdata_phases$Manufacturing | ncdata_phases$IandQ,]
