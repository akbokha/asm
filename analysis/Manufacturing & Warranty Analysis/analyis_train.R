# execute phases_relations first (and the files that have to be executed before phases_relations)
# and execute prepare_test first
# note that te for loops in phases_adjustdata and phases_relations take long to complete
# so try to execute them once and then keep them in your workspace
library(rpart)
library(rpart.plot)

# records_to_analyse is the dataframe in which all the records are found that have a NC in the manufacturing/I&Q phase
# and later in the warranty/contract phase again

# man_conctract_phase contains the same records as records_to_analyse, but the difference is that man_contract_phase also
# contains records for machines that have a NC in the Manufacturing/I&Q phases, but not later again in the 
# warranty/contract phases
train_set <- man_contract_phase

train_set$`Cause Group` = as.factor(train_set$`Cause Group`)
train_set$`Defect Group` = as.factor(train_set$`Defect Group`)
train_set$`Product Line` = as.factor(train_set$`Product Line`)
train_set$`Material type` = as.factor(train_set$`Material type`)
train_set$`Order type` = as.factor(train_set$`Order type`)
train_set$`Consumable` = as.factor(train_set$`Consumable`)
train_set$`Product Line` = as.factor(train_set$`Product Line`)
train_set$`Equipment Status` = as.factor(train_set$`Equipment Status`)
train_set$`NC Disposition` = as.factor(train_set$`NC Disposition`)
train_set$`Material type` = as.factor(train_set$`Material type`)

fit <- rpart(NC_WarrantyContract ~ `Defect Group` 
             + `Product Line` + `Consumable` + 
               `Equipment Status`,
             data=train_set,
             method="class", control=rpart.control(minsplit = 2, minbucket = 11, cp = 0.005))

test_model$`Cause Group` = as.factor(test_model$`Cause Group`)
test_model$`Defect Group` = as.factor(test_model$`Defect Group`)
test_model$`Consumable` = as.factor(test_model$`Consumable`)

test_prediction <- predict(fit, test_model, type = "class")

misClasificError <- mean(test_prediction != test_man_contract_phase$NC_WarrantyContract)
print(paste('Accuracy',1-misClasificError))
rpart.plot(fit)