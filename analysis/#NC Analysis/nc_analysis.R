# Number NC's per customer
customer_count <- aggregate(data.frame(count = ncdata$Customer), list(value = ncdata$Customer), length)
# Only customers with at least 15 NC's
customer_limited <- customer_count[customer_count$count>15,]

# Number NC's per product line
productLine_count <- aggregate(data.frame(count = ncdata$`Product Line`), list(value = ncdata$`Product Line`), length)

# Extract type number from Equipment descr
ncdata_equip <- ncdata[!is.na(ncdata$`Equipment descr`),]
ncdata_equip$`Type number` <- sub("\\).*", "", sub("^[^(]*", "",ncdata_equip$`Equipment descr`))
# Number NC's per type
type_count <- aggregate(data.frame(count = ncdata_equip$`Type number`), list(value = ncdata_equip$`Type number`), length)
# Only types with at least 15 NC's
type_limited <- type_count[type_count$count>15,]
type_limited

#sub("^[^(]*", "", ncdata_copy$`Equipment descr`)



#sub("\\).*", "", sub(".*\\(", "", j)) 
