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




