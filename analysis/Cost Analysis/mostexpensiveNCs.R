# We add a column that will eventually contain the Total Actual / divided the total costs of all the NC's multiplied
# by 100. This will thus give us the contribution of the particular NC's to the total costs over all the NC's
ncdata["Cost Percentage"] <- NA

# order the data -> Increasing with the value of Total Actuals (in euro's)
ncdata <- ncdata[order(ncdata$`Total Actuals`, decreasing = FALSE),]

totalcosts <- sum(ncdata$`Total Actuals`)
# 4.450.976 euro

# Filling in the column for all the NC's
ncdata$`Cost Percentage` <- (ncdata$`Total Actuals` / totalcosts) * 100

top10percentage <- ncdata[4733:5258,]

#plotpercentage <- plot(top10percentage$'Cost Percentage', type = "l", main = "Percentage of total cost in the top 10 percent most expensive NC's")

# Plotting the percentages and total actuals (same plot) of the top10 percent 

p <- plot_ly(top10percentage, y = top10percentage$`Cost Percentage`, type="scatter", mode = 'lines', name= "Percentage",
             line = list(color = 'rgb(205, 12, 24)', width = 5, dash= "dot")) %>%
  layout(title = "The percentage of the total costs of the top 10% most expensive NC's",
         paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
         yaxis = list(title = "Percentage"),
         xaxis = list (title = "Indexes of the top 10% most expensive NC's (increasing order)"))


q <- plot_ly(top10percentage, y = top10percentage$`Total Actuals`, type = 'scatter', mode = 'lines', name= "Total Actuals",
             line = list(color = 'rgb(22, 96, 167)', width = 5, dash="dot")) %>%
  layout(title = "Total Actuals of the top 10% most expensive NC's",
         paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
         yaxis = list(title = "Total Actuals"),
         xaxis = list (title = "Indexes of the top 10% most expensive NC's (increasing order)"))

r <- subplot(p, q, nrows = 2, margin = 0.05, shareX = TRUE, titleX = TRUE, shareY = FALSE, titleY = TRUE)


######### end plot ##################

### Cumulatives  ####

ncdata2 <- ncdata
ncdata2["Cost Percentage Cumulative"] <- NA
# This column will contain the cost percentage of the particular NC + All the Cost Percentages of the NC's below
ncdata2$`Cost Percentage Cumulative` <- cumsum(ncdata2$`Cost Percentage`)

ncdata2["Factor"] <- (1/nrow(ncdata2)) * 100
ncdata2["Cumulative Percentage"] <- cumsum(ncdata2$Factor)


s <-  plot_ly(ncdata2, y = ncdata2$`Cost Percentage Cumulative`, type="scatter", mode = 'lines', name= "Percentage",
              line = list(color = 'rgb(255, 135, 43)', width = 4, dash= "line")) %>%
  layout(title = "Cumalative percentage of the total costs of the NC's",
         paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
         yaxis = list(title = "Percentage"),
         xaxis = list (title = "Number of NC's (Increasing Cost Order)"))

t <- plot_ly(ncdata2, y = ncdata2$`Cost Percentage Cumulative`, x= ncdata2$`Cumulative Percentage`, type="scatter", mode = 'lines', name= "Percentage", fill = 'tozeroy', fillcolor = 'rgba(255, 212, 96, 0.5)',
             line = list(color = 'rgb(255, 135, 43)', width = 5, dash= "line")) %>%
  layout(title = "Cumalative percentage of the total costs of the NC's",
         paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
         yaxis = list(title = "Percentage of the total costs"),
         xaxis = list (title = "Percentage of NC's (Increasing Cost Order)"))

#### End Cumulatives ####
