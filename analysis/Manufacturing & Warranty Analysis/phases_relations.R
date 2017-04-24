# execute phases_adjustdata first
# this script is for the train data

#the machines that can be found in both the manufacturing/IandQ- and the warranty/contract-phase
man_contract_phase$NC_WarrantyContract <- FALSE
count_hits <- 0

for (i in 1:nrow(man_contract_phase)) {
  for (j in 1:nrow(warrantycontract_phase)) {
    if (grepl(man_contract_phase[i,]$`Equipment descr`,
              warrantycontract_phase[j,]$`Equipment descr`, fixed = TRUE)) {
      count_hits <- count_hits + 1
      man_contract_phase[i,]$NC_WarrantyContract <- TRUE
    }
  }
}

# extract records that also appear (equipment description) in either the contract or warranty phase
records_to_analyse <- man_contract_phase[man_contract_phase$NC_WarrantyContract,]

# There are 348 records in this data set
# but there are 706 records in the man_contract_phase for which NC_WarrantyContract == TRUE
# This means that some machines have more than one NC in the Warranty/Contract phase (2 on average)

# count unique machines in the dataset

unique_cnt <- unique(records_to_analyse$`Equipment descr`)
unique_cnt <- length(unique_cnt)

# 87 out of 348 records are unique machines.
# So the machines have an average of 4 NC's during the manufacturing/I&Q phase