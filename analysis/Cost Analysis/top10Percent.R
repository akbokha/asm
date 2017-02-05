library(plotrix)

mytable <- table(top10percentage$`Product Line`)
lbls <- paste(names(mytable), "\n", mytable, sep="")
# pie10percent_ProductLines <-pie3D(mytable, labels = lbls,  main="Product Lines in the top 10 percent", explode = 0.06)

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
  name = "SF Zoo",
  type = "bar",
  marker = list(color = colors)
)
