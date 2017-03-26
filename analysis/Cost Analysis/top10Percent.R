# Execute mostexpensiveNCs.R first

library(plotrix)
library(plotly)

mytable <- table(top10percentage$`Product Line`)
lbls <- paste(names(mytable), "\n", mytable, sep="")
pie10percent_ProductLines <-pie3D(mytable, labels = lbls,  main="Product Lines in the top 10 percent", explode = 0.06)

companies <- unique(top10percentage$Customer)
sumcompanies <- c()

for (i in 1:length(companies)){
  sumcompanies <- append(sumcompanies, sum(top10percentage$`Total Actuals`[top10percentage$Customer == companies[i]]))
}

colors <- c()

for (i in 1:length(sumcompanies)){
  if (sumcompanies[i] >= 200000){
    colors <- append(colors, 'rgba(222,45,38,0.8)') 
  } else if (sumcompanies[i] < 200000 && sumcompanies[i] >= 100000){
    colors <- append(colors, 'rgba(255, 135, 43, 0.8)')
  } else {
    colors <- append(colors, 'rgba(204,204,204,1)')
  }
}

barchartcompanies <- plot_ly(
  x = companies,
  y = sumcompanies,
  name = "Sum Total Actuals per Company",
  type = "bar",
  marker = list(color = colors)
)

top10percentage_defectgroup <- top10percentage[top10percentage$`Defect Group` != "9/Not assigned",]
mytable2 <- table(top10percentage_defectgroup$`Defect Group`)
lbls3 <- paste(names(mytable2), sep="")
colors3 <- c('rgba(13,112,232,0.8)', 'rgba(226,6,34, 0.8)', 'rgba(6,214,86, 0.8)')

defectgroups <- plot_ly(top10percentage_defectgroup, labels= lbls3, values = mytable2,  type = 'pie',
              insidetextfont = list(color = '#FFFFFF', size = 19),
              marker = list(colors = colors3, line = list(color = '#FFFFFF', width = 2))) %>%
  layout(title = 'Defect Groups in the Top 10 Percent',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

colors4 <- c('rgba(92,253,211 ,1)', 'rgba(214,37,137, 0.4)', 'rgba(75,170,174, 1)','rgba(146,180,195, 1)')

mytable4 <- table(top10percentage$Consumable)
lbls4 <- paste(names(mytable4), sep="")
consumable <- plot_ly(top10percentage, labels= lbls4, values = mytable4,  type = 'pie',
                      insidetextfont = list(color = '#FFFFFF', size = 19),
                      marker = list(colors = colors4, line = list(color = '#FFFFFF', width = 2))) %>%
  layout(title = 'Consumables in the Top 10 Percent',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


causes <- unique(top10percentage$`Cause Group`)
sumcauses <- c()

for (i in 1:length(causes)){
  sumcauses <- append(sumcauses, nrow(top10percentage[top10percentage$`Cause Group` == causes[i],]))
}

colorsdefects <- c()

for (i in 1:length(causes)){
  if (sumcauses[i] >= 100){
    colorsdefects <- append(colorsdefects, 'rgba(222,45,38,0.8)') 
  } else if (sumcauses[i] < 100 && sumcauses[i] >= 50){
    colorsdefects <- append(colorsdefects, 'rgba(255, 135, 43, 0.8)')
  } else {
    colorsdefects <- append(colorsdefects, 'rgba(204,204,204,1)')
  }
}

barchartCauseGroup <- plot_ly(
  x = causes,
  y = sumcauses,
  name = "NC Causes in the the top 10 percent",
  type = "bar",
  marker = list(color = colorsdefects)
)