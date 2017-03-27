library(tidyr)

# Difference in days between NC Created and NC Closed

ncdata$"daysNC" <- NA
ncdata$"NC_Closed" <- NA #boolean: NC Closed or not
for (i in 1:nrow(ncdata)) {
  if (ncdata[i, ]$`Year NC Closed` == "2038") { # Indication: 2038 -> not closed yet
    ncdata[i, ]$NC_Closed <- FALSE
  } else {
    ncdata[i, ]$NC_Closed <- TRUE
  }
}

for (i in 1:nrow(ncdata)) {
  if (ncdata[i, ]$NC_Closed) {
    ncdata[i, ]$daysNC <- difftime(ncdata[i,]$`Closed Date`, ncdata[i,]$`Creation Date`, units = c("days"))
    # all the NC's that are not closed yet have a NA value in the column daysNC
  }
}


# Difference in days between NC Created and Equipment Shipment date
ncdata$"daysNC_Shipment" <- NA
for (i in 1:nrow(ncdata)) {
  ncdata[i, ]$daysNC_Shipment <- difftime(ncdata[i,]$`Creation Date`,
                                          ncdata[i,]$`Equip. Shipment date`, units = c("days"))
}

# negative days are a result of NC's that are created in the manufacturing phase.

#table_phases <- table(ncdata$`NC Equipment Phase`)
#lbls <- paste(names(table_phases), "\n", table_phases, sep="")
#pie_phases <-pie3D(table_phases, labels = lbls,  main="NC Equip. Phase Distribution", explode = 0.06)

# Check if NC is created in the Warranty phase [Warranty Begin...Warranty End]
ncdata$"WarrantyPhase" <- NA
count_mismatch <- 0
for (i in 1:nrow(ncdata)) {
  ncdata[i, ]$WarrantyPhase <- difftime(ncdata[i,]$`Warranty End`,
                                          ncdata[i,]$`Creation Date`, units = c("days"))
  if (ncdata[i, ]$WarrantyPhase > 0 && !is.na(ncdata[i, ]$WarrantyPhase)) {
    ncdata[i, ]$WarrantyPhase <- FALSE
  } else if (!is.na(ncdata[i, ]$WarrantyPhase)) {
    ncdata[i, ]$WarrantyPhase <- TRUE
    if (! (grepl(ncdata[i, ]$`NC Equipment Phase`, "Warranty", fixed= TRUE) || 
           grepl(ncdata[i, ]$`NC Equipment Phase`, "Contract", fixed= TRUE)) ) {
      count_mismatch <- count_mismatch + 1
    }
  }
}

# 60 mismatches. So the NC Equipment Phase could just be used in the further analysis.

ncdata_warranty <- ncdata%>% drop_na(WarrantyPhase)
ncdata_warranty$"WarrantyDays" <- NA
#for (i in 1:nrow(ncdata_warranty)) {
 # if (!is.na(ncdata_warranty[i,]$WarrantyPhase)) {
  #  if (ncdata_warranty[i,]$WarrantyPhase == 0)
   #     ncdata_warranty <- ncdata_warranty[-i,]
  #}
#}