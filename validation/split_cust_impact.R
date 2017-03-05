#split the attribute 'Customer Impact Description' into three new attributes
#these attributes will contain the strings "yes"and "no"

ncdata$Safety <- NA
ncdata$WaferScrap <- NA
ncdata$Downtime <- NA

# Safety Attribute
for (i in 1:5258) {
  if (grepl("No Safety", ncdata[i,]$`Customer Impact Descr`, fixed = TRUE)) {
    ncdata[i,]$Safety <- "No"
  }
  else {
    if (!(is.na(ncdata[i,]$`Customer Impact Descr`))) {
      ncdata[i,]$Safety <- "Yes"
    }
  }
}


# WaferScrap Attribute
for (i in 1:5258) {
  if (grepl("No Wafer", ncdata[i,]$`Customer Impact Descr`, fixed = TRUE)) {
    ncdata[i,]$WaferScrap <- "No"
  }
  else {
    if (!(is.na(ncdata[i,]$`Customer Impact Descr`))) {
     ncdata[i,]$WaferScrap <- "Yes"
    }
  }
}

# Downtime Attribute
for (i in 1:5258) {
  if (grepl("No Downtime", ncdata[i,]$`Customer Impact Descr`, fixed = TRUE)) {
    ncdata[i,]$Downtime <- "No"
  }
  else {
    if (!(is.na(ncdata[i,]$`Customer Impact Descr`))) {
      ncdata[i,]$Downtime <- "Yes"
    }
  }
}

#  View(ncdata[c(10, 51:53)])
