nc_customer_bar <- plot_ly(x = customer_limited$value, y = customer_limited$count, type='bar', mode = 'markers') %>%
  layout(title = "Number of NC's per customer",
         yaxis = list(title = "Number of NC's"),
         xaxis = list (title = "Customer"))

nc_productLine_bar <- plot_ly(x = productLine_count$value, y = productLine_count$count, type='bar', mode = 'markers') %>%
  layout(title = "Number of NC's per product line",
         yaxis = list(title = "Number of NC's"),
         xaxis = list (title = "Product line"))

nc_customer_bar
nc_productLine_bar