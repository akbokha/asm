#Op dezelfde manier als Low Nr of Categories maar dan voor medium
#standaard packages: data.table, plyr, plotly
#Bouwt voor op bestanden 'Bar_Chart_Generator'
#en 'Nr categorien per attribuut'
High_Vector <- unlist((High_Nr_Categories[,1]))
ncdata_highcategories <- ncdata[High_Vector]

#bar chart generator applyen op al deze kolommen
apply(ncdata_highcategories, MARGIN = 2, FUN = function(x) Standard_Bar_NC(x))
#Resultaten heb ik elders opgeslagen
