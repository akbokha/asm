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

# 1050 unique machines in the dataset (/4626)

ncdata_phases$Manufacturing <- FALSE
ncdata_phases$Manufacturing[ncdata_phases$`NC Equipment Phase` == "Manufacturing"] <- TRUE

ncdata_phases$IandQ <- FALSE
ncdata_phases$IandQ[ncdata_phases$`NC Equipment Phase` == "I&Q"] <- TRUE

ncdata_phases$Warranty <- FALSE
ncdata_phases$Warranty[ncdata_phases$`NC Equipment Phase` == "Warranty"] <- TRUE

ncdata_phases$Contract <- FALSE
ncdata_phases$Contract[ncdata_phases$`NC Equipment Phase` == "Contract"] <- TRUE

ncdata$Manufacturing_toNC <- FALSE
ncdata$IandQ_toNC <- FALSE

# making subsets for each phase + a subset for the warranty and contract phase combined
warranty_phase <- ncdata_phases[ncdata_phases$Warranty,]
manufacturing_phase <- ncdata_phases[ncdata_phases$Manufacturing,]
IandQ_phase <- ncdata_phases[ncdata_phases$IandQ,]
contract_phase <- ncdata_phases[ncdata_phases$Contract,]
warrantycontract_phase <- ncdata_phases[ncdata_phases$Contract | ncdata_phases$Warranty,]

#the machines that can be found in both the manufacturing and the warranty/contractphase
manufacturing_phase$NC_WarrantyContract <- FALSE
count <- 0

for (i in 1:nrow(manufacturing_phase)) {
  for (j in 1:nrow(warrantycontract_phase)) {
    if (grepl(manufacturing_phase[i,]$`Equipment descr`,
              warrantycontract_phase[j,]$`Equipment descr`, fixed = TRUE)) {
      count <- count + 1
      manufacturing_phase[i,]$NC_WarrantyContract <- TRUE
    }
  }
}