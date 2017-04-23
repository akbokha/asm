# execute phases_adjustdata first
# this script is for the test data

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