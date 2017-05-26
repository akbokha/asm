# install.packages('randomForest')
library(randomForest)

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

fit2 <- randomForest(NC_WarrantyContract ~ train_set$`Defect Group`
             + train_set$`Product Line` + train_set$`Consumable` + 
               train_set$`Equipment Status`,
             data=train_set,
             importance=TRUE, ntree = 2000, na.action=na.exclude)

test_model$`Cause Group` = as.factor(test_model$`Cause Group`)
test_model$`Defect Group` = as.factor(test_model$`Defect Group`)
test_model$`Consumable` = as.factor(test_model$`Consumable`)

test_prediction <- predict(fit2, test_model)

misClasificError <- mean(test_prediction != test_man_contract_phase$NC_WarrantyContract)
print(paste('Accuracy',1-misClasificError))
# varImpPlot(fit2)
