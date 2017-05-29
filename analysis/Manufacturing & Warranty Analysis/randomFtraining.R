# install.packages('randomForest')
library(randomForest)

train_set <- man_contract_phase
train_set$`Defect Group` = as.factor(train_set$`Defect Group`)
train_set$`Product Line` = as.factor(train_set$`Product Line`)
train_set$`Consumable` = as.factor(train_set$`Consumable`)
train_set$`Equipment Status` = as.factor(train_set$`Equipment Status`)

fit2 <- randomForest(NC_WarrantyContract ~ train_set$`Defect Group`
             + train_set$`Product Line` + train_set$`Consumable` + 
               train_set$`Equipment Status`,
             data=train_set,
             importance=TRUE, ntree = 2000, na.action=na.exclude)

test_model$`Defect Group` = as.factor(test_model$`Defect Group`)
test_model$`Product Line` = as.factor(test_model$`Product Line`)
test_model$`Consumable` = as.factor(test_model$`Consumable`)
test_model$`Equipment Status` = as.factor(test_model$`Equipment Status`)

test_prediction <- predict(fit2, test_model)

misClasificError <- mean(test_prediction != test_man_contract_phase$NC_WarrantyContract)
print(paste('Accuracy',1-misClasificError))
# varImpPlot(fit2)
