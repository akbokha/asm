summary_totalActuals <- summary(ncdata$`Total Actuals`)
# median: 72, mean: 846.5, 3rd Qu: 572, Max: 62380

summary_totalActualsPosValues <- summary(ncdata_posactuals$`Total Actuals`)
# min: 0.28, 1st Qu: 183.30, median: 468, mean: 1535, 3rd Qu: 1260, Max: 62380
# mean is higer than 3rd Quadrant -> So assumption is that a small proportion
# (the most expensive NC's) have a higher contribution to total actual costs than a much 
# larger proportion of the less expensive NC's 

totalcosts <- sum(ncdata$`Total Actuals`)
# 4.450.976 euro

costs_10percent_mostexpensive <- sum(ncdata_posactuals_inc[2374:2899,]$`Total Actuals`)
# 3.288.051 euro

proportion_top10percent <- costs_10percent_mostexpensive/ totalcosts
# The top 10 percent most expensive NC's make up 73.87% of the total costs that year

proportion_top1percent <- sum(ncdata_posactuals_inc[2846:2899,]$`Total Actuals`) / totalcosts
# The top 1 percent most expensive NC's make up 30.33% of the total costs that year
  
# So the most expensive NC's should be analyzed in more detail