# execute phases_adjustdata first
# this script is for the test data

# count unique machines in the dataset

unique_test_count <- unique(ncdata_test$`Equipment descr`)
unique_test_count <- length(unique_test_count)

# 494 unique machines in the dataset (/1418)

ncdata_test$Manufacturing <- FALSE
ncdata_test$Manufacturing[ncdata_test$`NC Equipment Phase` == "Manufacturing"] <- TRUE

ncdata_test$IandQ <- FALSE
ncdata_test$IandQ[ncdata_test$`NC Equipment Phase` == "I&Q"] <- TRUE

ncdata_test$Warranty <- FALSE
ncdata_test$Warranty[ncdata_test$`NC Equipment Phase` == "Warranty"] <- TRUE

ncdata_test$Contract <- FALSE
ncdata_test$Contract[ncdata_test$`NC Equipment Phase` == "Contract"] <- TRUE

# making subsets for the records that are in either the manufacturing/I&Q phase
# or the warranty/contract phase
test_warrantycontract_phase <- ncdata_test[ncdata_test$Contract | ncdata_test$Warranty,]
test_man_contract_phase <- ncdata_test[ncdata_test$Manufacturing | ncdata_test$IandQ,]

# test records. You can check the accuracy with this data frame
test_model <- test_man_contract_phase
test_model$NC_WarrantyContract <- NA # what we are trying to predict

# fill in the correct values
test_man_contract_phase$NC_WarrantyContract <- FALSE
count_test <- 0

for (i in 1:nrow(test_man_contract_phase)) {
  for (j in 1:nrow(test_warrantycontract_phase)) {
    if (grepl(test_man_contract_phase[i,]$`Equipment descr`,
              test_warrantycontract_phase[j,]$`Equipment descr`, fixed = TRUE)) {
      count_test <- count_test + 1
      test_man_contract_phase[i,]$NC_WarrantyContract <- TRUE
    }
  }
}

# 398 out of 633 records are have the value TRUE for NC_WarrantyContract (62.8%)
# So pretty decent test dataset

# so the model has to fill in the attribute NC_WarrantyContract in the test_model file
# and the accuracy of the prediction can be tested with the NC_WarrantyContract as found in test_man_contract_phase 
