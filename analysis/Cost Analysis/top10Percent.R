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
lbls2 <- paste(names(mytable2), "\n", mytable2, sep="")
pie_defectgroup <- pie(mytable2, labels = lbls2,  main="Defect Groups in the top 10 percent")

pq <- plot_ly(top10percentage_defectgroup, values = top10percentage_defectgroup$`Defect Group`,  type = 'pie') %>%
  layout(title = 'United States Personal Expenditures by Categories in 1960',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


