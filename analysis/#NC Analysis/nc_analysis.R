# Number NC's per customer
customer_count <- aggregate(data.frame(count = ncdata$Customer), list(value = ncdata$Customer), length)
# Only customers with at least 15 NC's
customer_limited <- customer_count[customer_count$count>15,]

# Number NC's per product line
productLine_count <- aggregate(data.frame(count = ncdata$`Product Line`), list(value = ncdata$`Product Line`), length)

# Extract type number from Equipment descr
ncdata_copy <- ncdata
ncdata_copy$`Type number` <- sub("^[^(]*", "", ncdata_copy$`Equipment descr`)
# Number NC's per type
type_count <- aggregate(data.frame(count = ncdata_copy$`Type number`), list(value = ncdata_copy$`Type number`), length)
# Only types with at least 15 NC's
type_limited <- type_count[type_count$count>15,]
type_limited